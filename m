Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318469AbSGaUAr>; Wed, 31 Jul 2002 16:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318470AbSGaUAr>; Wed, 31 Jul 2002 16:00:47 -0400
Received: from mail.zmailer.org ([62.240.94.4]:33729 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S318469AbSGaUAq>;
	Wed, 31 Jul 2002 16:00:46 -0400
Date: Wed, 31 Jul 2002 23:04:12 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Christoph Hellwig <hch@infradead.org>,
       "Peter J. Braam" <braam@clusterfs.com>, linux-kernel@vger.kernel.org
Subject: Re: BIG files & file systems
Message-ID: <20020731230412.B1237@mea-ext.zmailer.org>
References: <20020731131620.M15238@lustre.cfs> <20020731202638.A22765@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020731202638.A22765@infradead.org>; from hch@infradead.org on Wed, Jul 31, 2002 at 08:26:38PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2002 at 08:26:38PM +0100, Christoph Hellwig wrote:
> On Wed, Jul 31, 2002 at 01:16:20PM -0600, Peter J. Braam wrote:
> > Hi, 
> > 
> > I've just been told that some "limitations" of the following kind will
> > remain:
> > 
> >   page index = unsigned long
> >   ino_t      = unsigned long
> > 
> > Lustre has definitely been asked to support much larger files than
> > 16TB.  Also file systems with a trillion files have been requested by
> > one of our supporters (you don't want to know who, besides I've no
> > idea how many bits go in a trillion, but it's more than 32).
> 
> What about using 64bit machines? ..

  It depends on many things:
   - Block layer (unsigned long)
   - Page indexes (unsigned long)
   - Filesystem format dependent limits
      - EXT2/EXT3: u32_t FILESYSTEM block index, presuming the EXT2/EXT3
                   is supported only up to 4 kB block sizes, that gives
                   you a very hard limit.. of 16 terabytes (16 * "10^12")
      - ReiserFS:  u32_t block indexes presently, u64_t in future;
                   block size ranges ?   Max size is limited by the
                   maximum supported file size, likely 2^63, which is
                   roughly  8 * "10^18", or circa 500 000 times larger
                   than EXT2/EXT3 format maximum.
      - ClusterFS: (Braam et.al.): 64 bit block indexes ?
                   System file size limitation, same as with ReiserFS.

      (Just to illustriate a few..)


/Matti Aarnio
