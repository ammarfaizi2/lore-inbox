Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265943AbUHFNfX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265943AbUHFNfX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 09:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268138AbUHFNfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 09:35:23 -0400
Received: from the-village.bc.nu ([81.2.110.252]:4545 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S265943AbUHFNfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 09:35:17 -0400
Subject: Re: libata: dma, io error messages
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Paul Jakma <paul@clubi.ie>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.60.0408061113210.2622@fogarty.jakma.org>
References: <Pine.LNX.4.60.0408061113210.2622@fogarty.jakma.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1091795565.16307.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 06 Aug 2004 13:32:46 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-08-06 at 11:29, Paul Jakma wrote:
> scsi0: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 02 05 d0 06 00 00 10 00
> Current sda: sense key Medium Error

Disk error

> Additional sense: Unrecovered read error - auto reallocate failed

Bad block, and sufficiently bad that it couldn't then recover the block
and rewrite it. When a drive sees a marginal read (lot of forward error
correction recovery needed) it will try and rewrite or move the block.

In this case it couldn't read the block enough to move it.

> Also, the drive is extremely slow now, about 1MB/s drive transfer 
> rate as reported by hdparm -T.

Sounds like it dropped to PIO - that may be a bug triggered by the drive
failing.


