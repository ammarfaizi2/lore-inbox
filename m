Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261844AbTD2M2U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 08:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261849AbTD2M2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 08:28:20 -0400
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:58629 "EHLO
	young-lust.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id S261844AbTD2M2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 08:28:19 -0400
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: rth@twiddle.net, linux-kernel@vger.kernel.org
Subject: Re: [Patch] DMA mapping API for Alpha
References: <wrp65oycvrw.fsf@hina.wild-wind.fr.eu.org>
	<20030429150532.A3984@jurassic.park.msu.ru>
	<wrpvfwx5xcq.fsf@hina.wild-wind.fr.eu.org>
	<20030429162322.B5767@jurassic.park.msu.ru>
Organization: Metropolis -- Nowhere
X-Attribution: maz
Reply-to: mzyngier@freesurf.fr
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: 29 Apr 2003 14:37:51 +0200
Message-ID: <wrpllxt5vj4.fsf@hina.wild-wind.fr.eu.org>
In-Reply-To: <20030429162322.B5767@jurassic.park.msu.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Ivan" == Ivan Kokshaysky <ink@jurassic.park.msu.ru> writes:

Ivan> Agreed, but what if your EISA-PCI bridge has only 30 address
Ivan> lines wired to PCI? Yes, we can check this for EISA device
Ivan> because it has *real* PCI parent (thanks, Marc :-), but what
Ivan> about ISA/legacy/whatever drivers?  I doubt that all of them
Ivan> bother to set dma_mask pointer (so you can have an oops there).

If the driver is not ported to the device API, than we pass NULL as a
device pointer, and then we fallback to the old behaviour, aka
dma_mask=0x00ffffff. If the driver supplies a dev pointer, but fails
to set its dma_mask pointer, than it is a driver bug that should be
fixed.

And yes, the EISA subsystem should properly report the dma_mask to
attached devices (patches for that are in mm tree, and sent to Linus).

        M.
-- 
Places change, faces change. Life is so very strange.
