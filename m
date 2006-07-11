Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751318AbWGKU4l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbWGKU4l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 16:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbWGKU4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 16:56:41 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:16346 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751314AbWGKU4k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 16:56:40 -0400
Subject: Re: [PATCH] Add memcpy_cachebypass, a copy routine that tries to
	keep cache pressure down
From: Arjan van de Ven <arjan@infradead.org>
To: "Bryan O'Sullivan" <bos@serpentine.com>
Cc: linux-kernel@vger.kernel.org, davem@davemloft.net
In-Reply-To: <da0cd816c4cb37c4376b.1152651055@localhost.localdomain>
References: <da0cd816c4cb37c4376b.1152651055@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 11 Jul 2006 22:56:38 +0200
Message-Id: <1152651398.3128.125.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-11 at 13:50 -0700, Bryan O'Sullivan wrote:
> This copy routine is memcpy-compatible, but on some architectures will use
> cache-bypassing loads to avoid bringing the source data into the cache.
> 
> One case where this is useful is when a device issues a DMA to a memory
> region, and the CPU must copy the DMAed data elsewhere before doing any
> work with it.  Since the source data is read-once, write-never from the
> CPU's perspective, caching those addresses can only evict potentially
> useful data.
> 
> We provide an x86_64 implementation that uses SSE non-temporal loads,
> and a generic version that falls back to plain memcpy.
> 
> Implementors for other arches should not use cache-bypassing stores to
> the destination, as in most cases, the destination is accessed almost
> immediately after a copy finishes.
> 
> Signed-off-by: Ralph Campbell <ralph.campbell@qlogic.com>
> Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>


Acked-by: Arjan van de Ven <arjan@Linux.intel.com>


