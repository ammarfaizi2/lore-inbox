Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265301AbUHNUfA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265301AbUHNUfA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 16:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265348AbUHNUfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 16:35:00 -0400
Received: from the-village.bc.nu ([81.2.110.252]:39131 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S265301AbUHNUe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 16:34:58 -0400
Subject: Re: PATCH: Add support for IT8212 IDE controllers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Elmar Hinz <elmar.hinz@vcd-berlin.de>
Cc: Alan Cox <alan@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4110ECBF.9070000@vcd-berlin.de>
References: <2obsK-5Ni-13@gated-at.bofh.it> <4110ECBF.9070000@vcd-berlin.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092511953.27379.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 14 Aug 2004 20:32:33 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-08-04 at 15:03, Elmar Hinz wrote:
> When I set in the bios RAID 1 there comes an message similar
> INVALID GEOMETRY: 0 PHYSICAL HEADS?
> and booting stops.

Should be fixed now. I'm running a bios raid1 and it seems to be 
doing the right thing. Turns out we had a locking bug on that error
path and the identify block from the raid volumes was wrong

I've added some quirk code to fix up the fields in the identify 
data to indicate LBA28/48 is supported, report that the UDMA data
provided is valid (so we turn DMA on and get cable CRCs).

I've also added code to the it8212 driver to filter the 48bit flush
cache command (seems to kill my card), only queue 128K per I/O (LBA48
full sized I/O's also seem to kill my card) and to skip the 0x27 (native
size) query the firmware doesn't seem to know.

Alan

