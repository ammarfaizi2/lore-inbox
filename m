Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265517AbUGITvJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265517AbUGITvJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 15:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265812AbUGITvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 15:51:09 -0400
Received: from [213.146.154.40] ([213.146.154.40]:34992 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265517AbUGITvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 15:51:06 -0400
Date: Fri, 9 Jul 2004 20:51:05 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040709195105.GA4807@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
	Arjan van de Ven <arjanv@redhat.com>
References: <20040709182638.GA11310@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040709182638.GA11310@elte.hu>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> unlike the lowlatency patches, this patch doesn't add a lot of new
> scheduling points to the source code, it rather reuses a rich but
> currently inactive set of scheduling points that already exist in the
> 2.6 tree: the might_sleep() debugging checks. Any code point that does
> might_sleep() is in fact ready to sleep at that point. So the patch
> activates these debugging checks to be scheduling points. This reduces
> complexity and impact quite significantly.

I don't think this is a good idea.  Just because a function might sleep
it doesn't mean it should sleep.  I'd rather add the might_sleep() to
cond_resched() and replace the former with the latter in the cases where
it makes sense.

