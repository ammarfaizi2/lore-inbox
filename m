Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267459AbRGLJ0v>; Thu, 12 Jul 2001 05:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267461AbRGLJ0l>; Thu, 12 Jul 2001 05:26:41 -0400
Received: from ns.suse.de ([213.95.15.193]:24588 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S267459AbRGLJ0Z>;
	Thu, 12 Jul 2001 05:26:25 -0400
Date: Thu, 12 Jul 2001 11:26:13 +0200
From: Andi Kleen <ak@suse.de>
To: lvm-devel@sistina.com
Cc: Lance Larsh <llarsh@oracle.com>,
        Brian Strand <bstrand@switchmanagement.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [lvm-devel] Re: 2x Oracle slowdown from 2.2.16 to 2.4.4
Message-ID: <20010712112613.A14134@gruyere.muc.suse.de>
In-Reply-To: <3B4C8263.6000407@switchmanagement.com> <Pine.LNX.4.21.0107111530170.2342-100000@llarsh-pc3.us.oracle.com> <20010712043046.R3496@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010712043046.R3496@athlon.random>; from andrea@suse.de on Thu, Jul 12, 2001 at 04:30:46AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2001 at 04:30:46AM +0200, Andrea Arcangeli wrote:
> I will soon somehow make those changes in the lvm (based on beta7) in my
> tree and it will be interesting to see if this will make a difference. I
> will also have a look to see if I can improve a little more the lvm_map
> but other than those non rw semaphores there should be not a significant
> overhead to remove in the lvm fast path.

Even if you fix the snapshot_sem you still have the down on the _pe_lock 
in lvm_map. The part covered by the PE lock is only a few tenths of cycles
shorter than the part covered by the snapshot semaphore; so it is unlikely
that you see much difference unless you change both to rwsems.

Wouldn't a single semaphore be enough BTW to cover both? 


-Andi



