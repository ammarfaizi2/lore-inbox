Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268354AbUHQRzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268354AbUHQRzW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 13:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268360AbUHQRzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 13:55:21 -0400
Received: from fw.osdl.org ([65.172.181.6]:38339 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268354AbUHQRzL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 13:55:11 -0400
Date: Tue, 17 Aug 2004 10:53:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: vatsa@in.ibm.com
Cc: nathanl@austin.ibm.com, linux-kernel@vger.kernel.org, zwane@linuxpower.ca,
       rusty@rustcorp.com.au, Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.8.1-mm1
Message-Id: <20040817105322.6f596061.akpm@osdl.org>
In-Reply-To: <20040817113839.GB7005@in.ibm.com>
References: <20040816143710.1cd0bd2c.akpm@osdl.org>
	<1092722342.3081.68.camel@booger>
	<20040817113839.GB7005@in.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srivatsa Vaddagiri <vatsa@in.ibm.com> wrote:
>
> I found this to be due to task leak in exit code. In release_task:
> 
>  	a. Task is removed from task-list (unhash_process)
>  	b. More processing is done (like proc_pid_flush etc)
>  	   before task finally dies.
> 
>  The problem is the task can get preempted between a and b.

It seems wrong that a task can be preempted so late in its lifetime.  We're
just asking for nasty bugs by permitting that.
