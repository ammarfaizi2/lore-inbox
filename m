Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318393AbSGYKU6>; Thu, 25 Jul 2002 06:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318396AbSGYKU6>; Thu, 25 Jul 2002 06:20:58 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:55823 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S318393AbSGYKU5>;
	Thu, 25 Jul 2002 06:20:57 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Marcin Dalecki <dalecki@evision.ag>
Date: Thu, 25 Jul 2002 12:23:12 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: IDE and CDROM devices (was Re: [IDE bug] hdparm lockup)
CC: lkml <linux-kernel@vger.kernel.org>
X-mailer: Pegasus Mail v3.50
Message-ID: <1A90171BA8@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 Jul 02 at 9:38, Marcin Dalecki wrote:
> Andrew Morton wrote:
> > 
> > /dev/hdc:
> >  HDIO_GETGEO_BIG failed: Invalid argument
> >  (what's this?)
> 
> Please don't call every bug out there IDE. Thanks.
> Becouse this one is acutally most likely due to the ioctl() handling
> changes between 27 and 28...

Any plans to fix 'hdparm -I /dev/atapi-cdrom-device' I reported to
you and Bartolomiej at the end of June? ide_*_taskfile
sets REQ_SPECIAL, but ide-cd calls cdrom_end_request(drive, rq, 1) 
on all such requests without looking at them or without trying to
execute them. This forces hdparm -I to think that ATA identify
suceeded and returned all zeroes:

/dev/hdd:

removable ATA device, with non-removable media
Standards:
        Likely used: 1
Configuration:
        Logical               max current
        cylinders             0   0
        heads                 0   0
        ...
Capabilities:
        no IORDY
        Cannot perform double-word IO
        r/w/ multiple sector transfer: not supported
        DMA: not supported
        PIO: pio0        

while 'hdparm -i' correctly reports that it is Toshiba DVD device
supporting IORDY, pio0-4, sdma0-2, mdma0-2, udma0-2, according
to ATA2-ATA5.
                                                Thanks,
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz
                                                    
