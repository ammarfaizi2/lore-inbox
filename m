Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311723AbSCNSoh>; Thu, 14 Mar 2002 13:44:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311726AbSCNSo2>; Thu, 14 Mar 2002 13:44:28 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:21009 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S311723AbSCNSoW>; Thu, 14 Mar 2002 13:44:22 -0500
Message-ID: <3C90EF20.CB3A4415@zip.com.au>
Date: Thu, 14 Mar 2002 10:42:40 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: suparna@in.ibm.com
CC: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com, andre@linux-ide.org, bcrl@redhat.com
Subject: Re: 2.5.6: ide driver broken in PIO mode
In-Reply-To: <Pine.LNX.4.21.0203131339050.26768-100000@serv> <a6o30m$25j$1@penguin.transmeta.com> <20020313203408.GD20220@suse.de>,
		<20020313203408.GD20220@suse.de>; from axboe@suse.de on Wed, Mar 13, 2002 at 09:34:08PM +0100 <20020314213611.A1884@in.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suparna Bhattacharya wrote:
> 
> ...
> However, the latest code I have also covers the avoidance of bv_len,
> bv_offset modifications by the block layer, which I'd been
> concerned about for quite a while and ought to have done something about
> much sooner ;)

urgh.  I didn't know there was a risk of this.

I'm using bv_offset and bv_len in the bi_end_io handler to work out
whether to unlock the final page in the multipage BIO.

That can probably be avoided, but it would be better if these
can be left alone, or at least, restored to their original value
before returning the BIO to whoever created it.

I'm also using bi_private, under the assumption that the ownership
rules for that are analogous to buffer_head.b_private.   Is this
correct?   Who owns bi_private?


-
