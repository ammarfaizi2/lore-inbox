Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262354AbVAEM7L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262354AbVAEM7L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 07:59:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262359AbVAEM7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 07:59:10 -0500
Received: from wproxy.gmail.com ([64.233.184.197]:13784 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262358AbVAEM7D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 07:59:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=rXRG2eUZm4mLeyEritupeknD9H4JdSlqdY5gfkZx5RLiB4GfvRshaWctf7SwBnJhdbgZffqtX3JKUN8oFWeACQ5V4QdEPa5Y57TNJOgoihNn0S/afoV3UBbL/zQOdzxYC0pTFS3/A909zydLjgZUc3+iZwwQuN9X2QTUa2cu5bw=
Message-ID: <58cb370e05010504594f6ab8d@mail.gmail.com>
Date: Wed, 5 Jan 2005 13:59:02 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata PATA support - work items?
Cc: Jeff Garzik <jgarzik@pobox.com>, Eric Mudama <edmudama@gmail.com>,
       Albert Lee <albertcc@tw.ibm.com>, IDE Linux <linux-ide@vger.kernel.org>,
       Doug Maxey <dwm@maxeymade.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jens Axboe <axboe@suse.de>
In-Reply-To: <1104886199.17176.115.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <006301c4ee5c$49e6a230$95714109@tw.ibm.com>
	 <311601c9050101111929aef5ba@mail.gmail.com>
	 <41DB299C.3030405@pobox.com>
	 <1104886199.17176.115.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Jan 2005 00:50:05 +0000, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Maw, 2005-01-04 at 23:41, Jeff Garzik wrote:
> > So, that said, I think it is important for libata to fully support PATA,
> > if it is to support it at all.  That means handling the errata that Alan
> > always bugs me about, and that means handling C/H/S support as well.
> 
> I think so. If it supports all the features of the old IDE layer we get
> to have a party when we eliminate the need for drivers/ide once and for
> all.
> 
> That means
> - Hotplug (controller and disk)
> - CHS
> - "Not quite generic" IDE DMA (eg CS5520)
> - VDMA (eg CS5520)
> - IORDY timers (not handled well in drivers/ide but needed)
> - Funky Maxtor "LBA48.. maybe" oddments
> - Missing slave detection
> - Controller errata hooks (modes, drives, timings, "dont touch during an
> I/O" etc)
> - Drive nIEN bugs
> - No nIEN cases
> - Drives that don't do some DMA/modes right
> - Crazy shit "Don't DMA from the page below 640K" (not handled by
> drivers/ide but an AMD errata
>         fixed by using a PS/2 mouse)
> - Serialize (RZ1000, CMD640, some 469, etc)
> - Bandwidth arbiter (not in drivers/ide but needed)
> - Non PCI shared IRQ mess 8(
> 
> Hopefully most of this can be buried away in a pata-errata.c 8)

:-)

few more:
- Power Management for devices
- 32 bit I/O support
- Multiple Mode PIO support
- Host Protected Area support
  (can be done from user-space but "coldplug" is needed)
- ide-{cd,disk,floppy,tape}.c specific quirks
