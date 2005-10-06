Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751244AbVJFRX5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbVJFRX5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 13:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbVJFRX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 13:23:56 -0400
Received: from xproxy.gmail.com ([66.249.82.206]:43752 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751244AbVJFRX4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 13:23:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ZMWMUCIKyLkqmTDZbqp+iG/MSLEf000SLqLnNhjbM+cR7qX+6WNWs7pCapst74rj6cpOvdU1rvFc+AGi0eIFoaJ4YKqw17gjUNZjZ2CGbjTGw6aIkvMqI6akSE/9VNfSJi7gy7YV/GlJykOihqMahhQfCG38ODPAhzjrXKISPWo=
Message-ID: <d93f04c70510061023i7a4f0148v7198982b409106d1@mail.gmail.com>
Date: Thu, 6 Oct 2005 19:23:53 +0200
From: Hendrik Visage <hvjunk@gmail.com>
Reply-To: Hendrik Visage <hvjunk@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Debug: sleeping function called from invalid context at include/linux/rwsem.h:66
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been seeing these since around 2.6.11, but I suspected the gentoo-sources
and some nVidia errors, however, today I noticed it on a "clean" (except for the
starfire fixes discussed elsewhere) 2.6.14-rc2, and also with the
Intel 810 sound
driver :(

uname -a: Linux swarte-vlos 2.6.14-rc2 #7 PREEMPT Sun Oct 2 23:38:14
SAST 2005 x86_64 AMD Athlon(tm) 64 Processor 3000+ AuthenticAMD
GNU/Linux

dmesg  snippet:

Debug: sleeping function called from invalid context at include/linux/rwsem.h:66
in_atomic():1, irqs_disabled():0

Call Trace:<ffffffff8012db7f>{__might_sleep+191}
<ffffffff80120df2>{change_page_attr_addr+50}
       <ffffffff80120291>{ioremap_change_attr+81}
<ffffffff8012092f>{iounmap+143}
       <ffffffff88572385>{:nvidia:os_unmap_kernel_space+9}
       <ffffffff88373905>{:nvidia:_nv002010rm+101}
<ffffffff884a9f0c>{:nvidia:_nv004040rm+102}
       <ffffffff8849ce75>{:nvidia:_nv004588rm+145}
<ffffffff8849c8e1>{:nvidia:_nv004386rm+99}
       <ffffffff88376775>{:nvidia:_nv001419rm+251}
<ffffffff88379a23>{:nvidia:rm_shutdown_adapter+99}
       <ffffffff8856e8a9>{:nvidia:nv_kern_close+239}
<ffffffff801778ea>{__fput+202}
       <ffffffff801779f3>{fput+19} <ffffffff80175fce>{filp_close+110}
       <ffffffff80176088>{sys_close+168} <ffffffff8010eabe>{system_call+126}

agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V3 device at 0000:00:00.0 into 8x mode
agpgart: Putting AGP V3 device at 0000:01:00.0 into 8x mode
ACPI: PCI interrupt for device 0000:02:08.0 disabled
Debug: sleeping function called from invalid context at include/linux/rwsem.h:66
in_atomic():1, irqs_disabled():0

Call Trace:<ffffffff8012db7f>{__might_sleep+191}
<ffffffff80120df2>{change_page_attr_addr+50}
       <ffffffff80120291>{ioremap_change_attr+81}
<ffffffff8012092f>{iounmap+143}
       <ffffffff88199b43>{:snd_intel8x0:snd_intel8x0_free+243}
       <ffffffff88199f2d>{:snd_intel8x0:snd_intel8x0_dev_free+13}
       <ffffffff88145103>{:snd:snd_device_free+131}
<ffffffff8814535b>{:snd:snd_device_free_all+75}
       <ffffffff8814072d>{:snd:snd_card_free+349}
<ffffffff8034e1a4>{_spin_unlock_irq+20}
       <ffffffff8034ca18>{wait_for_completion+248}
<ffffffff80265f35>{put_device+21}
       <ffffffff80267fa0>{klist_devices_put+16}
<ffffffff8034bcd2>{klist_release+98}
       <ffffffff8034bc70>{klist_release+0}
<ffffffff8819b0f9>{:snd_intel8x0:snd_intel8x0_remove+25}
       <ffffffff8020196f>{pci_device_remove+47}
<ffffffff80267bc1>{__device_release_driver+113}
       <ffffffff80267d08>{driver_detach+168}
<ffffffff80267544>{bus_remove_driver+148}
       <ffffffff80268045>{driver_unregister+21}
<ffffffff80201820>{pci_unregister_driver+32}
       <ffffffff8819b120>{:snd_intel8x0:alsa_card_intel8x0_exit+16}
       <ffffffff8014dd23>{sys_delete_module+547}
<ffffffff8010eabe>{system_call+126}


--
Hendrik Visage
