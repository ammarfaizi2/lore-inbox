Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262859AbTJPLoo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 07:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262861AbTJPLoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 07:44:44 -0400
Received: from unthought.net ([212.97.129.88]:20895 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S262859AbTJPLom (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 07:44:42 -0400
Date: Thu, 16 Oct 2003 13:44:40 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: "Frederick, Fabian" <Fabian.Frederick@prov-liege.be>
Cc: mru@users.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: About _real_ free memory
Message-ID: <20031016114440.GD8711@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	"Frederick, Fabian" <Fabian.Frederick@prov-liege.be>,
	mru@users.sourceforge.net, linux-kernel@vger.kernel.org
References: <D9B4591FDBACD411B01E00508BB33C1B01F6EE59@mesadm.epl.prov-liege.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D9B4591FDBACD411B01E00508BB33C1B01F6EE59@mesadm.epl.prov-liege.be>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 16, 2003 at 11:04:14AM +0200, Frederick, Fabian wrote:
> If a process tries to allocate and use more than the really free
> amount, some cache will be dropped automatically.  From a performance
> point of view, this could of course be undesirable, but normally
> there's no need to think about it.
> 
> <Why don't we have a command to drop some cache ? or maybe some
> <kernel rules to do it ? we could gain some more scalability doing that kind
> of
> <stuff during low load.

No - you would throw out disk cache with the risk of throwing out
potentially useful data.  The data can be thrown out *immediately*
anyway if someone needs it.

So:  gain: zero
     loss: likely noticable
   ------------------------------
    total: bad idea

>Another problem is end-user point of view :
> 
> <	-What's available on a box before swapping ?
> <	-Do I have to add RAM right now ?

[albatross:joe] $ free
             total       used       free     shared    buffers
cached
Mem:       1033944     902036     131908          0      41120
446456
-/+ buffers/cache:     414460     619484
Swap:      2101000     294552    1806448

I have 619 MB of free memory now, if you do not count in the caches.

The free physical memory is around 132 MB - this number tells me how
much memory the kernel could not find a use for (for either processes or
cache) - e.g. the amount of memory that I paid for but is not doing
anything useful.

You want the physical free memory to be as low as possible - it is the
amount of memory that is being wasted in the system by not doing
anything useful.  If the user cannot understand this, they should learn
not to care either.  Certainly, you should never ruin the workings of
the VM subsystem by freeing useful cache memory, just so a user who has
no understanding of what is actually going on, can get a nice big number
in his 'free' output.

Maybe one could patch the 'free' utility instead?   ;)

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
