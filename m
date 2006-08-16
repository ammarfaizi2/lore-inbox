Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751072AbWHPJoi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbWHPJoi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 05:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751075AbWHPJoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 05:44:38 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:28899 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751070AbWHPJoh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 05:44:37 -0400
Date: Wed, 16 Aug 2006 10:44:31 +0100
From: Christoph Hellwig <hch@infradead.org>
To: David Miller <davem@davemloft.net>
Cc: hch@infradead.org, johnpol@2ka.mipt.ru, arnd@arndb.de,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [PATCH 1/1] network memory allocator.
Message-ID: <20060816094431.GA21118@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Miller <davem@davemloft.net>, johnpol@2ka.mipt.ru,
	arnd@arndb.de, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20060816091029.GA6375@infradead.org> <20060816093159.GA31882@2ka.mipt.ru> <20060816093837.GA11096@infradead.org> <20060816.024008.74744877.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060816.024008.74744877.davem@davemloft.net>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2006 at 02:40:08AM -0700, David Miller wrote:
> From: Christoph Hellwig <hch@infradead.org>
> Date: Wed, 16 Aug 2006 10:38:37 +0100
> 
> > We could, but I'd rather waste 4 bytes in struct net_device than
> > having such ugly warts in common code.
> 
> Why not instead have struct device store some default node value?
> The node decision will be sub-optimal on non-pci but it won't crash.

Right now we don't even have the node stored in the pci_dev structure but
only arch-specific accessor functions/macros.  We could change those to
take a struct device instead and make them return -1 for everything non-pci
as we already do in architectures that don't support those helpers.  -1
means 'any node' for all common allocators.
