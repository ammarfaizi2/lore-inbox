Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273598AbRIUQIo>; Fri, 21 Sep 2001 12:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273591AbRIUQIf>; Fri, 21 Sep 2001 12:08:35 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:16133 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S273589AbRIUQIb>; Fri, 21 Sep 2001 12:08:31 -0400
Subject: Re: [patch] block highmem zero bounce v14
To: arjanv@redhat.com (Arjan van de Ven)
Date: Fri, 21 Sep 2001 17:13:31 +0100 (BST)
Cc: axboe@suse.de (Jens Axboe), torvalds@transmeta.com (Linus Torvalds),
        linux-kernel@vger.kernel.org (Linux Kernel), arjanv@redhat.com,
        davem@redhat.com (David S. Miller)
In-Reply-To: <20010921114448.D1924@devserv.devel.redhat.com> from "Arjan van de Ven" at Sep 21, 2001 11:44:48 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15kSvj-0000Mb-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > One of the very first decisions I made wrt this patch was to make sure
> > that weird/old drivers could keep on working exactly the way they do now
> > and never have to worry about highmem stuff. 
> 
> unfortionatly, so far both megaraid and the 3ware driver broke. Megaraid is
> easily fixable, but still. It shows that this patch is not without risk...

I am not sure the megaraid breakage is from that patch at the moment. There
is another 2.4.10pre change which seems to alter the request size limits for
the megaraid.  I don't know where this came from but it was not discussed
on the megaraid list or posted here by any megaraid folks. Given the 
megaraid firmware is umm "fragile" anything that changes what we feed it
really does want to go through the AMI/Dell people.

A secondary issue is that 64bit DMA is only correctly handled by certain
MegaRAID firmware. The checks for this are not correct until 1.1.17a-ac
in some cases (eg HP rebadged board with H.01.07 and H.01.08 firmware)

Alan
