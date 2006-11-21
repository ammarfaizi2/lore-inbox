Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030829AbWKUKaQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030829AbWKUKaQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 05:30:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030831AbWKUKaQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 05:30:16 -0500
Received: from cantor2.suse.de ([195.135.220.15]:24965 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030829AbWKUKaP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 05:30:15 -0500
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Ray Lee <ray-lk@madrabbit.org>, linux-kernel@vger.kernel.org
Subject: Re: Problem with DMA on x86_64 with 3 GB RAM
References: <455B63EC.8070704@madrabbit.org>
	<20061118112438.GB15349@nineveh.rivenstone.net>
	<1163868955.27188.2.camel@johannes.berg>
	<455F3D44.4010502@lwfinger.net> <455F4271.1060405@madrabbit.org>
	<455FF672.4070502@lwfinger.net>
From: Andi Kleen <ak@suse.de>
Date: 21 Nov 2006 11:30:00 +0100
In-Reply-To: <455FF672.4070502@lwfinger.net>
Message-ID: <p73psbhay8n.fsf@bingen.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry Finger <Larry.Finger@lwfinger.net> writes:

> I am trying to debug a bcm43xx DMA problem on an x86_64 system with 3
> GB RAM. Depending on the particular chip and its implementation, dma
> transfers may use 64-, 32-, or 30-bit addressing, with the problem
> interface using 30-bit addressing. From test prints, the correct mask
> (0x3FFFFFFF) is supplied to pci_set_dma_mask and
> pci_set_consistent_dma_mask. Neither call returns an error. In
> addition, several x86_64 systems with more than 1 GB RAM have worked
> with the current code.

30bit DMA has be bounced through GFP_DMA. The driver needs special
code for this. You can look at the b44 driver for a working reference.

The pci_dma_* interfaces on x86-64 only support masks >= 0xffffffff,
anything smaller has to be handled manually.

-Andi
