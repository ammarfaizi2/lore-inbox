Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319328AbSHVL6y>; Thu, 22 Aug 2002 07:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319329AbSHVL6y>; Thu, 22 Aug 2002 07:58:54 -0400
Received: from nixpbe.pdb.siemens.de ([192.109.2.33]:8069 "EHLO
	nixpbe.pdb.sbs.de") by vger.kernel.org with ESMTP
	id <S319328AbSHVL6x>; Thu, 22 Aug 2002 07:58:53 -0400
Subject: Re: ServerWorks OSB4 in impossible state
From: Martin Wilck <Martin.Wilck@Fujitsu-Siemens.com>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Gonzalo Servat <gonzalo@unixpac.com.au>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10208220143440.11626-100000@master.linux-ide.org>
References: <Pine.LNX.4.10.10208220143440.11626-100000@master.linux-ide.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 22 Aug 2002 14:02:35 +0200
Message-Id: <1030017756.9866.74.camel@biker.pdb.fsc.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Don, 2002-08-22 um 10.51 schrieb Andre Hedrick:

> The problem is we need a special DMA engine for this broken puppy.

You certainly have much more insight into the problem than I. 
I wonder if (something like) the simple patch I submitted before can
be a temporary solution nevertheless. Please correct me if one of the
following statements is wrong:

1) The "4 byte shift" issue does not affect the CSB5 series.
2) The tested condition inb(dma_base+0x02)&1 is valid if the
   device doing the DMA reported an error status. Only if the
   device reports success is there an indication of the "4 byte shift".
3) The "4 byte shift" problem matters not for read-only devices like
   CD-ROMS; at least it is no reason to stall the computer if it occurs
   because data corruption is not an issue.

If these assertions are true, the patch I sent will at least prevent
people's machines from stalling unnecessarily. Even if one ore more are
false, the remaining correct condition test(s) will narrow the set
of machines that are stalled unnecessarily.

> 508 + 4 is okay but 510 + 2 is not.
> 
> Now I have to remember why :-/

You sure have to go for the right solution.
But if my patch was applied, ServerWorks chip sets would cause less
grief to people until you have figured it out.

> Yeah I expect to take heat for this one from ServerWorks and it may cost
> me later, but nobody else has got the guts to press the issue for the
> correct solution.

Let me know if we can help. I have no personal contacts to ServerWorks,
but we are a large customer of them and may be able to exert some
additional pressure. The current situation (IDE DMA must be disabled)
is hardly acceptable for us anyway.

Martin

-- 
Martin Wilck                Phone: +49 5251 8 15113
Fujitsu Siemens Computers   Fax:   +49 5251 8 20409
Heinz-Nixdorf-Ring 1	    mailto:Martin.Wilck@Fujitsu-Siemens.com
D-33106 Paderborn           http://www.fujitsu-siemens.com/primergy





