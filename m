Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932105AbVLSOpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbVLSOpX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 09:45:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932117AbVLSOpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 09:45:23 -0500
Received: from moutvdom.kundenserver.de ([212.227.126.249]:63732 "EHLO
	moutvdomng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932105AbVLSOpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 09:45:21 -0500
Message-ID: <43A6C780.5070000@anagramm.de>
Date: Mon, 19 Dec 2005 15:45:20 +0100
From: Clemens Koller <clemens.koller@anagramm.de>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: IDE: PDC20275 turning on/off DMA dangerous?
References: <43A2DE5F.7060108@anagramm.de> <58cb370e0512190440p3889a489sbc82f0c482fd9db9@mail.gmail.com>
In-Reply-To: <58cb370e0512190440p3889a489sbc82f0c482fd9db9@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Bartolmiej!

>>I am working on an embedded ppc (mpc8540) using a pretty common Promise IDE
>>PCI controller w/ a PDC20275 on it (it's called Ultra TX2).
>>I have an otherwise good Maxtor 6B120P0 (160GB) connected to it.
>>
>>But sometimes (expecially with more than zero disk-i/o-load), when I
>>turn on DMA by
>>
>>$hdparm -X69 -d1 /dev/hda
>>I get
>>
>>hda: task_out_intr: status=0x58 { DriveReady SeekComplete DataRequest }
>>ide: failed opcode was: unknown
>>hda: CHECK for good STATUS
>>
>>And when I turn off DMA with
>>$hdparm -d0 /dev/hda
>>I get sometimes a
>>
>>hda: DMA disabled
>>
>>which is fine but sometimes I also get:
>>
>>hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
>>ide: failed opcode was: unknown
>>hda: drive not ready for command
>>hda: CHECK for good STATUS
>>
>>which is not so nice.
>>Can you tell me if this is dangerous?
> 
> 
> Is there any particular reason why you are using hdparm with '-d' and '-X'?

I want to test it with DMA before fixing it into the kernel.

> Your IDE host driver (pdc202xx_new in this case) should configure
> best xfer mode and enable DMA so you shouldn't need to use hdparm.

I didn't enable automatic turning on of DMA it in the kernel by default
in the past because I had problems with this hdd controller and
interrupts (some PCI IRQ mapping issues). The interrupt issues are
solved now, so I've tried to enable DMA. DMA works pretty fine,
I was just worried about the severity of the message. It doesn't
really tell anything useful for non-ide-hackers. (whether it's
dangerous or not.)

> Given that IDE driver code for changing xfer mode and DMA setting
> is racy and actually quite hard to fix, it will probably be removed in
> the future (after auditing IDE host drivers).

So, I guess the answer is: DMA itself seems to work and it
isn't really dangerous - it's working as it's supposed to.
But if you do it the way you do, you can run into problems due
to races. Right? So, if I enable DMA as usual in the kernel,
I don't usually risk my data?!

> BTW please use linux-ide@vger.kernel.org for IDE problems

Okay, in next thread.

Thanks,
-- 
Clemens Koller
_______________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Str. 45/1
81379 Muenchen
Germany

http://www.anagramm.de
Phone: +49-89-741518-50
Fax: +49-89-741518-19
