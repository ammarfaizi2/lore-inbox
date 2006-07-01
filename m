Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932442AbWGAI1i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932442AbWGAI1i (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 04:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932710AbWGAI1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 04:27:38 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:30912 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932442AbWGAI1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 04:27:37 -0400
Subject: Re: [PATCH] Add memcpy_nc, a copy routine that tries to keep cache
	pressure down
From: Arjan van de Ven <arjan@infradead.org>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: linux-kernel@vger.kernel.org, davem@davemloft.net
In-Reply-To: <c37555581c772bf5c94a.1151729772@eng-12.pathscale.com>
References: <c37555581c772bf5c94a.1151729772@eng-12.pathscale.com>
Content-Type: text/plain
Date: Sat, 01 Jul 2006 10:27:34 +0200
Message-Id: <1151742454.3195.10.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-30 at 21:56 -0700, Bryan O'Sullivan wrote:
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

Hi,

can we give this a more descriptive name please? Say
memcpy_cachebypass() or something? "_nc" doesn't say a lot of things to
many people... which means it'll either not get used when it should, or
it gets used when it shouldn't....

Greetings,
    Arjan van de Ven

