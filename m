Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751155AbWHPMpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbWHPMpF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 08:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbWHPMpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 08:45:05 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:53429 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1751155AbWHPMpE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 08:45:04 -0400
Date: Wed, 16 Aug 2006 16:44:49 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Mika =?utf-8?B?UGVudHRpbMOk?= <mika.penttila@kolumbus.fi>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [take10 1/2] kevent: Core files.
Message-ID: <20060816124448.GA17287@2ka.mipt.ru>
References: <11557316932803@2ka.mipt.ru> <44E3118A.20402@kolumbus.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44E3118A.20402@kolumbus.fi>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Wed, 16 Aug 2006 16:44:50 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2006 at 03:37:30PM +0300, Mika Penttilä (mika.penttila@kolumbus.fi) wrote:
> +void kevent_user_ring_add_event(struct kevent *k)
> +{
> +	unsigned int pidx, off;
> +	struct kevent_mring *ring, *copy_ring;
> +
> +	ring = (struct kevent_mring *)k->user->pring[0];
> +	
> +	pidx = ring->index/KEVENTS_ON_PAGE;
> +	off = ring->index%KEVENTS_ON_PAGE;
> +
> +	copy_ring = (struct kevent_mring *)k->user->pring[pidx];
> +
> +	copy_ring->event[off].id.raw[0] = k->event.id.raw[0];
> +	copy_ring->event[off].id.raw[1] = k->event.id.raw[1];
> +	copy_ring->event[off].ret_flags = k->event.ret_flags;
> +
> +	if (++ring->index >= KEVENT_MAX_EVENTS)
> +		ring->index = 0;
> +}
> 
> Can you assume that the page at pidx is already allocated and why?

It is checked and allocated if needed in kevent_user_ring_grow(), which
is called for each new kevent.

> --Mika
> 

-- 
	Evgeniy Polyakov
