Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262941AbUDQQTz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 12:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263993AbUDQQTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 12:19:55 -0400
Received: from peabody.ximian.com ([130.57.169.10]:36252 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262941AbUDQQTx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 12:19:53 -0400
Subject: Re: get_task_struct()
From: Robert Love <rml@ximian.com>
To: Fabiano Ramos <ramos_fabiano@yahoo.com.br>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1082216800.1447.26.camel@slack.domain.invalid>
References: <1082216800.1447.26.camel@slack.domain.invalid>
Content-Type: text/plain
Message-Id: <1082218790.10360.6.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.5 (1.5.5-1) 
Date: Sat, 17 Apr 2004 12:19:50 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-04-17 at 12:46 -0300, Fabiano Ramos wrote:

> Inside sys_ptrace, the function get_task_struct is invoked after
> retrieving the child's task srtuct pointer. Why is it done? I have
> tracked down the code and noticed that it is in fact an increment
> on the (page?) counter. Can you help me understand it? 

Think of get_task_struct(foo) as a reference count on foo's task
structure.  So long as the reference count is elevated, foo's task
structure cannot be deallocated.

get_task_struct() is called here because sys_ptrace() needs to ensure
that the child's task structure does not go away out from under this
function, but we do not want to hold the tasklist_lock.

> Is it necessary to call free_task_struct whenever its get counterpart
> is called?

Yes, although it is called "put_task_struct()".  It is called at the end
of this function.

	Robert Love


