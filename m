Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932359AbWG0I3e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbWG0I3e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 04:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbWG0I3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 04:29:34 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:27706 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932310AbWG0I3d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 04:29:33 -0400
Date: Thu, 27 Jul 2006 10:29:24 +0200
From: Jens Axboe <axboe@suse.de>
To: David Miller <davem@davemloft.net>
Cc: johnpol@2ka.mipt.ru, drepper@redhat.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: async network I/O, event channels, etc
Message-ID: <20060727082924.GK5282@suse.de>
References: <20060727.010255.87351515.davem@davemloft.net> <20060727080901.GG5282@suse.de> <20060727081114.GH5282@suse.de> <20060727.012037.78156999.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060727.012037.78156999.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27 2006, David Miller wrote:
> From: Jens Axboe <axboe@suse.de>
> Date: Thu, 27 Jul 2006 10:11:15 +0200
> 
> > Ownership transition from user -> kernel that is, what I'm trying to say
> > that returning ownership to the user again is the tricky part.
> 
> Yes, it is important that for TCP, for example, we don't give
> the user the event until the data is acknowledged and the skb's
> referencing that data are fully freed.
> 
> This is further complicated by the fact that packetization boundaries
> are going to be different from AIO buffer boundaries.
> 
> I think this is what you are alluding to.

Precisely. And this is the bit that is currently still broken for
splice-to-socket, since it gives that ack right after ->sendpage() has
been called. But that's a known deficiency right now, I think Alexey is
currently looking at that (as well as receive side support).

-- 
Jens Axboe

