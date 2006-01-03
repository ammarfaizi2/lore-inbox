Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964959AbWACV1O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964959AbWACV1O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 16:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964914AbWACV0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 16:26:24 -0500
Received: from mx1.suse.de ([195.135.220.2]:43414 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964883AbWACV0J convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 16:26:09 -0500
To: "=?iso-8859-1?q?Dieter_St=FCken?= <stueken"@conterra.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: X86_64 + VIA + 4g problems
References: <43B90A04.2090403@conterra.de> <p73k6difvm3.fsf@verdi.suse.de>
	<43BA4C3D.4060206@conterra.de> <p731wzpjtvm.fsf@verdi.suse.de>
	<43BAE7E3.6070504@conterra.de>
From: Andi Kleen <ak@suse.de>
Date: 03 Jan 2006 22:26:06 +0100
In-Reply-To: <43BAE7E3.6070504@conterra.de>
Message-ID: <p737j9hype9.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dieter Stüken <stueken@conterra.de> writes:
[can you please not always drop me from cc with each reply?]

Dieter StÃ¼ken <stueken@conterra.de> writes:

> OK, here are my last results for today:
>
> using "iommu=allowed" did not work. System freezes during initialization
> of the PDC20318, which is on the external PCI bus.
>
> But swiotlb=force works well!

This means your PCI bridge doesn't support addresses >4GB.

> The pci-gart.c patch seems to disable dma. 

Only DMA for addresses >4GB.

> Is this the DMA my PCI devices
> perform them self? As I learned, they may perform DMA even above 4g if all
> works well. Thus I may be happy without any IOMMU. As I saw my system working
> even without this patch, I will turn back to the original 2.6.15-rc7 an continue
> running this torture test during this night.

The patch should perform slightly better than swiotlb=force
because it will only force bounce buffering for addresses >4GB.

If your torture test involves more than 64MB of IO in flight
you might also need to increase the bounce buffer area
with swiotlb=128M or somesuch.

-Andi
