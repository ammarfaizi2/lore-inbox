Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751204AbWISHJh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbWISHJh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 03:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbWISHJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 03:09:37 -0400
Received: from cantor2.suse.de ([195.135.220.15]:50095 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751204AbWISHJg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 03:09:36 -0400
To: Jon Mason <jdmason@kudzu.us>
Cc: linux-kernel@vger.kernel.org, kautzy@kautzy.com
Subject: Re: Dual Core Opteron hangs, iommu Entries (x86_64)
References: <450E9B49.4030203@kautzy.com> <20060918183234.GA24163@kudzu.us>
From: Andi Kleen <ak@suse.de>
Date: 19 Sep 2006 09:09:26 +0200
In-Reply-To: <20060918183234.GA24163@kudzu.us>
Message-ID: <p73zmcw2uzd.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Mason <jdmason@kudzu.us> writes:
> 
> Your problem is that you have more than 4GB of RAM and not enough room
> in your IOMMU aperature to handle all of the pending DMA requests.
> Dmesg suggests you go into your BIOS and increase your AGP aperature
> from 32M to 64M, did you try that?  

The kernel ignores 32MB apertures anyways and creates its own 64MB aperture.

Normally IOMMU overflow should be handled without a hang though, assuming
you don't have a buggy driver. If you don't trust it you can
boot with iommu=panic panic=30 -- then the kernel will always panic
and reboot when this happens. The aperture can be also increased
with iommu=memaper=3 or 4

But it could be a lot of other things. So far you don't seem to have
any evidence that it's the IOMMU except for some likely misguided googling.

The usual way to check for unknown hangs is to just configure
serial console and see if there is some output during the hang.

Also do a memtest86 for at least 12hours.

-Andi

