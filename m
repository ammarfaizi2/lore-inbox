Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264628AbTANPmV>; Tue, 14 Jan 2003 10:42:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264630AbTANPmU>; Tue, 14 Jan 2003 10:42:20 -0500
Received: from host194.steeleye.com ([66.206.164.34]:4872 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S264628AbTANPmO>; Tue, 14 Jan 2003 10:42:14 -0500
Message-Id: <200301141551.h0EFp1602455@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: "David S. Miller" <davem@redhat.com>
cc: James.Bottomley@SteelEye.com, linux-kernel@vger.kernel.org
Subject: Re: [BK-2.5] Update the generic DMA API to take GFP_ flags on 
In-Reply-To: Message from "David S. Miller" <davem@redhat.com> 
   of "Tue, 14 Jan 2003 07:30:23 PST." <20030114.073023.89921980.davem@redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 14 Jan 2003 10:51:01 -0500
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

davem@redhat.com said:
> Now what about the corollary, a platform that needs to sleep to setup
> the cpu mapings in a race-free manner? 

This one is the big bug bear.  The DMA-mapping.txt doc says 
pci_alloc_consistent "may be called in interrupt context".  Thus if the 
dma_alloc with GFP_ATOMIC uses the same code path, it should be safe.  
However, there are indications that pci_alloc_consistent wasn't interrupt safe 
on certain platforms (see other email re PA-RISC).

In any event, we're no worse off than we were with the pci_ API.  Passing in 
the flags will hopefully allow us to create GFP_ATOMIC safe paths in the arch 
implementations which look iffy.

James


