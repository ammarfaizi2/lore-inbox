Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262095AbVE1CKv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262095AbVE1CKv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 22:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbVE1CKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 22:10:51 -0400
Received: from fire.osdl.org ([65.172.181.4]:11972 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262095AbVE1CKj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 22:10:39 -0400
Date: Fri, 27 May 2005 19:09:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: C.M.Caldwell@Alumni.UNH.EDU
Cc: linux-kernel@vger.kernel.org, c.m.caldwell@Alumni.UNH.EDU,
       video4linux-list@redhat.com
Subject: Re: Conflict between ntpd system calls and bttv device driver
Message-Id: <20050527190939.6ab0fbb9.akpm@osdl.org>
In-Reply-To: <200505271510.j4RFAHYX010409@mike.caldwell.org>
References: <200505271510.j4RFAHYX010409@mike.caldwell.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(added video4linux-list@redhat.com)

C.M.Caldwell@Alumni.UNH.EDU wrote:
>
> Greetings,
> 
> One line:	Frame grabber times out if ntpd runs with kernel calls
> 
> Full:		We run the bttv frame grabber on a Dell-2600 running
> 		2.6.9-1.667smp (ala Fedora Core 3).  If we run ntpd
> 		normally, after a variable amount of time (seconds to
> 		multiple hours), ioctl(dev,VIDIOC_DQBUF,ptr) returns
> 		EINVAL.  After putting debug writes in the kernel,
> 		we determined that it is because the request timed out
> 		due to the fact that the interupt was blocked by a
> 		higher priority interupt:  the kernel logic for the ntpd
> 		system calls.

Please be more specific.  Where, exactly, did this timeout occur? 
File, line and function name.

Did you consider simply increasing the timeout?

What is ntpd doing to cause interrupts to be delayed for so long?  Does ntpd
rewrite the CMOS clock?

> 		This doesn't happen on all systems (e.g. a Dell-2650 doesn't
> 		seem to have this problem), but it will happen with earlier
> 		versions of the kernel.  Also, the problem occurs even if
> 		you have stopped ntpd and re-loaded the bttv driver.
> 
> 		It may be that this can occur under more circumstances than
> 		outline above but that it is much rarer.  We believe that
> 		the Dell-2600s multiple PCI busses and its interupt structure
> 		may make it much more sensitive to having interupts blocked
> 		for long periods of time.
> 		
> Keywords:	bttv adjtime VIDIOC_DQBUF timeout
> Version:	2.6.9-1.667smp
> 
> Workaround:	Add "disable kernel" to ntp.conf file and reboot
> Oops output:
> Shell script:
> Environment:
> Software:
> Processor:	i686 Genuine Intel 2.8GHZ (Dell-2600)
> Modules:
> Loaded drivers:
> Hardware:
> lspci:
> SCSI:
> 
> Comments:	Considering how easy the work-around for us is, this is
> 		pretty low priority (though it was mighty high until we
> 		figured out that ntpd was the thing hogging the interupts).
> 		I wanted to send this in just to make people aware that
> 		there maybe some timing conflicts.
> 		sure 
