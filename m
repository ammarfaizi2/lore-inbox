Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129693AbRBVDom>; Wed, 21 Feb 2001 22:44:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129782AbRBVDoX>; Wed, 21 Feb 2001 22:44:23 -0500
Received: from hermes.mixx.net ([212.84.196.2]:9480 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S129693AbRBVDoM>;
	Wed, 21 Feb 2001 22:44:12 -0500
Message-ID: <3A948ACB.7B55BEAE@innominate.de>
Date: Thu, 22 Feb 2001 04:43:07 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [rfc] Near-constant time directory index for Ext2
In-Reply-To: <200102220203.f1M237Z20870@webber.adilger.net> <3A947C54.E4750E74@transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" wrote:
> 
> Andreas Dilger wrote:
> >
> > Basically (IMHO) we will not really get any noticable benefit with 1 level
> > index blocks for a 1k filesystem - my estimates at least are that the break
> > even point is about 5k files.  We _should_ be OK with 780k files in a single
> > directory for a while.
> >
> 
> I've had a news server with 2000000 files in one directory.  Such a
> filesystem is likely to use small blocks, too, because each file is
> generally small.
> 
> This is an important connection: filesystems which have lots and lots of
> small files will have large directories and small block sizes.

I mentioned this earlier but it's worth repeating: the desire to use a
small block size is purely an artifact of the fact that ext2 has no
handling for tail block fragmentation.  That's a temporary situation -
once we've dealt with it your 2,000,000 file directory will be happier
with 4K filesystem blocks.  There will be a lot fewer metadata index
blocks in your directory file, for one thing.  Another practical matter
is that 4K filesystem blocks map directly to 4K PAGE_SIZE and are as a
result friendlier to the page cache and memory manager.

--
Daniel
