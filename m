Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751356AbWCFPHs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbWCFPHs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 10:07:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbWCFPHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 10:07:48 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:3309 "EHLO
	out.lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751356AbWCFPHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 10:07:47 -0500
Subject: Re: PATA failure with piix, works with libata
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060303183937.GA30840@srcf.ucam.org>
References: <20060303183937.GA30840@srcf.ucam.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 04 Mar 2006 14:11:46 +0000
Message-Id: <1141481507.10341.1.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2006-03-03 at 18:39 +0000, Matthew Garrett wrote:
> and everything is fine, including CD access. Loading piix gives me the 
> following:

> which seems ok. However, loading ide-cd gives:
> 
> [4294983.732000] hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> [4294983.732000] ide: failed opcode was: unknown
> [4294983.732000] hda: drive not ready for command

No suprise. Bits of ide/pci/piix.c only work because the BIOS setup did
some stuff we needed and in places with CD and DMA through luck alone.

> and insmod never returns. After this, the IDE interrupt is firing about 
> 80000 times a second. 

Make sure the IRQ is setup properly. Legacy mode IRQs are level
triggered which might fit this description.

