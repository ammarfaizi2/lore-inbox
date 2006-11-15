Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966493AbWKOECF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966493AbWKOECF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 23:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966121AbWKOECF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 23:02:05 -0500
Received: from gate.crashing.org ([63.228.1.57]:53971 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S966479AbWKOECA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 23:02:00 -0500
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
Cc: torvalds@osdl.org, jeff@garzik.org, linux-kernel@vger.kernel.org,
       tiwai@suse.de
In-Reply-To: <20061114.190036.30187059.davem@davemloft.net>
References: <Pine.LNX.4.64.0611141747490.3349@woody.osdl.org>
	 <455A7E21.7020701@garzik.org>
	 <Pine.LNX.4.64.0611141846190.3349@woody.osdl.org>
	 <20061114.190036.30187059.davem@davemloft.net>
Content-Type: text/plain
Date: Wed, 15 Nov 2006 15:01:00 +1100
Message-Id: <1163563260.5940.205.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> If you take an INTX interrupt, it's over a pin on the motherboard and
> thus can arrive before the DMA makes it to main memory, so you have to
> have all of this fixup logic to handle that case and you don't even
> know the interrupt is really for you so you have to actually check
> the status block.

Out of curiosity. Are you sure there is no case of stupid bridge
converting the MSI into some APIC/whatever interrupt for the CPU
potentially before all previous DMA have been fully pushed to the
coherent domain (still in some internal store queue for example) ?

I suppose the Intel bridges get it right since they pretty much defined
them in the first place... but my experience with chipset designers is
that they have generally little regard for ordering issues (and the
impact those have on software) and no clue about anything related to
interrupt issues.

Ben.



