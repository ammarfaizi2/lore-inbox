Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272559AbRIXVch>; Mon, 24 Sep 2001 17:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272582AbRIXVc2>; Mon, 24 Sep 2001 17:32:28 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:30191 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S272559AbRIXVcT>; Mon, 24 Sep 2001 17:32:19 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Mon, 24 Sep 2001 15:32:16 -0600
To: Ryan Mack <rmack@mackman.net>
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] [BUG?] ext3 0.9.10-2410 - root partition never marked dirty
Message-ID: <20010924153216.H14526@turbolinux.com>
Mail-Followup-To: Ryan Mack <rmack@mackman.net>,
	linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.33.0109241409490.990-100000@mackman.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0109241409490.990-100000@mackman.net>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 24, 2001  14:15 -0700, Ryan Mack wrote:
> It seems that the aforementioned changes in 2.4.10 has prevented the root
> filesystem from having its superblock updated as dirty.  It may be my
> imagination, but since the root fs is already mounted ro when it's
> remounted rw, the superblock isn't being updated with the needs_recovery
> flag.

OK, it's not exactly clear what you are referring to, but:
1) On ext3 the superblock is NEVER marked dirty, because of the journal.
   As long as the journal is running normally, the filesystem will always
   be "clean".
2) There should _not_ be a problem with the needs_recovery flag being set
   from within the kernel.  HOWEVER, attempts to read it from user-space
   may fail because of a disconnect between the buffer cache and the page
   cache.

Now that these issues are in the open (and already being discussed) they
will likely be fixed in a relatively short timeframe.

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

