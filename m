Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751769AbWHNHUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751769AbWHNHUF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 03:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751913AbWHNHUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 03:20:05 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:41482 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751769AbWHNHUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 03:20:02 -0400
Date: Mon, 14 Aug 2006 08:19:56 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 4/14] Generic ioremap_page_range: arm conversion
Message-ID: <20060814071955.GA26225@flint.arm.linux.org.uk>
Mail-Followup-To: Haavard Skinnemoen <hskinnemoen@atmel.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
References: <1155225826761-git-send-email-hskinnemoen@atmel.com> <1155225827754-git-send-email-hskinnemoen@atmel.com> <11552258271630-git-send-email-hskinnemoen@atmel.com> <115522582724-git-send-email-hskinnemoen@atmel.com> <11552258272417-git-send-email-hskinnemoen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11552258272417-git-send-email-hskinnemoen@atmel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2006 at 06:03:36PM +0200, Haavard Skinnemoen wrote:
> From: Russell King <rmk@arm.linux.org.uk>
> 
> Convert ARM to use generic ioremap_page_range()

NAK.  There are already issues with using the xxx_kernel variants of
the page table functions for IO mappings on later architectures (caused
by speculative loads hitting IO regions.)  This code needs to change
slightly so that we have xxx_io versions of pte_alloc and friends.

(It also means that we need an ioremap region and a separate vmalloc
region on ARM...)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
