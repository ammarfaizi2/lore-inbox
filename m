Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262834AbREVVSh>; Tue, 22 May 2001 17:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262829AbREVVS2>; Tue, 22 May 2001 17:18:28 -0400
Received: from geos.coastside.net ([207.213.212.4]:25534 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S262828AbREVVST>; Tue, 22 May 2001 17:18:19 -0400
Mime-Version: 1.0
Message-Id: <p05100314b7308648117b@[207.213.214.37]>
In-Reply-To: <20010522140206.B4662@twiddle.net>
In-Reply-To: <15112.62766.368436.236478@pizda.ninka.net>
 <20010521131959.M30738@athlon.random>
 <20010521155151.A10403@jurassic.park.msu.ru>
 <20010521105339.A1907@twiddle.net> <20010522025658.A1116@athlon.random>
 <20010522162916.B15155@athlon.random>
 <20010522184409.A791@jurassic.park.msu.ru>
 <20010522170016.D15155@athlon.random> <20010522132815.A4573@twiddle.net>
 <p05100312b7307eda5292@[207.213.214.37]>
 <20010522140206.B4662@twiddle.net>
Date: Tue, 22 May 2001 14:17:21 -0700
To: Richard Henderson <rth@twiddle.net>
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: alpha iommu fixes
Cc: Andrea Arcangeli <andrea@suse.de>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        linux-kernel@vger.kernel.org, "David S. Miller" <davem@redhat.com>
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 2:02 PM -0700 2001-05-22, Richard Henderson wrote:
>On Tue, May 22, 2001 at 01:48:23PM -0700, Jonathan Lundell wrote:
>>  64KB for 8-bit DMA; 128KB for 16-bit DMA. [...]  This doesn't
>>  apply to bus-master DMA, just the legacy (8237) stuff.
>
>Would this 8237 be something on the ISA card, or something on
>the old pc mainboards?  I'm wondering if we can safely ignore
>this issue altogether here...

On the main board, and not just the old ones. These days it's 
typically in the chipset's south bridge. "Third-party DMA" is 
sometimes called "fly-by DMA". The ISA card is a slave, as is memory, 
and the DMA chip reads from one ands writes to the other.

IDE didn't originally use DMA at all (but floppies did), just 
programmed IO. These days, PC chipsets mostly have some form of 
extended higher-performance DMA facilities for stuff like IDE, but 
I'm not really familiar with the details.

<aside>I do wish Linux didn't have so much PC legacy sh^Htuff 
embedded into the i386 architecture.</aside>

>  > There was also a 24-bit address limitation.
>
>Yes, that's in the number of address lines going to the isa card.
>We work around that one by having an iommu arena from 8M to 16M
>and forcing all ISA traffic to go through there.


-- 
/Jonathan Lundell.
