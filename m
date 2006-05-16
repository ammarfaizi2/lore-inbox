Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750729AbWEPUFL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbWEPUFL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 16:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751007AbWEPUFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 16:05:10 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:56483 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750797AbWEPUFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 16:05:09 -0400
Date: Tue, 16 May 2006 21:05:01 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: Roland Dreier <rdreier@cisco.com>, openib-general@openib.org,
       linux-kernel@vger.kernel.org,
       Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 21 of 53] ipath - use phys_to_virt instead of bus_to_virt
Message-ID: <20060516200501.GA5060@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Bryan O'Sullivan <bos@pathscale.com>,
	Roland Dreier <rdreier@cisco.com>, openib-general@openib.org,
	linux-kernel@vger.kernel.org,
	Segher Boessenkool <segher@kernel.crashing.org>
References: <4e0a07d20868c6c4f038.1147477386@eng-12.pathscale.com> <adad5efuw1o.fsf@cisco.com> <1147728081.2773.25.camel@chalcedony.pathscale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1147728081.2773.25.camel@chalcedony.pathscale.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2006 at 02:21:21PM -0700, Bryan O'Sullivan wrote:
> On Mon, 2006-05-15 at 08:50 -0700, Roland Dreier wrote:
> 
> > Actually I NAK'ed this patch.  It compiles the same thing on x86_64
> > but makes the source code wrong -- dma_map_single() returns a bus
> > address, not a physical address.
> 
> As Segher mentioned, bus_to_virt is unportable, so it's definitely the
> wrong thing to use.

phys_to_virt is as bad.  please fix your code to do the right thing, that
is to stop pretending to be able to map back from a bus to a virtual address.
The only way to get at the virtual address from a bus one is to store it
away at the time you call the dma mapping function.

