Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750970AbVJ2BAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750970AbVJ2BAV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 21:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbVJ2BAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 21:00:20 -0400
Received: from relay01.roc.ny.frontiernet.net ([66.133.182.164]:55482 "EHLO
	relay01.roc.ny.frontiernet.net") by vger.kernel.org with ESMTP
	id S1750970AbVJ2BAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 21:00:18 -0400
Reply-To: <jbowler@acm.org>
From: John Bowler <jbowler@acm.org>
To: "'David Vrabel'" <dvrabel@cantab.net>
Cc: "'Deepak Saxena'" <dsaxena@plexity.net>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] 2.6.14-rc3 ixp4xx_copy_from little endian/alignment
Date: Fri, 28 Oct 2005 17:16:45 -0700
Message-ID: <004c01c5dc1e$0ce4fbb0$1001a8c0@kalmiopsis>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <43628B40.50902@cantab.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Vrabel [mailto:dvrabel@cantab.net]
>It appears that the NSLU2 only has the flash on the expansion bus which 
>is why you believe it's a flash specific problem.

Which would also explain why a flash specific solution works...  I'll
try an experiment without the XOR on the address and with data coherency.

The issue here is whether that's the right answer for hypothetical other
IXP4XX LE systems which have both flash and non-flash peripherals on EXP.

Still, it doesn't much matter - NSLU2 doesn't have such devices (so far as
I know - i.e. I believe that your statement about there being nothing else
on the EXP bus is correct) and we implemented this patch for NSLU2, even
though it isn't NSLU2 specific.

>Data coherency can be set on a per 1 Mibyte page basis so all other (APB 
>and PCI) peripherals would continue to use address coherency and thus 
>would continue to function as they are now.

Ok... so I'll try to find a way to do this in the board level code, or
maybe better in the IXP4XX setup (drivers/mtd/maps/ixp4xx.c?)

It's worth considering that, so far as I can see, nothing which uses
drivers/mtd/maps/ixp4xx.c will currently work in LE unless it is already
setting data coherency on the flash addresses.  Is NSLU2 the first IXP4XX
system to run LE and to access the flash (from a running system, not from
the boot loader?)

John Bowler <jbowler@acm.org>

