Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262990AbUJ1Lvh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262990AbUJ1Lvh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 07:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262994AbUJ1Lso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 07:48:44 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:36108 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262985AbUJ1LpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 07:45:01 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: Swap strangeness: total VIRT ~23mb for all processes, swap 91156k used - impossible?
Date: Thu, 28 Oct 2004 14:44:53 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, uclibc@uclibc.org
References: <200410281333.53976.vda@port.imtp.ilyichevsk.odessa.ua> <200410281419.03100.vda@port.imtp.ilyichevsk.odessa.ua> <Pine.LNX.4.53.0410281330030.12977@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.53.0410281330030.12977@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410281444.53443.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 October 2004 14:34, Jan Engelhardt wrote:
> >I think VIRT is a total virtual space taken by process, part of
> >which may be swapped. VIRT can't be reduced by swapping out -
> >correct me if I'm wrong.
> 
> I always went by:
>  VIRT = RES + SWAPPED OUT
> 
> $ ps aufwwx | grep mingetty
> #user pid %cpu %mem   vsz  rsz
> root 2490  0.0  0.2  1548  552 tty1     Ss+  Oct25   0:00 /sbin/mingetty tty1
> $ swapoff -a ## for fun
> $ ps aufwwx | grep mingetty
> root 2490  0.0  0.2  1548  632 tty1     Ss+  Oct25   0:00 /sbin/mingetty tty1
> 
> So to say, VIRT = RES + SHR + SWAPPED OUT, probably.
> 
> >But I believe even if I'm wrong on that, I simply do not have
> >90 mbytes to be swapped out here!
> 
> Have <= 128 MB RAM? Have a heavy busy system (even with >= 128)?

128mb. System was idle, fresh after boot.

Seems I wasn't clear enough. I will try harder now:

Even if I add up size of every process, *counting libc shared pages
once per process* (which will overestimate memory usage), I arrive at
23mb *total memory required by all processes*. How come kernel
found 90mb to swap out? There is NOTHING to swap out except those
23mb!

(Of course when oom_trigger was running, kernel first swapped out
those 23mb and then started swapping out momery taken by oom_trigger
itself, but when oom_trigger was killed, its RAM *and* swapspace
should be deallocated. Thus I expected to see ~20 mb swap usage).
--
vda

