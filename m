Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263274AbTDCFXO>; Thu, 3 Apr 2003 00:23:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263275AbTDCFXO>; Thu, 3 Apr 2003 00:23:14 -0500
Received: from nessie.weebeastie.net ([61.8.7.205]:27103 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id <S263274AbTDCFXL>; Thu, 3 Apr 2003 00:23:11 -0500
Date: Thu, 3 Apr 2003 15:35:43 +1000
From: CaT <cat@zip.com.au>
To: Christoph Rohland <cr@sap.com>
Cc: Hugh Dickins <hugh@veritas.com>, tomlins@cam.org,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH: allow percentile size of tmpfs (2.5.66 / 2.4.20-pre2)
Message-ID: <20030403053543.GK2107@zip.com.au>
References: <Pine.LNX.4.44.0304011734370.1503-100000@localhost.localdomain> <ovd6k5l60d.fsf@sap.com> <20030402144432.GB536@zip.com.au> <ovadf8ls8e.fsf@sap.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ovadf8ls8e.fsf@sap.com>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 02, 2003 at 07:33:05PM +0200, Christoph Rohland wrote:
> On Thu, 3 Apr 2003, cat@zip.com.au wrote:
> > Sounds like what you want is a dynamically resizing tmpfs based on
> > the amount of memory (ram+swap) available. That's a much bigger
> > goose to fry I believe.
> > 
> > Now, even if the percentile patch took into account swap, you'd
> > still need to remount tmpfs in order to get it to take into account
> > of any swap you add on the fly.
> 
> No, that's why I said you would need hooks into swapon and
> swapoff. Then it would adjust on the fly. Else it's useless from the

Ahh. Missed that. Sorry.

> usability point of view. With these hooks it's easy to do.

Yes. That'd solve that issue. You'd have it resize itself to your fixed
% of the new totals.

> >> could add much saner defaults for /dev/shm or even use it for /tmp.
> > 
> > I use it for /tmp now just fine. :) It's sized at 63% of 256MB of
> > RAM.
> 
> And I have set it to 400MB on a 256MB box just fine ;-) How could you

:)

> do these two setup generally without knowing your hardware. 20MB tmpfs

If you want to take swap into account you still can't but then this
patch changes nothing for you in either case. You'd still specify 400MB
or (now) 156%.

> on a 40MB machine can be a desaster btw.

It can be, depending on what you do with it, obviously. That's not an
argument against this and I'm not actually against it myself. I just
want the current patch in cos at least it's a step in the right
direction, it's simple and it ups the usability of tmpfs (and it stops
me from having to patch my kernel each and every time ;).

Personally I'd like a flag to set wether or not to take it into account
because it introduces a 2nd potential variable number into the equation
and I don't want my setting depending on swap suddenly dropping off Gods
green, somewhat polluted and messy, earth. I'd be in the same boat I was
in before the patch.

-- 
"Other countries of course, bear the same risk. But there's no doubt his
hatred is mainly directed at us. After all this is the guy who tried to
kill my dad."
        - George W. Bush Jr, Leader of the United States Regime
          September 26, 2002 (from a political fundraiser in Houston, Texas)
