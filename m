Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261935AbVBOXAu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261935AbVBOXAu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 18:00:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261938AbVBOW7D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 17:59:03 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:31755 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261937AbVBOW5D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 17:57:03 -0500
Date: Tue, 15 Feb 2005 22:56:56 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Peter Hagervall <hager@cs.umu.se>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] Kill some sparse warnings
Message-ID: <20050215225655.A26733@flint.arm.linux.org.uk>
Mail-Followup-To: Peter Hagervall <hager@cs.umu.se>,
	linux-kernel@vger.kernel.org, torvalds@osdl.org
References: <20050215224553.GA24630@peppar.cs.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050215224553.GA24630@peppar.cs.umu.se>; from hager@cs.umu.se on Tue, Feb 15, 2005 at 11:45:53PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2005 at 11:45:53PM +0100, Peter Hagervall wrote:
> Cleaned up some address space issues in:

This is wrong, and highlights a problem with the "remote" dma pool API.
dma_alloc_coherent() normally returns CPU-local memory, unless you've
declared remote memory, in which case it's __iomem-type memory.

Therefore, I don't think we want to mark the return value of
dma_alloc_coherent with __iomem, because in the vast majority of
cases, it isn't.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
