Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129883AbRBYFzh>; Sun, 25 Feb 2001 00:55:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129881AbRBYFzS>; Sun, 25 Feb 2001 00:55:18 -0500
Received: from mrelay.cc.umr.edu ([131.151.1.89]:9746 "EHLO smtp.umr.edu")
	by vger.kernel.org with ESMTP id <S129877AbRBYFzJ>;
	Sun, 25 Feb 2001 00:55:09 -0500
Date: Sat, 24 Feb 2001 23:53:42 -0600
From: David Fries <dfries@umr.edu>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Stale NFS handles on 2.4.2
Message-ID: <20010224235342.D483@d-131-151-189-65.dynamic.umr.edu>
In-Reply-To: <20010214002750.B11906@unthought.net> <20010224141855.B12988@d-131-151-189-65.dynamic.umr.edu> <15000.39826.947692.141119@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15000.39826.947692.141119@notabene.cse.unsw.edu.au>; from neilb@cse.unsw.edu.au on Sun, Feb 25, 2001 at 04:43:46PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 25, 2001 at 04:43:46PM +1100, Neil Brown wrote:
> On Saturday February 24, dfries@umr.edu wrote:
> > I have my home directory mounted on one computer from another.  I
> > rebooted the server and now the client is saying Stale NFS file handle
> > anytime something goes to read my home directory.  It has been this  
> > way for about a day.  Shouldn't any caches expire by now?
> 
> It isn't that a cache needs to expire.  It sounds like it is a cache
> that needs to be filled.
> 
> The kernel keeps a cache of ip addresses that are allowed access to
> particular filesystems.  This is visible through /proc/fs/nfs/exports.
> It is filled at reboot by "exportfs -a" or "exportfs -r" which gets
> information from /etc/exports and /var/lib/nfs/rmtab.
> 
> So check that /etc/exports contains the right info.
> Check that /var/lib/nfs/rmtab lists the filesystems and clients that
> you expect to have access, and then run "exportfs -av"

checked, verified, re-exported, still Stale NFS file handle on client.
I also used tcpdump on server and when I do ls on my home directory
(this is where I see the Stale NFS message), it does not generate any
network traffic.  It can't be the server if the client isn't asking
for it.

> > Both server and client are running 2.4.2.
> > 
> > I'ved tried `mount /home -o remount`, and reading lots of other
> > directories to flush out that entry if it was in cache without any
> > results.
> > 
> > I was hopping to avoid unmounting, as I would have to shut about
> > everything down to do that.

-- 
		+---------------------------------+
		|      David Fries                |
		|      dfries@umr.edu             |
		+---------------------------------+
