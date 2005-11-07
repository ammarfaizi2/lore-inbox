Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964858AbVKGQRj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964858AbVKGQRj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 11:17:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964860AbVKGQRj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 11:17:39 -0500
Received: from relay4.usu.ru ([194.226.235.39]:27553 "EHLO relay4.usu.ru")
	by vger.kernel.org with ESMTP id S964858AbVKGQRi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 11:17:38 -0500
Message-ID: <436F7DAA.8070803@ums.usu.ru>
Date: Mon, 07 Nov 2005 21:15:38 +0500
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-mm1
References: <20051106182447.5f571a46.akpm@osdl.org>
In-Reply-To: <20051106182447.5f571a46.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.15; AVE: 6.32.0.58; VDF: 6.32.0.154; host: usu2.usu.ru)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14/2.6.14-mm1/

This has the following issues:

1)   CC [M]  fs/cifs/cifsfs.o
fs/cifs/cifsfs.c:409: warning: `cifs_umount_begin' defined but not used

2) The PS/2 keyboard death on ppp traffic is still not fixed. 
Reproducible even on slow GPRS if there's something else (e.g. glxgears) 
that eats some CPU time. When keyboard is dead, events/0 consomes 100% 
of CPU. Nothing in dmesg. If you outline some suspicious pieces of code, 
I will insert printks there in order to debug this.

3) There are some differences with dmesg of the vanilla 2.6.14. Could 
you please explain this (- = 2.6.14, + = 2.6.14-mm1)?

-pnp: PnP ACPI: found 11 devices
+pnp: PnP ACPI: found 12 devices

The command line parameters "noapic pci=noacpi" are present, and that's 
a VIA motherboard, if that's relevant.

4) I also decided to test new input hotplug. Below is the udevmonitor 
trace of uevents when I rmmod and modprobe again the psmouse driver. 
<NULL>s don't look right there. Is the rest OK?

UEVENT[1131378684] remove@/class/input/input1/mouse0
ACTION=remove
DEVPATH=/class/input/input1/mouse0
SUBSYSTEM=input
SEQNUM=903
PHYSDEVPATH=/devices/platform/i8042/serio0
PHYSDEVBUS=serio
PHYSDEVDRIVER=psmouse
MAJOR=13
MINOR=32

UEVENT[1131378684] remove@/class/input/input1
ACTION=remove
DEVPATH=/class/input/input1
SUBSYSTEM=input
SEQNUM=904
PHYSDEVPATH=/devices/platform/i8042/serio0
PHYSDEVBUS=serio
PHYSDEVDRIVER=psmouse
PRODUCT=11/2/4/0
NAME="GenPS/2 Genius <NULL>"
PHYS="isa0060/serio1/input0"
UNIQ="<NULL>"
EV=7
KEY=1f0000 0 0 0 0 0 0 0 0
REL=103

UEVENT[1131378684] remove@/bus/serio/drivers/psmouse
ACTION=remove
DEVPATH=/bus/serio/drivers/psmouse
SUBSYSTEM=drivers
SEQNUM=905

UEVENT[1131378684] remove@/module/psmouse
ACTION=remove
DEVPATH=/module/psmouse
SUBSYSTEM=module
SEQNUM=906

UEVENT[1131378691] add@/module/psmouse
ACTION=add
DEVPATH=/module/psmouse
SUBSYSTEM=module
SEQNUM=907

UEVENT[1131378691] add@/bus/serio/drivers/psmouse
ACTION=add
DEVPATH=/bus/serio/drivers/psmouse
SUBSYSTEM=drivers
SEQNUM=908

UEVENT[1131378691] add@/class/input/input2
ACTION=add
DEVPATH=/class/input/input2
SUBSYSTEM=input
SEQNUM=909
PHYSDEVPATH=/devices/platform/i8042/serio0
PHYSDEVBUS=serio
PHYSDEVDRIVER=psmouse
PRODUCT=11/2/4/0
NAME="GenPS/2 Genius <NULL>"
PHYS="isa0060/serio1/input0"
UNIQ="<NULL>"
EV=7
KEY=1f0000 0 0 0 0 0 0 0 0
REL=103

UEVENT[1131378691] add@/class/input/input2/mouse0
ACTION=add
DEVPATH=/class/input/input2/mouse0
SUBSYSTEM=input
SEQNUM=910
PHYSDEVPATH=/devices/platform/i8042/serio0
PHYSDEVBUS=serio
PHYSDEVDRIVER=psmouse
MAJOR=13
MINOR=32

-- 
Alexander E. Patrakov
