Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932338AbVKGTwk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338AbVKGTwk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 14:52:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932352AbVKGTwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 14:52:40 -0500
Received: from smtp.osdl.org ([65.172.181.4]:39398 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932338AbVKGTwj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 14:52:39 -0500
Date: Mon, 7 Nov 2005 11:52:10 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Cc: linux-kernel@vger.kernel.org, Steven French <sfrench@us.ibm.com>,
       matthieu castet <castet.matthieu@free.fr>, Greg KH <greg@kroah.com>,
       Vojtech Pavlik <vojtech@suse.cz>,
       Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: 2.6.14-mm1
Message-Id: <20051107115210.33e4f0bf.akpm@osdl.org>
In-Reply-To: <436F7DAA.8070803@ums.usu.ru>
References: <20051106182447.5f571a46.akpm@osdl.org>
	<436F7DAA.8070803@ums.usu.ru>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Alexander E. Patrakov" <patrakov@ums.usu.ru> wrote:
>
> Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14/2.6.14-mm1/
> 
> This has the following issues:
> 
> 1)   CC [M]  fs/cifs/cifsfs.o
> fs/cifs/cifsfs.c:409: warning: `cifs_umount_begin' defined but not used

I think that wants the `#if 0' treatment.


> 2) The PS/2 keyboard death on ppp traffic is still not fixed. 
> Reproducible even on slow GPRS if there's something else (e.g. glxgears) 
> that eats some CPU time. When keyboard is dead, events/0 consomes 100% 
> of CPU. Nothing in dmesg. If you outline some suspicious pieces of code, 
> I will insert printks there in order to debug this.

input guys cc'ed.

> 3) There are some differences with dmesg of the vanilla 2.6.14. Could 
> you please explain this (- = 2.6.14, + = 2.6.14-mm1)?
> 
> -pnp: PnP ACPI: found 11 devices
> +pnp: PnP ACPI: found 12 devices
> 
> The command line parameters "noapic pci=noacpi" are present, and that's 
> a VIA motherboard, if that's relevant.

Don't know.  Matthieu cc'ed.  Did any new devices appear in dmesg? 
/proc/devices?

> 4) I also decided to test new input hotplug. Below is the udevmonitor 
> trace of uevents when I rmmod and modprobe again the psmouse driver. 
> <NULL>s don't look right there. Is the rest OK?
> 
> UEVENT[1131378684] remove@/class/input/input1/mouse0
> ACTION=remove
> DEVPATH=/class/input/input1/mouse0
> SUBSYSTEM=input
> SEQNUM=903
> PHYSDEVPATH=/devices/platform/i8042/serio0
> PHYSDEVBUS=serio
> PHYSDEVDRIVER=psmouse
> MAJOR=13
> MINOR=32
> 
> UEVENT[1131378684] remove@/class/input/input1
> ACTION=remove
> DEVPATH=/class/input/input1
> SUBSYSTEM=input
> SEQNUM=904
> PHYSDEVPATH=/devices/platform/i8042/serio0
> PHYSDEVBUS=serio
> PHYSDEVDRIVER=psmouse
> PRODUCT=11/2/4/0
> NAME="GenPS/2 Genius <NULL>"
> PHYS="isa0060/serio1/input0"
> UNIQ="<NULL>"
> EV=7
> KEY=1f0000 0 0 0 0 0 0 0 0
> REL=103

Hopefully Greg can tell us?
