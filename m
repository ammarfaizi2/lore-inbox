Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135528AbRDSDEu>; Wed, 18 Apr 2001 23:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135529AbRDSDEk>; Wed, 18 Apr 2001 23:04:40 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:10256 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S135528AbRDSDE0>;
	Wed, 18 Apr 2001 23:04:26 -0400
Date: Thu, 19 Apr 2001 00:02:40 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Daniel Phillips <phillips@nl.linux.org>
Cc: jaharkes@cs.cmu.edu, adilger@turbolinux.com,
        ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Ext2 Directory Index - Delete Performance
In-Reply-To: <20010419012241Z92303-1659+7@humbolt.nl.linux.org>
Message-ID: <Pine.LNX.4.21.0104190001560.1685-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Apr 2001, Daniel Phillips wrote:
> Jan Harkes wrote:
> > On Thu, Apr 19, 2001 at 02:27:48AM +0200, Daniel Phillips wrote:
> > > more memory.  If you have enough memory, the inode cache won't thrash,
> > > and even when it does, it does so gracefully - performance falls off
> > > nice and slowly.  For example, 250 Meg of inode cache will handle 2
> > > million inodes with no thrashing at all.
> > 
> > What inode cache are you talking about? According to the slabinfo output
> > on my machine every inode takes up 480 bytes in the inode_cache slab. So
> > 250MB is only able to hold about half a million inodes in memory.           
>                                                                  
> Sorry, I was a little loose with terminology there.  I should have
> said "inode blocks in cache".  The inode cache is related.  When an
> Ext2 inode is pushed out of the inode cache it gets transfered to a
> dirty block in memory, where it shrinks to 128 bytes and shares the
> block with 31 other inodes.  These blocks are in the buffer cache, and
> this is the cache I'm talking about.

Hmmm, considering this, it may be wise to limit the amount of
inodes in the inode cache to, say, 10% of RAM ... because we
can cache MORE inodes if we store them in the buffer cache
instead!

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

