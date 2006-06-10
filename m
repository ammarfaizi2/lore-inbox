Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030572AbWFJArr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030572AbWFJArr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 20:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030575AbWFJArr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 20:47:47 -0400
Received: from thunk.org ([69.25.196.29]:48289 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1030572AbWFJArp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 20:47:45 -0400
Date: Fri, 9 Jun 2006 20:47:27 -0400
From: Theodore Tso <tytso@mit.edu>
To: Jeff Garzik <jeff@garzik.org>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Matthew Frost <artusemrys@sbcglobal.net>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Mingming Cao <cmm@us.ibm.com>,
       linux-fsdevel@vger.kernel.org, Alex Tomas <alex@clusterfs.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
Message-ID: <20060610004727.GC7749@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Jeff Garzik <jeff@garzik.org>,
	"Stephen C. Tweedie" <sct@redhat.com>,
	Andrew Morton <akpm@osdl.org>,
	Matthew Frost <artusemrys@sbcglobal.net>,
	"ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, Mingming Cao <cmm@us.ibm.com>,
	linux-fsdevel@vger.kernel.org, Alex Tomas <alex@clusterfs.com>
References: <m3ac8mcnye.fsf@bzzz.home.net> <4489B83E.9090104@sbcglobal.net> <20060609181426.GC5964@schatzie.adilger.int> <4489C34B.1080806@garzik.org> <20060609194959.GC10524@thunk.org> <4489D44A.1080700@garzik.org> <1149886670.5776.111.camel@sisko.sctweedie.blueyonder.co.uk> <4489ECDD.9060307@garzik.org> <1149890138.5776.114.camel@sisko.sctweedie.blueyonder.co.uk> <448A07EC.6000409@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <448A07EC.6000409@garzik.org>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2006 at 07:44:44PM -0400, Jeff Garzik wrote:
> Yes.  Re-read what I wrote.  To put it another way, "mkfs S1 + resize to 
> S2" does not produce precisely the same layout as "mkfs S2".

Different in the same way that "mke2fs -E stride=5" results a slightly
different location of where the block bitmaps, inode bitmaps, and
inode table might be, yes --- but SO WHAT?  

There's a *reason* that the block group descriptors tell the kernel
where to find the block/inode bitmaps and the inode table.  They can
change due to bad blocks in the filesystem, or requests to subtly
change the layout to optimize various RAID layouts, for example.  And
exactly how the block/inode bitmaps would get laid out in response to
-E stride have also changed over time, depending on which version of
e2fsprogs, but ---- News flash!! --- it doesn't matter!!!

Jeff, you seem to think that the fact that the layout isn't precisely
the same after an on-line resizing is proof of something horrible, but
it isn't.  The exact location of filesystem metadata has never been
fixed, not in the past ten years of ext2/3 history, and this is not a
big deal.  It certainly isn't "proof" of on-line resizing being
something horrible, as you keep trying to claim, without any arguments
other than, "The layout is different!".  

Oh my, hide the women and children...

							- Ted
