Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262815AbSKDWfn>; Mon, 4 Nov 2002 17:35:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262821AbSKDWfn>; Mon, 4 Nov 2002 17:35:43 -0500
Received: from pc-80-195-35-58-ed.blueyonder.co.uk ([80.195.35.58]:3207 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S262815AbSKDWfm>; Mon, 4 Nov 2002 17:35:42 -0500
Date: Mon, 4 Nov 2002 22:42:13 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Duncan Sands <baldrick@wanadoo.fr>, Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: Htree ate my hard drive, was: post-halloween 0.2
Message-ID: <20021104224213.F14318@redhat.com>
References: <20021030171149.GA15007@suse.de> <200210310727.52636.baldrick@wanadoo.fr> <20021031080717.GF28982@clusterfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021031080717.GF28982@clusterfs.com>; from adilger@clusterfs.com on Thu, Oct 31, 2002 at 01:07:17AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Oct 31, 2002 at 01:07:17AM -0700, Andreas Dilger wrote:
> On Oct 31, 2002  07:27 +0100, Duncan Sands wrote:

> > After a bit of switching back and forth between 2.4.19 and 2.5.44,
> > fsck was run while booting 2.4.19 (the usual check because of >30
> > mounts).  There was a message about optimizing directories.  Booting
> > continued but (big surprise) X refused to run.  It turned out that some
> > device files had vanished.

> > tune2fs -O ^dir_index /dev/hdXXX
> > to remove htree support.  No problems since then.

> I wonder if there is still a bug in the e2fsck code for re-hashing
> directories?

Possibly, but I'm more worried about why the fsck did a directory
optimise on reboot, especially on the root filesystem (where /dev is
usually stored).  Doing major fs surgery on a mounted, readonly
filesystem is sort-of safe, but only if you reboot afterwards.
Continuing and remounting read-write can cause all sorts of damage as
the cached fs data no longer matches what's on disk.

Duncan, did you have fsck set up to do a forced htree rebuild on
reboot?

Cheers,
 Stephen
