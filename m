Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129413AbRBYQlq>; Sun, 25 Feb 2001 11:41:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129415AbRBYQlh>; Sun, 25 Feb 2001 11:41:37 -0500
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:46598 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S129413AbRBYQl2>; Sun, 25 Feb 2001 11:41:28 -0500
Date: Sun, 25 Feb 2001 17:37:52 +0100
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: mason@suse.com
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: reiserfs: still problems with tail conversion
Message-ID: <20010225173752.A866@arthur.ubicom.tudelft.nl>
In-Reply-To: <20010223221856.A24959@arthur.ubicom.tudelft.nl> <730960000.982966246@tiny> <20010223231949.D24959@arthur.ubicom.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010223231949.D24959@arthur.ubicom.tudelft.nl>; from J.A.K.Mouw@ITS.TUDelft.NL on Fri, Feb 23, 2001 at 11:19:49PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2001 at 11:19:49PM +0100, Erik Mouw wrote:
> On Fri, Feb 23, 2001 at 05:10:46PM -0500, Chris Mason wrote:
> > Many thanks for sending along a test program for reproducing.  But, it
> > doesn't seem to reproduce the problem here, how many times did you have to
> > run it to see the null bytes?  Do you remove the files between runs?
> 
> I got them immediately at the first run, which more or less was what I
> expected because reiserfs ate one of my mailfolders that way (only a
> CVS log folder, so nothing special was lost). You have to remove the
> files between runs, otherwise the same blocks seem to be allocated to
> the files.
> 
> I'll upgrade to linux-2.4.2 to see if it solves the problem. (was
> running 2.4.2-pre4 + your patch)

I upgraded to 2.4.2, and initially I couldn't reproduce the problem.
Besides the kernel version difference, another difference was the fact
that I did the 2.4.2. test on a freshly booted system, while the
2.4.2-pre4 test was done on a system with quite some VM pressure:
uptime a couple of days, running acroread, netscape, xemacs, couple of
gnome-terminals with large scroll back buffers (10000 lines).

John Adams told me that the data didn't hit the disk on his system and
that he had to add O_SYNC to the open()s. After I did that, I could
reproduce the problem on linux-2.4.2, with the strange results that the
bug is in *every* file with initial size >=1024 bytes.

John also told that his machine doesn't have swap, but I fail to see
why that could influence the reiserfs subsystem. Anyway, the bug seems
to appear when the data hits the disk, either by high VM pressure, or
by using O_SYNC.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
