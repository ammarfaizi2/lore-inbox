Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261495AbULAXYw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261495AbULAXYw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 18:24:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbULAXYw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 18:24:52 -0500
Received: from smtp09.auna.com ([62.81.186.19]:54416 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id S261490AbULAXXm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 18:23:42 -0500
Date: Wed, 01 Dec 2004 22:58:55 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: cd burning, capabilities and available modes
To: Bill Davidsen <davidsen@tmr.com>
Cc: "J.A. Magallon" <jamagallon@able.es>,
       Lista Linux-Kernel <linux-kernel@vger.kernel.org>
References: <1101908433l.8423l.0l@werewolf.able.es>
	<41AE47F3.7090502@tmr.com>
In-Reply-To: <41AE47F3.7090502@tmr.com> (from davidsen@tmr.com on Wed Dec  1
	23:38:43 2004)
X-Mailer: Balsa 2.2.6
Message-Id: <1101941935l.7651l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2004.12.01, Bill Davidsen wrote:
> J.A. Magallon wrote:
> > Hi...
> > 
> > Following my little oddisey to let cd-burning easy for my users,
> > I think I have found another problem.
> > 
> > It looks like the formats available to cdrecord depend on being root
> > (cdrecord is not suid, if it is it complains it cant reserve some
> > buffers).
> > 
> > As root:
...
> > Driver flags   : MMC-3 SWABAUDIO BURNFREE 
> > Supported modes: TAO PACKET SAO SAO/R96P SAO/R96R RAW/R16 RAW/R96P RAW/R96R
> > 
> > As user:
> > Driver flags   : MMC-3 SWABAUDIO BURNFREE 
> > Supported modes: 
...
> 
> I get that all the time, because one of my drives doesn't support TAO 
> burning. I suspect your firmware sucks, and you will have to use session 
> at a time rather than track at a time, option "-sao" works for me. Are 
> you running standard cdrecord or one of the hacks?
> 

Look at what I quoted above. It is the same box, just running cdrecord
as root or as user. The 'Supported modes:' line is empty.
What has the firmware to do with that ?

A guess: perhaps the problem is:

WARNING ! Cannot gain SYS_RAWIO capability ! 
: Operation not permitted

as user, so system does not allow the user to query the drive at low
level via some ioctl() or the liketo get the supported modes.

BTW, using the LSM realtime module for group cdwriter (80 in my box)
killed this messages:

cdrecord: Cannot allocate memory. WARNING: Cannot do mlockall(2).
cdrecord: WARNING: This causes a high risk for buffer underruns.
cdrecord: Operation not permitted. WARNING: Cannot set RR-scheduler
cdrecord: Permission denied. WARNING: Cannot set priority using setpriority().
cdrecord: WARNING: This causes a high risk for buffer underruns.

so at least this is good (TM).

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.2 (Cooker) for i586
Linux 2.6.10-rc2-jam4 (gcc 3.4.1 (Mandrakelinux 10.1 3.4.1-4mdk)) #2


