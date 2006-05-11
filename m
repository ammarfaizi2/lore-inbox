Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750781AbWEKUkc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbWEKUkc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 16:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbWEKUkc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 16:40:32 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:37138 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750781AbWEKUkc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 16:40:32 -0400
Date: Thu, 11 May 2006 22:40:33 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Al Viro <viro@ftp.linux.org.uk>, davem@davemloft.net, dwalker@mvista.com,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] sys_semctl gcc 4.1 warning fix
Message-ID: <20060511204033.GB3570@stusta.de>
References: <20060510162106.GC27946@ftp.linux.org.uk> <20060510150321.11262b24.akpm@osdl.org> <20060510221024.GH27946@ftp.linux.org.uk> <20060510.153129.122741274.davem@davemloft.net> <20060510224549.GI27946@ftp.linux.org.uk> <20060510160548.36e92daf.akpm@osdl.org> <20060510232042.GJ27946@ftp.linux.org.uk> <20060510164554.27a13ca9.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060510164554.27a13ca9.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2006 at 04:45:54PM -0700, Andrew Morton wrote:
> Al Viro <viro@ftp.linux.org.uk> wrote:
> >
> > On Wed, May 10, 2006 at 04:05:48PM -0700, Andrew Morton wrote:
> > > Sure - it's sad and we need some workaround.
> > > 
> > > The init_self() thingy seemed reasonable to me - it shuts up the warning
> > > and has no runtime cost.  What we could perhaps do is to make
> > > 
> > > #define init_self(x) (x = x)
> > > 
> > > only if the problematic gcc versions are detected.  Later, if/when gcc gets
> > > fixed up, we use
> > 
> > Sorry, no - it shuts up too much.  Look, there are two kinds of warnings
> > here.  "May be used" and "is used".  This stuff shuts both.  And unlike
> > "may be used", "is used" has fairly high S/N ratio.
> > 
> > Moreover, once you do that, you lose all future "is used" warnings on
> > that variable.  So your ability to catch future bugs is decreased, not
> > increased.
> 
> Only for certain gcc versions.  Other people use other versions, so it'll
> be noticed.  If/when gcc gets fixed, more and more people will see the real
> warnings.
> 
> Look, of course it has problems.  But the current build has problems too. 
> It's a question of which problem is worse..

We could turn of this kind of warnings that generate these kind of false 
positives globally with -Wno-uninitialized until a future gcc version 
might be better at avoiding false positives.

But there's one problem, this turns off two kinds of warnings:
- 'foo' may be used uninitialized in this function
- 'foo' is used uninitialized in this function

The first kind of warnings is the one generating the false positives 
while the second kind are warnings we do not want to lose, but AFAIK 
there's no way to only turn off the first kind.

Perhaps asking the gcc developers for separate options for these two 
kinds of warnings in gcc 4.2 and then turning off the first kind is 
the way to go?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

