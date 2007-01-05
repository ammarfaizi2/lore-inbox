Return-Path: <linux-kernel-owner+w=401wt.eu-S1161089AbXAENMs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161089AbXAENMs (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 08:12:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161083AbXAENMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 08:12:47 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:1465 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S965152AbXAENMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 08:12:46 -0500
Date: Fri, 5 Jan 2007 13:12:35 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: matthew@wil.cx, bhalevy@panasas.com, arjan@infradead.org,
       mikulas@artax.karlin.mff.cuni.cz, jaharkes@cs.cmu.edu,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       nfsv4@ietf.org
Subject: Re: Finding hardlinks
Message-ID: <20070105131235.GB4662@ucw.cz>
References: <4593E1B7.6080408@panasas.com> <E1H01Og-0007TF-00@dorka.pomaz.szeredi.hu> <20070102191504.GA5276@ucw.cz> <E1H1qRa-0001t7-00@dorka.pomaz.szeredi.hu> <20070103115632.GA3062@elf.ucw.cz> <E1H25JD-0003SN-00@dorka.pomaz.szeredi.hu> <20070103135455.GA24620@parisc-linux.org> <E1H28Oi-0003kw-00@dorka.pomaz.szeredi.hu> <20070104225929.GC8243@elf.ucw.cz> <E1H2kfa-0007Jl-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1H2kfa-0007Jl-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > Some of us have machines designed to cope with cosmic rays, and would be
> > > > unimpressed with a decrease in reliability.
> > > 
> > > With the suggested samefile() interface you'd get a failure with just
> > > about 100% reliability for any application which needs to compare a
> > > more than a few files.  The fact is open files are _very_ expensive,
> > > no wonder they are limited in various ways.
> > > 
> > > What should 'tar' do when it runs out of open files, while searching
> > > for hardlinks?  Should it just give up?  Then the samefile() interface
> > > would be _less_ reliable than the st_ino one by a significant margin.
> > 
> > You need at most two simultenaously open files for examining any
> > number of hardlinks. So yes, you can make it reliable.
> 
> Well, sort of.  Samefile without keeping fds open doesn't have any
> protection against the tree changing underneath between first
> registering a file and later opening it.  The inode number is more

You only need to keep one-file-per-hardlink-group open during final
verification, checking that inode hashing produced reasonable results.

							Pavel
-- 
Thanks for all the (sleeping) penguins.
