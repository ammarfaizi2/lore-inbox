Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311733AbSCNSvj>; Thu, 14 Mar 2002 13:51:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311732AbSCNSv3>; Thu, 14 Mar 2002 13:51:29 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:27922 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S311729AbSCNSvU>;
	Thu, 14 Mar 2002 13:51:20 -0500
Date: Thu, 14 Mar 2002 19:50:45 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: suparna@in.ibm.com, linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        andre@linux-ide.org, bcrl@redhat.com
Subject: Re: 2.5.6: ide driver broken in PIO mode
Message-ID: <20020314185045.GN5441@suse.de>
In-Reply-To: <Pine.LNX.4.21.0203131339050.26768-100000@serv> <a6o30m$25j$1@penguin.transmeta.com> <20020313203408.GD20220@suse.de> <20020314213611.A1884@in.ibm.com> <3C90EF20.CB3A4415@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C90EF20.CB3A4415@zip.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14 2002, Andrew Morton wrote:
> Suparna Bhattacharya wrote:
> > 
> > ...
> > However, the latest code I have also covers the avoidance of bv_len,
> > bv_offset modifications by the block layer, which I'd been
> > concerned about for quite a while and ought to have done something about
> > much sooner ;)
> 
> urgh.  I didn't know there was a risk of this.
> 
> I'm using bv_offset and bv_len in the bi_end_io handler to work out
> whether to unlock the final page in the multipage BIO.
> 
> That can probably be avoided, but it would be better if these
> can be left alone, or at least, restored to their original value
> before returning the BIO to whoever created it.

Suparna's addition will be added, so we maintain the same length and
offset throughout.

> I'm also using bi_private, under the assumption that the ownership
> rules for that are analogous to buffer_head.b_private.   Is this
> correct?   Who owns bi_private?

Same semantics as b_priate, so don't worry :)

-- 
Jens Axboe

