Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270739AbTHJWpG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 18:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270740AbTHJWpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 18:45:06 -0400
Received: from [202.20.92.128] ([202.20.92.128]:44985 "EHLO quattro.co.nz")
	by vger.kernel.org with ESMTP id S270739AbTHJWpB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 18:45:01 -0400
Message-ID: <003e01c35f91$08227b40$0401a8c0@SIMON>
From: "Simon Garner" <sgarner@expio.co.nz>
To: "Andi Kleen" <ak@colin2.muc.de>
Cc: <linux-kernel@vger.kernel.org>
References: <gC1o.2gU.5@gated-at.bofh.it> <m3k79t7ykk.fsf@averell.firstfloor.org> <028101c35aea$d2753690$0401a8c0@SIMON> <20030805134241.GA63394@colin2.muc.de>
Subject: Re: MSI K8D-Master - GART error 3
Date: Mon, 11 Aug 2003 10:43:57 +1200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2720.3000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, August 06, 2003 1:42 AM [GMT+1200=NZT],
Andi Kleen <ak@colin2.muc.de> wrote:
>
> Ok that's the very old MCE code that incorrectly enabled the
> northbridge machine check. Don't use that or use mce=off. However  I
> still think it's a driver bug in your case. If it was the shakey GART
> MCE itself you would get a panic because it's a unrecoverable MCE.
> More likely the driver is accessing PCI DMA mappings after they got
> unmapped, which is a serious bug, but somehow not serious enough that
> the northbridge triggers the MCE.
>
> I was confused by your statement that the SuSE 8.2 beta9 kernel
> generated that. It didn't because it doesn't contain that old code.
>
> What does a modern kernel like the SuSE one or a x86-64.org kernel
> generate exactly?
>

I have reinstalled SuSE now, and I apologise as I was only partially
correct. I do get errors, but they are slightly different from RH. They
appear to be saying the same thing, though. Every 30 seconds I get:


Aug 11 10:37:06 terra kernel: Northbridge status 9405c00000000a13
Aug 11 10:37:06 terra kernel:     ECC syndrome bits b
Aug 11 10:37:06 terra kernel:     extended error ecc error
Aug 11 10:37:06 terra kernel:     link number 0
Aug 11 10:37:06 terra kernel:     corrected ecc error
Aug 11 10:37:06 terra kernel:     error address valid
Aug 11 10:37:06 terra kernel:     error enable
Aug 11 10:37:06 terra kernel:     previous error lost
Aug 11 10:37:06 terra kernel:     error address 00000000003e4710
Aug 11 10:37:36 terra kernel: Northbridge status 9405c00000000813
Aug 11 10:37:36 terra kernel:     ECC syndrome bits b
Aug 11 10:37:36 terra kernel:     extended error ecc error
Aug 11 10:37:36 terra kernel:     link number 0
Aug 11 10:37:36 terra kernel:     corrected ecc error
Aug 11 10:37:36 terra kernel:     error address valid
Aug 11 10:37:36 terra kernel:     error enable
Aug 11 10:37:36 terra kernel:     previous error lost
Aug 11 10:37:36 terra kernel:     error address 00000000003c4220


These suggest it's just reporting ECC corrections. Why would it do this
exactly every 30 seconds? (or is that just the reporting interval?)


# uname -a
Linux terra 2.4.19-SMP #1 SMP Wed Jun 25 21:37:18 UTC 2003 x86_64
unknown unknown GNU/Linux


thanks for the help,

-Simon

