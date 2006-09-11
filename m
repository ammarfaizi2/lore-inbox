Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751271AbWIKRZQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbWIKRZQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 13:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751273AbWIKRZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 13:25:16 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:50316 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751261AbWIKRZO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 13:25:14 -0400
Subject: Re: [PATCH] vt: Make vt_pid a struct pid (making it pid wrap
	around safe).
From: Dave Hansen <haveblue@us.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Containers <containers@lists.osdl.org>,
       linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>
In-Reply-To: <m1u03fevvz.fsf@ebiederm.dsl.xmission.com>
References: <m1u03fevvz.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Mon, 11 Sep 2006 10:24:50 -0700
Message-Id: <1157995490.26324.106.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-09-10 at 06:41 -0600, Eric W. Biederman wrote:
> 
> -               vc->vt_pid = current->pid;
> +               put_pid(xchg(&vc->vt_pid, get_pid(task_pid(current)))); 

Would it make any sense to have a get_current_pid()?  It might reduce
the horribly confusing number of parenthesis there.

-- Dave

