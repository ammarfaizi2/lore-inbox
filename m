Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288432AbSAYWlr>; Fri, 25 Jan 2002 17:41:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288579AbSAYWlh>; Fri, 25 Jan 2002 17:41:37 -0500
Received: from [24.64.71.161] ([24.64.71.161]:61686 "EHLO lynx.adilger.int")
	by vger.kernel.org with ESMTP id <S288432AbSAYWlY>;
	Fri, 25 Jan 2002 17:41:24 -0500
Date: Fri, 25 Jan 2002 15:41:00 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Andi Kleen <ak@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        John Levon <movement@marcelothewonderpenguin.com>,
        linux-kernel@vger.kernel.org, davej@suse.de
Subject: Re: [PATCH] Fix 2.5.3pre reiserfs BUG() at boot time
Message-ID: <20020125154100.W763@lynx.adilger.int>
Mail-Followup-To: Andi Kleen <ak@suse.de>,
	Linus Torvalds <torvalds@transmeta.com>,
	John Levon <movement@marcelothewonderpenguin.com>,
	linux-kernel@vger.kernel.org, davej@suse.de
In-Reply-To: <20020125180149.GB45738@compsoc.man.ac.uk> <Pine.LNX.4.33.0201251006220.1632-100000@penguin.transmeta.com> <20020125204911.A17190@wotan.suse.de> <20020125133814.U763@lynx.adilger.int> <20020125231555.A22583@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020125231555.A22583@wotan.suse.de>; from ak@suse.de on Fri, Jan 25, 2002 at 11:15:55PM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 25, 2002  23:15 +0100, Andi Kleen wrote:
> On Fri, Jan 25, 2002 at 01:38:14PM -0700, Andreas Dilger wrote:
> > When calling kmem_cache_destroy() on a non-empty slab we should just
> > malloc some memory with the old cache name + "_leaked" for the name
> > pointer.  At least then we have a sane chance of figuring out what caused
> > the problem, instead of having a bunch of "broken" entries in the table,
> > and remove the above "broken" check entirely (we will always have a name).
> 
> I don't like this because it complicates the code too much. 
> "broken" should be enough to debug it. 

Hmm, then you could just point to a static "broken" name at
kmem_cache_destroy() time and save yourself the get_user() checks
for each access to the name.  This would gratuitously overwrite
the name for non-modular caches that failed to unload, but I doubt
that such things exist.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

