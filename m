Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261508AbSJ1Var>; Mon, 28 Oct 2002 16:30:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261517AbSJ1Var>; Mon, 28 Oct 2002 16:30:47 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:11016 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261508AbSJ1Vap>; Mon, 28 Oct 2002 16:30:45 -0500
Date: Mon, 28 Oct 2002 21:37:00 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Martin Bligh <mjbligh@us.ibm.com>
Subject: Re: [rfc][patch] MAX_NR_NODES vs. MAX_NUMNODES
Message-ID: <20021028213700.D11734@flint.arm.linux.org.uk>
Mail-Followup-To: Matthew Dobson <colpatch@us.ibm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	William Lee Irwin III <wli@holomorphy.com>,
	Martin Bligh <mjbligh@us.ibm.com>
References: <3DB8927E.5090909@us.ibm.com> <20021025100028.A19335@flint.arm.linux.org.uk> <3DBD9434.5050601@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DBD9434.5050601@us.ibm.com>; from colpatch@us.ibm.com on Mon, Oct 28, 2002 at 11:47:00AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2002 at 11:47:00AM -0800, Matthew Dobson wrote:
> Hmmm...  MAX_NR_NODES is *definitely* available in the non-discontig 
> case.  In include/linux/param.h, MAX_NR_NODES (ifndef'd) is defined to 
> be 1.

I missed this bit.

> > That is why arm has asm/memory.h to contain everything related to memory
> > translation and discontig memory.
> This isn't *just* a discontig change.  CONFIG_DISCONTIGMEM is a 
> convenient option to key off of, but as the kernel becomes more and more 
> NUMA aware, the number of nodes in the system becomes a useful bit of 
> information to more and more of the code.  *That* is why (along with a 
> suggestion from wli) I put the #defines in param.h.

To me, it seems inappropriate to litter header files that contain
nothing to do with memory management with stuff from memory management
when other headers that already contain memory management bits get
ignored.  This type of practice is why we've ended up with #include
hell in the kernel today.

> > It would be better if it remained in mmzone.h for non-arm, and the
> > memory.h files for arm.  I really never understood why numnodes.h was
> > created when mmzone.h has works adequately well since 2.3.
>
> As mentioned in the original post, I was trying 
> to kill a bunch of (seemingly) unnecessary .h files (the numnodes.h's 
> specifically), and remove the MAX_[NUM|NR_]NODES duality.  If that can't 
> be accomplished, then all this would do is move the confusion around, 
> and I don't want that...

I'm in agreement with you here.

> If you feel param.h is the wrong place, I originally had the #define's 
> in asm/topology.h.

This seems like a good solution - linux/mmzone.h already includes this
file, so it wouldn't be adding all that much to the #include hell.
Also, asm-generic/topology.h contains stuff to do with numa/discontig
already, so it seems perfect.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

