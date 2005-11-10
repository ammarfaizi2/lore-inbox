Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751222AbVKJS7h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbVKJS7h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 13:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbVKJS7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 13:59:37 -0500
Received: from nproxy.gmail.com ([64.233.182.192]:12716 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751222AbVKJS7h convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 13:59:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=d3d/81e8GG8b2XXN8WBxTM7AHNXeaekLJdJKt9HScng3438ZfhtP544HuHLCQd7znIOF1veAugRDSXTWeWyKfhN5jLrSAQHXd4tBYSlq0J158sGGXZ+bh3KB38+wdrjRkqEd+WRXGK45ezCioJwTPcf5UyA+GVkI/YSWloBQJqQ=
Message-ID: <58cb370e0511101059m1a954886v99f809f577f5e121@mail.gmail.com>
Date: Thu, 10 Nov 2005 19:59:34 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: sinthetek <sinthetek@mentalcases.net>
Subject: Re: SiS 5513 IDE support
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051110022726.65c47cad@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051110022726.65c47cad@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/05, sinthetek <sinthetek@mentalcases.net> wrote:
> I am not really all that great of a programmer and this is my first real experience with modifying the kernel in any respect (aside from a couple of failed attempts to get my digitos digital camera to work last year). However a few months ago I got this new Asus K8S-MX motherboard and, when I installed my ide harddrive on the system and editted my kernel to support my new hardware, I found that my SiS 5513 support wasn't working. I had no DMA and my system would end up slowing to a crawl and swap-thrashing within minutes after boot (mind you this is an AMD64 2800+ with 512MB PC3200 DDR i'm talking about here).
>
> Anyway, after scouring the net for a solution and not finding one, I decided to delve into the

www.google.com + "sis5513 k8s-mx linux" works for me

code a bit and found the problem (I think). For some reason the SiS
5513 code contained in the kernel tree doesn't look for the 0x5513
device id at all. I'm not sure why that is... on my system the device
id is 0x5513 which makes sense considering the name of the chipset :P.
>
> At any rate, i'm hoping that perhaps someone on here might add these changes to the main kernel so i won't have to keep making them myself everytime i want to upgrade my kernel. First off, in /usr/src/linux/drivers/ide/pci/sis5513.c, when scanning for devices, the closest it gets to the 5513 chipset is the 5511 (PCI_DEVICE_ID_SI_5511) as far as I can tell. Which, according to /usr/src/linux/include/linux/pci_ids.h, has the value of 0x5511. I simply added an entry to /usr/src/linux/include/linux/pci_ids.h for the 0x5513 device id ("#define PCI_DEVICE_ID_SI_5513           0x5513") and appended this line to the SiSHostChipInfo structure array:         "{ "SiS5513",    PCI_DEVICE_ID_SI_5513,  ATA_133  },"
>
> I have even less experience with hardware than I do with coding so i'm not completely sure this is the right/best solution to the problem, but it seems to be working fine for the last few months. I'm not sure if 5513 chipsets on other motherboards don't have the 0x5513 device id or why. When I called Asus to ask about it they said they don't modify any of the chips they get from other manufacturers so...
>
> Anyway, I figure it is a small modification for you guys to make that would save a lot of people some trouble.

Unfortunately this is a wrong solution and has been NAK-ed at least once.

SiS965L support is being currently discussed and will be soon merged
into mainline.

Thanks,
Bartlomiej
