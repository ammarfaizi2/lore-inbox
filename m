Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932091AbVKFPmi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbVKFPmi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 10:42:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932096AbVKFPmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 10:42:38 -0500
Received: from asclepius3.uwa.edu.au ([130.95.128.60]:19666 "EHLO
	asclepius.uwa.edu.au") by vger.kernel.org with ESMTP
	id S932091AbVKFPmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 10:42:37 -0500
X-UWA-Client-IP: 130.95.13.9 (UWA)
Date: Sun, 6 Nov 2005 23:42:25 +0800
From: Bernard Blackham <bernard@blackham.com.au>
To: serue@us.ibm.com
Cc: Ed Tomlinson <tomlins@cam.org>, lokum spand <lokumsspand@hotmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: A possible idea for Linux: Save running programs to disk
Message-ID: <20051106154225.GA26745@ucc.gu.uwa.edu.au>
References: <BAY105-F35A25DA28443029610815DA48E0@phx.gbl> <20051002045315.GA20946@ucc.gu.uwa.edu.au> <200510020857.27065.tomlins@cam.org> <20051002141637.GC5211@blackham.com.au> <20051010011304.GA28223@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051010011304.GA28223@sergelap.austin.ibm.com>
Organization: Dagobah Systems
User-Agent: Mutt/1.5.10i
X-SpamTest-Info: Profile: Formal (278/051031)
X-SpamTest-Info: Profile: Detect Hard [UCS 290904]
X-SpamTest-Info: Profile: SysLog
X-SpamTest-Info: Profile: Marking Spam - Subject (UCS) [02-08-04]
X-SpamTest-Status: Not detected
X-SpamTest-Version: SMTP-Filter Version 2.0.0 [0125], KAS/Release
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies for the delay.

On Sun, Oct 09, 2005 at 08:13:04PM -0500, serue@us.ibm.com wrote:
> Quoting Bernard Blackham (bernard@blackham.com.au):
> >    Some way to request a given PID when cloning/forking (or on the
> >    fly even) would make life easier.
> 
> Have you considered any ways of implementing this?  Perhaps the simplest
> way would actually be to allow a process set to be started in some kind
> of job/jail/container/vserver, where any userspace query of or by pid
> uses the virtual pid - which might collide with a virtual pid in some
> other container - but of course the kernel continues to track by real
> pids.  So pid 3728 may be vpid 2287 in job 3.  A process inside job 3
> just asks to kill -9 2287, whereas a process not in a job must ask to
> kill pid 3728, and a process in job 2 can't touch tasks in job 3.  Is
> there another way this could work?

I did try this once by having a 'supervisor' process ptrace every
resumed process and translate PIDs inside system calls, but this got
very messy very fast - particularly for terminal ioctls.
Additionally, it means parents can't get notification of when their
children die, and it makes the whole show just that much slower.

Getting them back their original PIDs seems like less effort (so
long as they're available).  I'm probably shouldn't admit to what
I'm currently doing - editing last_pid through /dev/kmem, to force
the next pid fork() returns. (Unbelievably racy, but works as a
temporary measure).

Bernard.

