Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261726AbULGBBS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261726AbULGBBS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 20:01:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261727AbULGBBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 20:01:18 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5574 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261726AbULGBBQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 20:01:16 -0500
Date: Mon, 6 Dec 2004 16:41:18 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Alain Tesio <alain@onesite.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: HIGHMEM=4G slows down ps2pdf with 2.4.28
Message-ID: <20041206184118.GA2282@dmt.cyclades>
References: <20041201232522.6e39c954@alain> <20041202190815.GA2843@dmt.cyclades> <20041203215819.15bab008@alain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041203215819.15bab008@alain>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2004 at 09:58:19PM +0100, Alain Tesio wrote:
> On Thu, 2 Dec 2004 17:08:15 -0200
> Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
> 
> > On Wed, Dec 01, 2004 at 11:25:22PM +0100, Alain Tesio wrote:
> > > Hi,
> > > 
> > > With a 2.4.28 kernel, 1.5 Go RAM and nothing exotic, everything works fine
> > > with CONFIG_HIGHMEM4G and CONFIG_HIGHMEM=y except that
> > > ps2pdf is about 30 times slower 
> 
> > How does /proc/mtrr look like? 
> > 
> > Maybe some of your memory is configured as uncacheable.
> 
> reg00: base=0x00000000 (   0MB), size=1024MB: write-back, count=1
> reg01: base=0x40000000 (1024MB), size= 256MB: write-back, count=1
> reg02: base=0x50000000 (1280MB), size= 128MB: write-back, count=1
> reg03: base=0x58000000 (1408MB), size=  64MB: write-back, count=1
> reg04: base=0x5c000000 (1472MB), size=  32MB: write-back, count=1
> reg05: base=0x5e000000 (1504MB), size=  16MB: write-back, count=1
> 
> I don't think that the hosting company played with the bios settings,
> and I don't do anything special with memory.

Alain,

All memory is correctly configured in MTRR it seems (all of it is write-back cacheable).

Do you have CONFIG_HIGHIO=y ? That might help a lot. The kernel has to use 
bounce buffers for IO otherwise.

