Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262561AbVCXPNi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262561AbVCXPNi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 10:13:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262558AbVCXPNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 10:13:38 -0500
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:23045 "EHLO
	roarinelk.homelinux.net") by vger.kernel.org with ESMTP
	id S262526AbVCXPNH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 10:13:07 -0500
Message-ID: <4242D8FE.4080607@roarinelk.homelinux.net>
Date: Thu, 24 Mar 2005 16:13:02 +0100
From: Manuel Lauss <mano@roarinelk.homelinux.net>
User-Agent: Thunderbird/1.0 Mnenhy/0.7
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stefano Rivoir <s.rivoir@gts.it>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc1-mm2
References: <20050324044114.5aa5b166.akpm@osdl.org> <200503241540.33012.s.rivoir@gts.it>
In-Reply-To: <200503241540.33012.s.rivoir@gts.it>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefano Rivoir wrote:
> Alle 13:41, giovedì 24 marzo 2005, Andrew Morton ha scritto:
> 
>>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc1/2.
>>6.12-rc1-mm2/
> 
> 
>>- Some fixes for the recent DRM problems.
> 
> 
> Hi Andrew,
> 
> While I was OK with DRM up to 2.6.12-rc1-mm1, now I get this at startup, and 
> Xorg fails to enable DRI (attached, lspci and .config):
> 
> Unable to handle kernel paging request at virtual address 72ff64d7
>  printing eip:
> e087eb44
> *pde = 00000000
> Oops: 0002 [#1]
> PREEMPT
> Modules linked in: radeon drm sd_mod scsi_mod lp hotkey fan container button 
> ide_cd 8250_pnp parport_pc parport floppy pcspkr sk98lin yenta_socket 
> rsrc_nonstatic pcmcia_core ehci_hcd usbhid ohci_hcd snd_intel8x0m 8250_pci 
> 8250 serial_core ohci1394 ieee1394 sis_agp agpgart vfat fat video thermal 
> processor ac battery snd_intel8x0 snd_ac97_codec snd_pcm_oss snd_mixer_oss 
> snd_pcm snd_timer snd soundcore snd_page_alloc skge evdev
> CPU:    0
> EIP:    0060:[<e087eb44>]    Not tainted VLI
> EFLAGS: 00013286   (2.6.12-rc1-mm2)
> EIP is at agp_find_bridge+0x0/0xffffc77f [agpgart]
> eax: dff1d000   ebx: de228400   ecx: 00000000   edx: 000000d0
> esi: dd860000   edi: de228450   ebp: e1a4bd90   esp: dd811f48
> ds: 007b   es: 007b   ss: 0068
> Process modprobe (pid: 4698, threadinfo=dd810000 task=dfca3030)
> Stack: e1a085fb dd860000 00000000 e1a4c240 e1a06ed0 dd860000 e1a4c240 dff1d000
>        dd860000 e1a071ce e1a4c240 c01abfaf e1a4bd90 dff1d000 e1a4c240 00000310
>        e1a03adf ffffffff 00000000 00000310 fffffffc e1a4e180 dd810000 dd810000
> Call Trace:
>  [<e1a085fb>] drm_agp_init+0x3b/0xb0 [drm]
>  [<e1a06ed0>] drm_fill_in_dev+0xf0/0x1b0 [drm]
>  [<e1a071ce>] drm_get_dev+0x4e/0xc0 [drm]
>  [<c01abfaf>] kobject_get+0xf/0x20
>  [<e1a03adf>] drm_init+0x6f/0xb0 [drm]
>  [<c0130589>] sys_init_module+0x139/0x1e0
>  [<c0102fdb>] sysenter_past_esp+0x54/0x75
> Code: 6e 66 69 67 5f 62 79 74 65 00 61 67 70 5f 70 75 74 5f 62 72 69 64 67 65 
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 65 00 <c0> a7 87 e0 dc 94 
> cd de dc 94 cd de 00 00 00 00 00 00 00 00 00

I get a similar Oops at boot; I noticed this warning during compilation:

drivers/char/drm/drm_agpsupport.c: In function `drm_agp_init':
drivers/char/drm/drm_agpsupport.c:391: warning: implicit declaration of function `agp_find_bridge'
drivers/char/drm/drm_agpsupport.c:391: warning: assignment makes pointer from integer without a cast

I dont know what header to include/modify to make it go away.
DRM and AGP are compiled into the kernel (no modules).

-- 
 Manuel Lauss

