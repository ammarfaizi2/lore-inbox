Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261303AbVEKWxC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261303AbVEKWxC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 18:53:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261635AbVEKWxC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 18:53:02 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:5647
	"EHLO g5.random") by vger.kernel.org with ESMTP id S261303AbVEKWwu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 18:52:50 -0400
Date: Thu, 12 May 2005 00:52:43 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: William Jordan <bjordan.ics@gmail.com>,
       Timur Tabi <timur.tabi@ammasso.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
Message-ID: <20050511225243.GM6313@g5.random>
References: <20050412180447.E6958@topspin.com> <20050425203110.A9729@topspin.com> <4279142A.8050501@ammasso.com> <427A6A7E.8000604@ammasso.com> <427BF8E1.2080006@ammasso.com> <Pine.LNX.4.61.0505071304010.4713@goblin.wat.veritas.com> <427CD49E.6080300@ammasso.com> <Pine.LNX.4.61.0505071617470.5718@goblin.wat.veritas.com> <78d18e2050511131246075b37@mail.gmail.com> <Pine.LNX.4.61.0505112129280.7826@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0505112129280.7826@goblin.wat.veritas.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2005 at 09:42:24PM +0100, Hugh Dickins wrote:
> proposed patches) there is no such migration of pages; that we'd prefer
> to implement migration in such a way that mlock does not inhibit it
> (though there might prove to be strong arguments defeating that);
> and that get_user_pages _must_ prevent migration (and if there
> were already such migration, I'd be saying it _does_ prevent it).

Indeed, mlock is a virtual pin and as such it won't be guaranteed to
always prevent migration. While get_user_pages is a physical pin on the
physical page so it has to prevent migration.

I think for him the physical pin is better since I guess IB would break
(at least unless you've some method to call to stop IB, adjust the IB
dma tracking, and restart IB, that hotplug can call). For the short term
using only get_user_pages sounds simpler IMHO.
