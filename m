Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262969AbUJ1LeT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262969AbUJ1LeT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 07:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262974AbUJ1LeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 07:34:19 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:48330 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262969AbUJ1LeN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 07:34:13 -0400
Date: Thu, 28 Oct 2004 13:34:02 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
cc: linux-kernel@vger.kernel.org, uclibc@uclibc.org
Subject: Re: Swap strangeness: total VIRT ~23mb for all processes, swap 91156k
 used - impossible?
In-Reply-To: <200410281419.03100.vda@port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.53.0410281330030.12977@yvahk01.tjqt.qr>
References: <200410281333.53976.vda@port.imtp.ilyichevsk.odessa.ua>
 <Pine.LNX.4.53.0410281257340.19784@yvahk01.tjqt.qr>
 <200410281419.03100.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>I think VIRT is a total virtual space taken by process, part of
>which may be swapped. VIRT can't be reduced by swapping out -
>correct me if I'm wrong.

I always went by:
 VIRT = RES + SWAPPED OUT

$ ps aufwwx | grep mingetty
#user pid %cpu %mem   vsz  rsz
root 2490  0.0  0.2  1548  552 tty1     Ss+  Oct25   0:00 /sbin/mingetty tty1
$ swapoff -a ## for fun
$ ps aufwwx | grep mingetty
root 2490  0.0  0.2  1548  632 tty1     Ss+  Oct25   0:00 /sbin/mingetty tty1

So to say, VIRT = RES + SHR + SWAPPED OUT, probably.

>But I believe even if I'm wrong on that, I simply do not have
>90 mbytes to be swapped out here!

Have <= 128 MB RAM? Have a heavy busy system (even with >= 128)?

># ldd supervise
>        not a dynamic executable
># ls -l supervise
>-rwxr-xr-x  1 root root  9668 Oct 19 06:48 supervise

Ph... you're missing upx -9 on supervise ;)


>I think I will lose "it's impossible" argument,
>because all processes will be more than 1 mbyte in VIRT.

Remember that glibc might be shared amongst processes, so *each* process will
have the 1 mb listed, though swap might stay at 0 if there is nothing else
which causes swapping.



Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
