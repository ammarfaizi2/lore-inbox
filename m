Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263228AbSJCJrr>; Thu, 3 Oct 2002 05:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263229AbSJCJrr>; Thu, 3 Oct 2002 05:47:47 -0400
Received: from unthought.net ([212.97.129.24]:31203 "EHLO mail.unthought.net")
	by vger.kernel.org with ESMTP id <S263228AbSJCJrq>;
	Thu, 3 Oct 2002 05:47:46 -0400
Date: Thu, 3 Oct 2002 11:53:16 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: AARGH! Please help. IDE controller fsckup
Message-ID: <20021003095316.GC7350@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
	Kernel mailing list <linux-kernel@vger.kernel.org>
References: <200210021516.46668.roy@karlsbakk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200210021516.46668.roy@karlsbakk.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2002 at 03:16:46PM +0200, Roy Sigurd Karlsbakk wrote:
> hi all
> 
> I have this cute little server with some 16 120gig IDE drives, and I've got 
> some serious problems with it.
> 
> Controllers:
> One onboard IDE controller (2 channels).
> Two promise ATA100 (2 channels each).
> One CMD649 (2 channels).
> 
> something seriously bad about the CMD649 makes Linux beleive it's the first 
> controller with hd[abcd]. On these, there are two RAID-1s (/ and /var). Due 
> to the fact that the box has some 1,6TB disk space, we haven't got any backup 
> solution (we have an identical box in order to mirror them).
> 
> so - now - the CMD649 has suddenly begun to fail - losing contact with one or 
> two drives, and I _really_ need to get what's on /data (RAID-5 on 
> hd[efghijklmnop]) out. Problem is - the replacement controller I've got from 
> the vendor works fine (turns up as controller 3 serving hd[mnop]). How can I 
> revert this most easily to be able to boot again?

Hindsight:  had you used persistent superblocks, this would not have
been a problem.  The kernel would know the correct ordering from the
superblocks, not the device names.

Solution 1: Write to the RAID mailing list and have one of the mdadm
gurus give you a one-liner to initialize the array with the proper
ordering.

Solution 2: Edit your /etc/raidtab to reflect the new device naming and
run raidstart.

If you start up the array with a bad ordering, no amount of magic is
going to bring back you data (after parity has been "reconstructed" on
various chunks of your existing data).


> 
> I hope this is not too off topic... Please excuse that.
> 

linux-raid is a better place.


Cheers,

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
