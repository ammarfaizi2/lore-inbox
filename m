Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261756AbRESKtW>; Sat, 19 May 2001 06:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261751AbRESKtM>; Sat, 19 May 2001 06:49:12 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:9733 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S261756AbRESKtA>; Sat, 19 May 2001 06:49:00 -0400
Date: Sat, 19 May 2001 14:48:15 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Tom Vier <tmv5@home.com>
Cc: Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Subject: Re: alpha iommu fixes
Message-ID: <20010519144815.A2177@jurassic.park.msu.ru>
In-Reply-To: <20010518214617.A701@jurassic.park.msu.ru> <20010518223436.A563@zero>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010518223436.A563@zero>; from tmv5@home.com on Fri, May 18, 2001 at 10:34:36PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2001 at 10:34:36PM -0400, Tom Vier wrote:
> 	hose->sg_pci = iommu_arena_new(hose, 0xc0000000, 0x08000000, 32768);
> 	*(vip)CIA_IOC_PCI_W3_BASE = 0xc0000000 | 1;
> 	*(vip)CIA_IOC_PCI_W3_MASK = (0x08000000 - 1) & 0xfff00000;
> 	*(vip)CIA_IOC_PCI_T3_BASE = 0x80000000 >> 2;

This is incorrect. If you want directly mapped PCI window then you don't
need the iommu_arena for it. If you want scatter-gather mapping, you
should write address of the SG page table into the T3_BASE register.

Ivan.
