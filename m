Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274585AbRIYJ75>; Tue, 25 Sep 2001 05:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274587AbRIYJ7i>; Tue, 25 Sep 2001 05:59:38 -0400
Received: from pD957B27A.dip.t-dialin.net ([217.87.178.122]:2052 "EHLO
	enigma.deepspace.net") by vger.kernel.org with ESMTP
	id <S274585AbRIYJ7f>; Tue, 25 Sep 2001 05:59:35 -0400
Message-Id: <200109251000.MAA00463@enigma.deepspace.net>
Content-Type: text/plain; charset=US-ASCII
From: Wolly <wwolly@gmx.net>
To: Andre Pang <ozone@algorithm.com.au>, linux-kernel@vger.kernel.org
Subject: Re: Huge disk performance degradation STILL IN 2.4.10
Date: Tue, 25 Sep 2001 12:00:00 +0200
X-Mailer: KMail [version 1.2.1]
In-Reply-To: <200109211723.TAA00638@enigma.deepspace.net> <200109241505.RAA12224@enigma.deepspace.net> <1001344775.069479.26256.nullmailer@bozar.algorithm.com.au>
In-Reply-To: <1001344775.069479.26256.nullmailer@bozar.algorithm.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 24 September 2001 17:19, Andre Pang wrote:
> On Mon, Sep 24, 2001 at 05:05:13PM +0200, Wolly wrote:
> > Okay, I plugged some old hd into my computer and formatted one
> > half with ext2, the other half with reiserfs.  It seems to be
> > definitely a reiserfs issue because I cannot trigger the
> > performance loss (permament hd head positioning) with ext2.
>
> This might sound pedantic, but is ext2 on the first half of your
> hard disk and reiserfs on the second half?  If so, that could skew
> your results.  Try putting the reiserfs in the first half of the
> disk and see if that makes a difference.
>
Well, actually this lead me to another idea: I created a disk image 
on my reiserfs home partition (the one I usually use to trigger the 
problem; note however that I can also reproduce it on my PII-350). 

Firstly, I formatted the image with ext2 and run the file creation script. 
No problems, it works fine. 

Then, I formatted the image with reiserfs and tried the file creation 
script. No problems either.. Strange. 

I doubt it's a fragmentation issue (as kernel-2.4.6 does not have the 
problem and the image file would be fragmented as well). 

Could this be some sort of reiserfs flushing issue? 
<speculation> I mean reiserfs wants to flush the newly created files 
too frequently. If reiserfs is on a disk partition, then this results in 
the performance degradation, if it is on an image, all requests to write 
to the image are cached again (by the reiserfs one level below which 
works fine because there is just manipulation of one large file) and the 
problem does not show up. </speculation>

Okay, as just a few people on the list seem to worry about the issue, 
I spent an hour online and downloaded kernel 2.4.6 + patches for 
2.4.[789] again to see exactly where the problem begins. 

Wolly
