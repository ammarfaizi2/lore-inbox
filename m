Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129940AbQKHWEW>; Wed, 8 Nov 2000 17:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129938AbQKHWEM>; Wed, 8 Nov 2000 17:04:12 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:26884 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S129118AbQKHWD4>; Wed, 8 Nov 2000 17:03:56 -0500
Date: Thu, 9 Nov 2000 01:03:36 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Richard Henderson <rth@twiddle.net>
Cc: axp-list@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: PCI-PCI bridges mess in 2.4.x
Message-ID: <20001109010336.A1367@jurassic.park.msu.ru>
In-Reply-To: <20001101153420.A2823@jurassic.park.msu.ru> <20001101093319.A18144@twiddle.net> <20001103111647.A8079@jurassic.park.msu.ru> <20001103011640.A20494@twiddle.net> <20001106192930.A837@jurassic.park.msu.ru> <20001108013931.A26972@twiddle.net> <20001108142513.A5244@jurassic.park.msu.ru> <20001108093744.D27324@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20001108093744.D27324@twiddle.net>; from rth@twiddle.net on Wed, Nov 08, 2000 at 09:37:44AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2000 at 09:37:44AM -0800, Richard Henderson wrote:
> Interesting.  I hadn't known that.  It didn't actually fail with
> the ALI bridge, I just assumed it was a mistake.  Can anyone with
> docs on non-DEC bridges confirm that this is a common thing?

It would be better if someone who has "PCI-to-PCI Bridge Architecture
Specification" handy could confirm this. Non-conforming hardware
must live in quirks/fixups etc. ;-)

I've found some interesting info today - application note on programming
the DEC 21052 bridge (ruffian has this chip, btw):
http://download.sourceforge.net/mirrors/NetBSD/misc/dec-docs/ec-qlzba-te.ps.gz

Particularly, there are examples for setting up that bridge for IO or MEM
only configurations. For example, with IO disabled:
1. Set IO base = 0xffff, limit = 0
2. Set command register = PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER

> Certainly the fact should be commented if the old code goes back
> in to avoid disruption by helpful folks like myself.  :-)

That change wasn't bad at all - at least it's 100% safe :-)
But of course, it would be better to have unused regions disabled
in a clean way.

But actually I'm concerned that all this code doesn't work at all -
see reports from Michal Jaegermann (the bridge acts as if it drops
config space transactions randomly). I have a lot of suggestions, but
it's a pain to debug something without access to real hardware - just
a waste of the precious time of everyone who is involved...
So I would probably wait a week or two until I'll have something with
bridges :-(

Ivan.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
