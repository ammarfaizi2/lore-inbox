Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267765AbTB1Kal>; Fri, 28 Feb 2003 05:30:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267771AbTB1Kal>; Fri, 28 Feb 2003 05:30:41 -0500
Received: from ns.suse.de ([213.95.15.193]:42508 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S267765AbTB1Kak>;
	Fri, 28 Feb 2003 05:30:40 -0500
Date: Fri, 28 Feb 2003 11:40:56 +0100
From: Andi Kleen <ak@suse.de>
To: Paul Menage <pmenage@ensim.com>
Cc: Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org, lse-tech@sourceforge.net
Subject: Re: [Lse-tech] Re: [PATCH] New dcache / inode hash tuning patch
Message-ID: <20030228104056.GA1647@wotan.suse.de>
References: <p73n0kg7qi7.fsf@amdsimf.suse.de> <E18ohjj-0005ls-00@pmenage-dt.ensim.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E18ohjj-0005ls-00@pmenage-dt.ensim.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2003 at 02:27:27AM -0800, Paul Menage wrote:
> >But for lookup walking even one cache line - the one containing d_hash -
> >should be needed. Unless d_hash is unlucky enough to cross a cache
> >line for its two members ... but I doubt that.
> 
> No, but on a 32-byte cache line system, d_parent, d_hash and d_name are
> all on different cache lines, and they're used when checking each entry.

... and dcache RCU checks d_bucket and d_move_count too in the hash 
walking loop.


> On 64-byte systems, d_parent and d_hash will be on the same line, but
> d_name is still on a separate line and d_name.hash gets checked before
> d_parent. So bringing these three fields on to the same cacheline
> would theoretically be a win.

Ok you're right. Optimizing the layout a bit would be probably a good 
idea. I won't include it in the hash patchkit for now to not do too
many things with the same patch.

-Andi
