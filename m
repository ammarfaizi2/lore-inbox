Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131375AbRCNOYF>; Wed, 14 Mar 2001 09:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131371AbRCNOX4>; Wed, 14 Mar 2001 09:23:56 -0500
Received: from dns.growzone.com.au ([202.9.32.33]:64266 "EHLO
	mail.growzone.com.au") by vger.kernel.org with ESMTP
	id <S131364AbRCNOXo>; Wed, 14 Mar 2001 09:23:44 -0500
Message-Id: <200103141422.f2EEMvI20712@gandalf.growzone.com.au>
To: mshiju@in.ibm.com
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
X-Face: ]IrGs{LrofDtGfsrG!As5=G'2HRr2zt:H>djXb5@v|Dr!jOelxzAZ`!}("]}]
	Q!)1w#X;)nLlb'XhSu,QL>;)L/l06wsI?rv-xy6%Y1e"BUiV%)mU;]f-5<#U6
	UthZ0QrF7\_p#q}*Cn}jd|XT~7P7ik]Q!2u%aTtvc;)zfH\:3f<[a:)M
Organization: GrowZone OnLine
X-Mailer: nmh-1.0.4 exmh-2.2
X-OS: Linux-2.4.0 RedHat 7.0
Subject: Re: ISAPNP :driver not recognized when compiled in kernel 
In-Reply-To: message-id <CA256A0F.004A726A.00@d73mta05.au.ibm.com> 
	 of Wed, Mar 14 18:35:13 2001
Date: Thu, 15 Mar 2001 00:22:56 +1000
From: Tony Nugent <tony@growzone.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Mar 14 2001 at 18:35, mshiju@in.ibm.com wrote:

> module. I read somewhere that ISAPNP drivers with ISAPNP enabled in kernel
> should only be build as modules so that we can keep the order of execution
> . Is this true.? Have any one of you tried this .

I'd believe what you have read.

The general philosphy is that most device drivers are almost always
best built and made available as modules.

Besides, there really are distinct advantages in being able to
unload device drivers at runtime (eg, you can reconfigure the IRQ or
dma etc for the driver by simply unloading and reloading it -
without otherwise resorting to a system reboot which would be the
case if the driver was compiled into the kernel itself).

If you need to load any device drivers before actually booting the
kernel itself (eg, an nfsroot kernel which needs an ethernet
driver), then that problem is solved by creating (and making
available with lilo or bootp or whatever) an initrd image that can
preload the device drivers it needs before actually attempting to
mount the root filesystem.  (Fairly easy to do this with something
like redhat's mkinitrd utility).

Cheers
Tony
 -=*#*=-=*#*=-=*#*=-=*#*=-=*#*=-=*#*=-=*#*=-=*#*=-=*#*=-=*#*=-=*#*=-
  Tony Nugent <Tony@growzone.com.au>    Systems Administrator, RHCE
  LinuxWorks - PO Box 5747 Gold Coast MC Queensland Australia  9726
  Ph: (07) 5526 8020                           Mobile: 0408 066 336
 -=*#*=-=*#*=-=*#*=-=*#*=-=*#*=-=*#*=-=*#*=-=*#*=-=*#*=-=*#*=-=*#*=-
