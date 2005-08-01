Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262192AbVHAOjd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262192AbVHAOjd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 10:39:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262211AbVHAOj0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 10:39:26 -0400
Received: from osten.wh.uni-dortmund.de ([129.217.129.130]:50386 "EHLO
	osten.wh.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262225AbVHAOit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 10:38:49 -0400
Message-ID: <42EE33F6.6040606@web.de>
Date: Mon, 01 Aug 2005 16:38:46 +0200
From: Alexander Fieroch <fieroch@web.de>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050611)
X-Accept-Language: de-de, en-us, en
MIME-Version: 1.0
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Michael Thonke <iogl64nx@gmail.com>, linux-kernel@vger.kernel.org,
       Jesper Juhl <jesper.juhl@gmail.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, bzolnier@gmail.com, axboe@suse.de,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Natalie.Protasevich@unisys.com, Andrew Morton <akpm@osdl.org>,
       Parag Warudkar <kaernel-stuff@comcast.net>,
       Alexander Fieroch <fieroch@web.de>
Subject: Re: PROBLEM: "drive appears confused" and "irq 18: nobody cared!"
References: <d6gf8j$jnb$1@sea.gmane.org> <42EAAFD4.4010303@web.de> <42EAD086.4010904@gmail.com> <200507291905.37339.kernel-stuff@comcast.net> <20050730014237.GA20131@mipter.zuzino.mipt.ru>
In-Reply-To: <20050730014237.GA20131@mipter.zuzino.mipt.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Dobriyan wrote:
> --- 2.6.12-r4.txt			[1]
> +++ 2.6.12-r6.txt			[2]
> +1003_linux-2.6.12.3.patch	<-----------------------+
> +1370_sparc-modpost_stt_reg.patch			|
> -1900_acpi-irq-0.patch			included in ----+

no change with 2.6.12.3

> +2700_irqpoll.patch			[3]
> [3] http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff_plain;h=200803dfe4ff772740d63db725ab2f1b185ccf92;hp=21fe3471c3aaa5c489c5d3a4d705291eb7511248

here is the current status with kernel 2.6.13rc4-git4 and kernel 
parameters "pci=routeirq apic=debug acpi=debug irqpoll".

It's working better - there is only one "nobody cared" message and only 
a few lines "drive appears confused" for hdb and hde in syslog. Both of 
them are cdrom drives. I also have hda and hdh, what are harddisk drives 
and where the error does not occur. Perhaps this could help you?
A small test copying files from hda/hdh to /tmp is working - so this 
problem seems to be fixed. Moreover I did not recognize the error...

---------------
hda: dma_timer_expiry: dma status == 0x64
hda: DMA interrupt recovery
hda: lost interrupt
---------------

...anymore.
Copying files from cdrom hdb to /tmp I get continually following errors 
in syslog:

---------------
hdb: media error (bad sector): status=0x51 { DriveReady SeekComplete Error }
hdb: media error (bad sector): error=0x30 { LastFailedSense=0x03 }
ide: failed opcode was: unknown
end_request: I/O error, dev hdb, sector 1306960
Buffer I/O error on device hdb, logical block 326740
---------------

I get the same errors when I try to copy files from my dvdrom hde to 
/tmp. There is still something broken.

Regards,
Alexander


