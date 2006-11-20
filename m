Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966261AbWKTR5Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966261AbWKTR5Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 12:57:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966284AbWKTR5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 12:57:24 -0500
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:29390 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S966296AbWKTR5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 12:57:23 -0500
Date: Mon, 20 Nov 2006 18:57:21 +0100
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: avl@logic.at, linux-kernel@vger.kernel.org
Subject: Re: possible bug in ide-disk.c (2.6.18.2 but also older)
Message-ID: <20061120175721.GT6851@gamma.logic.tuwien.ac.at>
Reply-To: avl@logic.at
References: <20061120145148.GQ6851@gamma.logic.tuwien.ac.at> <20061120152505.5d0ba6c5@localhost.localdomain> <20061120165601.GS6851@gamma.logic.tuwien.ac.at> <20061120172812.64837a0a@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061120172812.64837a0a@localhost.localdomain>
User-Agent: Mutt/1.3.28i
From: Andreas Leitgeb <avl@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2006 at 05:28:12PM +0000, Alan wrote:
> > Alternatively, a kernel-option to manually disable hpa-checking
> > would be a good step to solve the problem even for drives like mine.
> It's a compile time option. If you don't have GPT partitioning support
> then the system ought to behave correctly.

To me it now seems that my symptoms have twofold cause:
  -) misinterpretation of that drive's reported number of sectors.
  -) accessing the last reported sector in search for a GPT.

If I turn off GPT, then perhaps the last (non-existent-but-
believed-by-the-kernel-to-exist) sector is likely never ever
accessed, and therefore the dma-switching-off doesn't happen.
(Well, at least not at boot time, but still, if anyone did 
"dd if=/dev/hda ..." without limiting count=...)

Otoh, patching out this "addr++;" leads to the GPT-test to 
access a valid (in HD's view) sector which contains (who knows,
I even might have a GPT without being aware) or doesn't contain
a GPT, but anyway everthing works.

This does make sense to me.
Please let me know if this makes no sense
  to anyone really knowing ide-stuff.

PS: If it weren't that the failure to access that last sector
    caused dma to be turned off, I'd never have noticed anything
    special.
