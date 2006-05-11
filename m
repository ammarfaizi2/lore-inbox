Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750733AbWEKUPH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbWEKUPH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 16:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbWEKUPH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 16:15:07 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:20922 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750733AbWEKUPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 16:15:05 -0400
Subject: Re: [PATCH] PIIX: fix 82371MX enablebits
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <446395A0.20806@ru.mvista.com>
References: <446395A0.20806@ru.mvista.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 11 May 2006 21:27:04 +0100
Message-Id: <1147379225.26130.81.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2006-05-11 at 23:50 +0400, Sergei Shtylyov wrote:
>      According to the datasheet, Intel 82371MX (MPIIX) actually has only a
> single IDE channel mapped to the primary or secondary ports depending on the
> value of the bit 14 of the IDETIM register at PCI config. offset 0x6C (the
> register at 0x6F which the driver refers to. doesn't exist). So, disguise the
> controller as dual channel and set enablebits masks/values such that only
> either primary or secondary channel is detected enabled. Also, preclude the
> IDE probing code from reading PCI BARs, this controller just doesn't have them
> (it's not the separate PCI function like the other PCI controllers), it only
> decodes the legacy addresses.

There are lots and lots of other things you need to fix to make MPIIX
work with that driver. It has only a single timing register for one so
you must switch timing as you flip drive. Also it is not an IDE class
device so the PCI native/legacy and simplex stuff is not valid. Finally
the PIIX driver pokes several registers it doesn't even have.

What else - oh yes the piix driver doesn't even tune the timings, so it
doesn't work anyway.


Thats why drivers/scsi/pata_mpiix is a separate driver. Really if you
want to try and rescue the old PIIX driver you should split out PIIX3
and MPIIX into their own drivers.


