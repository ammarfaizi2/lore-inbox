Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312213AbSCRGoN>; Mon, 18 Mar 2002 01:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312217AbSCRGoD>; Mon, 18 Mar 2002 01:44:03 -0500
Received: from THANK.THUNK.ORG ([216.175.175.163]:30619 "EHLO thunk.org")
	by vger.kernel.org with ESMTP id <S312213AbSCRGnv>;
	Mon, 18 Mar 2002 01:43:51 -0500
Date: Sun, 17 Mar 2002 17:09:55 -0500
From: Theodore Tso <tytso@mit.edu>
To: Anton Blanchard <anton@samba.org>
Cc: Gerrit Huizenga <gh@us.ibm.com>, lse-tech@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] 7.52 second kernel compile
Message-ID: <20020317170955.A491@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Anton Blanchard <anton@samba.org>, Gerrit Huizenga <gh@us.ibm.com>,
	lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20020316061535.GA16653@krispykreme> <E16m7u7-0007yv-00@w-gerrit2> <20020317123434.GE22387@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 17, 2002 at 11:34:34PM +1100, Anton Blanchard wrote:
> 
> > And this *without* the dcache_lock?  Hmm.  So you are saying there
> > may still be room for improvement?
> 
> I tried the dcache lock patches but found it hard to see a difference,
> for us the mm stuff still seems to be the bottleneck.

Try the patch which gets rid of the BKL in ext2_get_block() --- if you
don't have that, let me know, I've got one kicking around that mostly
works except I haven't validated that it does the right thing if
quotas are enabled.  If you're running with a cold page cache, I
suspect that will help out much more.  If the numbers are assuming a
page-cache already preloaded with then getting rid of the BKL in
ext2_get_block() will help somewhat, but maybe not enough to be
significant.

						- Ted
