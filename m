Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267333AbTACAMN>; Thu, 2 Jan 2003 19:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267347AbTACAMN>; Thu, 2 Jan 2003 19:12:13 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:24592 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267333AbTACAMM>; Thu, 2 Jan 2003 19:12:12 -0500
Date: Fri, 3 Jan 2003 00:20:32 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: david-b@pacbell.net, akpm@digeo.com, James.Bottomley@steeleye.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] generic device DMA (dma_pool update)
Message-ID: <20030103002032.D3782@flint.arm.linux.org.uk>
Mail-Followup-To: "Adam J. Richter" <adam@yggdrasil.com>,
	david-b@pacbell.net, akpm@digeo.com, James.Bottomley@steeleye.com,
	linux-kernel@vger.kernel.org
References: <200301022207.OAA00803@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200301022207.OAA00803@adam.yggdrasil.com>; from adam@yggdrasil.com on Thu, Jan 02, 2003 at 02:07:46PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 02, 2003 at 02:07:46PM -0800, Adam J. Richter wrote:
> 	The pci_pool_alloc  in sa1111-buf.c is more interesting.
> alloc_safe_buffer is used to implement an unusual version of
> pci_map_single.  It is unclear to me whether this approach is optimal.
> I'll look into this more.

Welcome to the world of seriously broken hardware that a fair number
of people put on their boards.  Unfortunately, the hardware bug got
marged as "never fix" by Intel.

Basically, the chip is only able to DMA from certain memory regions
and its RAM size dependent.  For 32MB of memory, it works out at
around 1MB regions - odd regions are not able to perform DMA, even
regions can.

Linux only supports one DMA region per memory node though, so in
this configuration, we only have 1MB of memory able to be used for
OHCI.

To work around this, we have "unusual" versions of the mapping
functions.  Although they may not be optimal, they are, afaik
completely functional.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

