Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265768AbUBPQO0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 11:14:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265777AbUBPQO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 11:14:26 -0500
Received: from moutng.kundenserver.de ([212.227.126.189]:59867 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S265768AbUBPQOW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 11:14:22 -0500
Message-ID: <4030EC43.90605@paceblade.com>
Date: Mon, 16 Feb 2004 17:13:55 +0100
From: Robert Woerle <robert@paceblade.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.6) Gecko/20040113
X-Accept-Language: de, en, de-at, en-us
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: linux-kernel@vger.kernel.org
Subject: Re: serial.c - start looking from 0x220 iomem_base  ??
References: <402CE89F.9060404@paceblade.com> <Pine.LNX.4.53.0402131025120.4338@chaos>
In-Reply-To: <Pine.LNX.4.53.0402131025120.4338@chaos>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:b4ac6117e991eeeca15f2be66d9fb0df
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Richard B. Johnson schrieb:

>On Fri, 13 Feb 2004, Robert Woerle wrote:
>
>  
>
>>Hi
>>
>>I am having here a device  (Tablet PC ) sample with a serial resistive
>>touchscreen  .
>>Under Windows it comes up as COM1 at IO-Base 0x220 -0x227 IRQ 4 .
>>Now it seems that in linux the serial driver doesnt look for so "low"
>>I/O-Base `s .
>>
>>By hacking around by hardcoding the 0x220 somehwere in serial.c i get it
>>to detect a standard 16550 , but
>>unfortunately it then assumes that all ttySX have this base .
>>This is because of my hardcoded hack and the driver not looking for all
>>the rest mem bases.
>>
>>So the quesion is :
>>Where do i tell serial.o  to start lower ( at 0x220 ) to look for
>>controllers .. .??
>>
>>
>>
>>Pls also CC me directly since i am only monitoring this list .
>>    
>>
>
>There are 4 de facto standard serial ports:
>
>COM1	0x3F8	IRQ4
>COM2	0x2F8	IRQ3
>COM3	0x3E8	IRQ4
>COM4	0x2E8	IRQ3
>
>If you have a port at 0x220, it is above the game-port area,
>but not where the kernel should "look for" serial devices.
>Therefore, you don't tell the kernel to, as you state, start
>lower. Instead, you tell the kernel where they are by putting
>them in the pnp_devices[] table.
>
>
>  
>
I tryed that now and added a device  like
ISAPNP_VENDOR('P', 'N', 'P'), ISAPNP_DEVICE(0x0220),

but nothing happens ... it leaves the function saying
<7>"Leaving  probe_serial_pci() (probe finished)

What can i do ?
