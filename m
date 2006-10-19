Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946086AbWJSHyd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946086AbWJSHyd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 03:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946085AbWJSHyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 03:54:33 -0400
Received: from mail4.hitachi.co.jp ([133.145.228.5]:53656 "EHLO
	mail4.hitachi.co.jp") by vger.kernel.org with ESMTP
	id S1946086AbWJSHyc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 03:54:32 -0400
Message-Type: Multiple Part
MIME-Version: 1.0
Message-ID: <XNM1$9$0$4$$3$3$7$A$9002705U45372f1d@hitachi.com>
Content-Type: text/plain; charset="us-ascii"
To: "David Miller" <davem@davemloft.net>
From: <eiichiro.oiwa.nm@hitachi.com>
Cc: <alan@redhat.com>, <jesse.barnes@intel.com>, <greg@kroah.com>,
       <linux-kernel@vger.kernel.org>
Date: Thu, 19 Oct 2006 16:54:19 +0900
References: <20061018.233102.74754142.davem@davemloft.net>
Importance: normal
Subject: Re:pci_fixup_video change blows up on sparc64
X400-Content-Identifier: X45372F1D00000M
X400-MTS-Identifier: [/C=JP/ADMD=HITNET/PRMD=HITACHI/;gmml16061019165405PZ3]
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>This change in 2.6.19-GIT:
>
>commit b5e4efe7e061ff52ac97b9fa45acca529d8daeea
>Author: eiichiro.oiwa.nm@hitachi.com <eiichiro.oiwa.nm@hitachi.com>
>Date:   Thu Sep 28 13:55:47 2006 +0900
>
>    PCI: Turn pci_fixup_video into generic for embedded VGA
>
>breaks sparc64 with ATI Radeon and ATY128 cards.
>
>The problem is that there is no system rom at 0xc0000 on sparc64, and
>therefore nothing copies the VGA bios of the graphics card there on
>bootup.  Therefore all of this code is bogus and will just result in
>bus errors when the Radeon or ATY128 driver tries to pci_map_rom() and
>read the graphics card ROM.  Nothing will respond to accesses at the
>0xc0000 region on sparc64.
>
>The existence of a primary video ROM at 0xc0000 is quite platform
>specific.  If some non-x86 systems have this too, that's great.
>However, assuming all systems do is not correct.
>

Does ATI Radeon card have an expansion ROM (video ROM)?
Could you show me "lspci -vv" on sparc64?

If an expansion ROM exists on ATI Radeon or ATY128 card, pci_map_rom returns
the expansion ROM base address instead of 0xC0000 because fixup_video checks
the VGA Enable bit in the Bridge Control register.
The Bridge Control register describes in "PCI-to-PCI Bridge Architecture
Specification Revision 1.2".
This specification is the standard specification in PCI.
