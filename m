Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751674AbWDCJH1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751674AbWDCJH1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 05:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751673AbWDCJH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 05:07:27 -0400
Received: from aun.it.uu.se ([130.238.12.36]:15057 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S1751520AbWDCJH0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 05:07:26 -0400
Date: Mon, 3 Apr 2006 11:07:04 +0200 (MEST)
Message-Id: <200604030907.k33974O9020701@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: alan@lxorguk.ukuu.org.uk, mrmacman_g4@mac.com
Subject: Re: [RESEND][2.6.15] New ATA error messages on upgrade to 2.6.15
Cc: edmudama@gmail.com, hahn@physics.mcmaster.ca, hancockr@shaw.ca,
       jujutama@comcast.net, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 02 Apr 2006 22:24:43 +0100, Alan Cox wrote:
>Unless anyone else is seeing the same problem with the same card variant
>or you have two cards that do it then there isn't much that can be done
>I suspect other than assume the hardware is iffy, rightly or wrongly.
>I'd have expected a lot more reports if it were the controller.
>
>(Having said that if you are reading this and your controller is a
>Promise and does the same, please say so it might be vital to deducing a
>pattern to problems)

I have a Beige G3 PowerMac upgraded with a 1GHz G4 CPU
(a 7455 on a Sonnet board) and a standard (for x86) Promise
20269 PCI controller card. The 20269+cable+disk does udma5
just fine in a PC, but throws a few BadCRCs at bootup on
the PowerMac, resets and drops to udma4, and then things work
OK for me, but I don't stress it very much (no RAID).

Since the card's bios doesn't get run at powerup, I always
suspected that the driver fails to initialize some timing thing.

Another possibility is the "data coherency" issue in some
G4 CPUs which requires mappings of memory shared with other
agents to use some additional magic in the page table.
This issue caused file system corruption when I used
my G4 + 20269 combo under load with 2.4 kernels, until
I found and backported a fix from 2.6 to 2.4.28. It's
supposed to be handled transparently by arch/{ppc,powerpc},
but it's possible the driver is mapping things incorrectly.
(This is just speculation.)

I can provide bootup logs and lspci dumps if you want.

/Mikael
