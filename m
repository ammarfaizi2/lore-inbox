Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261881AbRFGQbg>; Thu, 7 Jun 2001 12:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261950AbRFGQb0>; Thu, 7 Jun 2001 12:31:26 -0400
Received: from firewall.spacetec.no ([192.51.5.5]:1497 "EHLO
	pallas.spacetec.no") by vger.kernel.org with ESMTP
	id <S261881AbRFGQbL>; Thu, 7 Jun 2001 12:31:11 -0400
Date: Thu, 7 Jun 2001 18:31:07 +0200
Message-Id: <200106071631.SAA07241@pallas.spacetec.no>
Mime-Version: 1.0
In-Reply-To: <fa.kdp2rnv.1bma03f@ifi.uio.no>
In-Reply-To: <fa.kdp2rnv.1bma03f@ifi.uio.no>
From: tor@spacetec.no (Tor Arntsen)
Subject: Re: NULL characters in file on ReiserFS again.
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2001 at 09:57:51AM -0700, Hans Reiser wrote:
>Andrej Borsenkow wrote:
> > /etc/hosts (or anywhere). As a tesult, startx hung starting X server; it was
> > not possible to switch to alpha console or kill X server. I pressed reset
> > and after reboot looked into /var/log/XFree86*log - and there were a bunch
> > of ^@ there.

> this is the nature of metadata journaling filesystems.

Exactly the same thing happens on XFS filesystems on IRIX 6.5.
We had a bunch of Origin systems that crashed every so often because
of some PCI bus problems, and every time this happened every file
on the system that had been updated the last seconds before the
crash would be full of, or almost full of ^@.  Needless to say
this created havoc with CVS repositories and also checked-out
trees, since the CVS/Entries files would end up modified.

I first noticed this when my setiathome status files were empty
after the restarts.. *every* time.  I had to install a cron job 
that copied the status file every two minutes or so, the slightly
older copy would be okay so I could just copy it back after the
restart.

That was a nuisance, but when the CVS systems got wrecked it became
a little worse.  Obviously we have backups, but the problem was that
you wouldn't necessarily notice right away that anything was screwed.

Hopefully SGI will fix it, or maybe they have fixed it already -- 
I don't know.  I'm running 6.5.8 which isn't the latest (IRIX is
at 6.5.11 or 6.5.12 now I think), and it certainly wasn't fixed there.
If not, then XFS will never run on my Linux boxes, and certainly
not on the big Linux server that now holds our CVS repositories
instead of the SGI Origin system that we originally used :-)

In another posting Stephen Tweedie writes:
>Umm, no, it isn't.  Ext3 would never allow that to happen in ordered
>metadata-journaling mode, and Chris Mason is already working to remove
>that window in reiserfs.  It is by no means a necessary consequence of
>doing metadata-only journaling.

That's good news.

-Tor
