Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266598AbUFRSU0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266598AbUFRSU0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 14:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266600AbUFRSU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 14:20:26 -0400
Received: from outmail1.freedom2surf.net ([194.106.33.237]:40081 "EHLO
	outmail.freedom2surf.net") by vger.kernel.org with ESMTP
	id S266598AbUFRSUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 14:20:19 -0400
Date: Fri, 18 Jun 2004 19:19:58 +0100
From: Ian Molton <spyro@f2s.com>
To: Matt Porter <mporter@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com, tony@atomide.com,
       david-b@pacbell.net, jamey.hicks@hp.com, joshua@joshuawise.com
Subject: Re: DMA API issues
Message-Id: <20040618191958.1cc3508c.spyro@f2s.com>
In-Reply-To: <20040618110721.B3851@home.com>
References: <20040618175902.778e616a.spyro@f2s.com>
	<20040618110721.B3851@home.com>
Organization: The Dragon Roost
X-Mailer: Sylpheed version 0.9.12-gtk2-20040617 (GTK+ 2.4.1; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jun 2004 11:07:21 -0700
Matt Porter <mporter@kernel.crashing.org> wrote:

> Can't you just implement an arch-specific allocator for your 32KB
> SRAM, then implement the DMA API streaming and dma_alloc/free APIs
> on top of that?

Yes but thats not very generic is it? Im not the only one with this
problem.

>  Since this architecture is obviously not designed
> for performance

What makes you think writes to the 32K SRAM are any slower than to the
SDRAM? the device is completely memory mapped.

>, it doesn't seem to be a big deal to have the streaming
> APIs copy to/from the kmalloced (or whatever) buffer to/from the SRAM
> allocated memory and then have those APIs return the proper dma_addr_t
> for the embedded OHCI's address space view of the SRAM.

Again its a suboptimal solution, and on an architecture where the CPU
isnt *that* fast in the first place it seems wrong to deliberately
choose the slowest possible route...
