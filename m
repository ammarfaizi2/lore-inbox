Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263020AbVDLXNz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263020AbVDLXNz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 19:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262124AbVDLXLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 19:11:17 -0400
Received: from ppsw-6.csi.cam.ac.uk ([131.111.8.136]:34726 "EHLO
	ppsw-6.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S262978AbVDLUhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 16:37:15 -0400
Date: Tue, 12 Apr 2005 21:36:58 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Jamie Lokier <jamie@shareable.org>
cc: Miklos Szeredi <miklos@szeredi.hu>, dan@debian.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       hch@infradead.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [RFC] FUSE permission modell (Was: fuse review bits)
In-Reply-To: <20050411214123.GF32535@mail.shareable.org>
Message-ID: <Pine.LNX.4.60.0504122127160.26320@hermes-1.csi.cam.ac.uk>
References: <20050331200502.GA24589@infradead.org> <E1DJsH6-0004nv-00@dorka.pomaz.szeredi.hu>
 <20050411114728.GA13128@infradead.org> <E1DL08S-0008UH-00@dorka.pomaz.szeredi.hu>
 <20050411153619.GA25987@nevyn.them.org> <E1DL1Gj-000091-00@dorka.pomaz.szeredi.hu>
 <20050411181717.GA1129@nevyn.them.org> <E1DL4J4-0000Py-00@dorka.pomaz.szeredi.hu>
 <20050411192223.GA3707@nevyn.them.org> <E1DL51J-0000To-00@dorka.pomaz.szeredi.hu>
 <20050411214123.GF32535@mail.shareable.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Apr 2005, Jamie Lokier wrote:
> Miklos Szeredi wrote:
> > That is exactly the intended effect.  If I'm at my work machine (where
> > I'm not an admin unfortunately) and I mount my home machine with sshfs
> > (because FUSE is installed fortunately :), then I bloody well don't
> > want the sysadmin or some automated script of his to go mucking under
> > the mountpoint.
> 
> I think that would be _much_ nicer implemented as a mount which is
> invisible to other users, rather than one which causes the admin's
> scripts to spew error messages.  Is the namespace mechanism at all
> suitable for that?
> 
> It would also be nice to generalise and have virtual filesystems which
> are able to present different views to different users.  Can FUSE do
> that already - is the userspace part told which user is doing each
> operation?  With that, the desire for virtual filesystems which cannot
> be read by your sysadmin (by accident) is easy to satisfy - and that
> kind of mechanism would probably be acceptable to all.

Yes it does.  We use it to provide magic symlinks which point to different 
places for different people.  So we have for example a symlink called "ux" 
and it points to "/servers/USERNAME/our-server/ux" where USERNAME is the 
name from /etc/passwd matching the user id of the user accessing the 
symlink.  So in documentaion and in stupid programs which require 
hardcoding of path we specify "/ux" to find the shared space but in 
reality this is a different local directory for every user.  (To complete 
the picture the different local directories are actually the same remote 
directory but mounted with access permissions for each user separately 
using ncpfs.)

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
