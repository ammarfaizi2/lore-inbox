Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267751AbUJDIiL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267751AbUJDIiL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 04:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267793AbUJDIiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 04:38:11 -0400
Received: from fw.osdl.org ([65.172.181.6]:34691 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267751AbUJDIiF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 04:38:05 -0400
Date: Mon, 4 Oct 2004 01:35:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jason Stubbs <jstubbs@work-at.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Consistent lock up on >=2.6.8
Message-Id: <20041004013548.26e853fc.akpm@osdl.org>
In-Reply-To: <200410041611.17000.jstubbs@work-at.co.jp>
References: <200410041611.17000.jstubbs@work-at.co.jp>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Stubbs <jstubbs@work-at.co.jp> wrote:
>
> I'm getting consistent hangs under heavy load on 2.6.8.1, 2.6.9-rc2 and 
>  2.6.9-rc3. I have tested on 2.6.7 and have no problems at all. I can 
>  reproduce the problem in less than 10 minutes by repeatedly running a cpu 
>  intensive process such as openssl while the system performs its regular 
>  tasks.
> 
>  SysRq works and I was able to pull the registers (which are always very 
>  similar) and the last 50 lines of the task list. If more of the task list is 
>  necessary, I'll go out and buy a serial cable to get it. All information 
>  provided is from 2.6.9-rc3.
> 
> ...
> 
>  Pid: 22433, comm:              openssl
>  EIP: 0060:[<c02d5082>] CPU: 0
>  EIP is at _spin_lock+0xa/0x13
>   EFLAGS: 00000286    Not tainted  (2.6.9-rc3)
>  EAX: c03b2500 EBX: 00000000 ECX: x031ca80 EDX: 00000000
>  ESI: f8b9c926 EDI: ffffffff EBP: c03e1f44 DS: 007b ES: 007b
>  CR0: 8005003b CR2: b7df91df CR3: 3705c000 CR4: 000006d0

Looks like a locking bug.  

>  Stack pointer is garbage, not printing trace

Sigh.  That's exactly the info we wanted.  Please try 2.6.9-rc3-mm1 which
should have that fixed.  Or wait 15 minutes for 2.6.9-rc3-mm2.

Then do the sysrq-P trace again.  You may need to type it a few times.  If
you manage to get a backtrace of the process which is stuck in spin_lock,
that's the info we want.

You may find that all CPUs are stuck in spin_lock().  If so, please send
each CPU's backtrace.  If you have to type it all in, don't worry about the
eight-digit hex numbers.

