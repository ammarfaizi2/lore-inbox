Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315050AbSEHUOY>; Wed, 8 May 2002 16:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315096AbSEHUOX>; Wed, 8 May 2002 16:14:23 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:43026 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S315050AbSEHUOW>; Wed, 8 May 2002 16:14:22 -0400
Subject: Re: [PATCH] IDE 58
To: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Wed, 8 May 2002 21:31:55 +0100 (BST)
Cc: torvalds@transmeta.com (Linus Torvalds),
        dalecki@evision-ventures.com (Martin Dalecki),
        andre@linux-ide.org (Andre Hedrick),
        bjorn.wesen@axis.com (Bjorn Wesen), paulus@samba.org (Paul Mackerras),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <20020508191054.6282@smtp.wanadoo.fr> from "Benjamin Herrenschmidt" at May 08, 2002 09:10:54 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E175Y6N-0002Jj-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ata_channel (or ata_drive, but I doubt that would be really
> necessary) a set of 4 access functions: taskfile_in/out for
> access to taskfile registers (8 bits), and data_in/out for
> steaming datas in/out of the data reg (16 bits).

Please push it higher level than that. Load the taskfile as a set in
each method. Remember its 1 potentially paired instruction to do an MMIO
write, its a whole mess of synchronziation and stalls to do a function 
pointer.

> address at all (that is kill the array of port addresses) but
> just pass the taskfile_in/out functions the register number
> (cyl_hi, cyl_lo, select, ....) as a nice symbolic constant,
> and let the channel specific implementation figure it out.

Pass  dev->taskfile_load() a struct at least for the common paths. Make the
PIO block transfers also single callbacks for each block not word.

Alan
