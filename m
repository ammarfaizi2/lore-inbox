Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932210AbVKEV6F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210AbVKEV6F (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 16:58:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932211AbVKEV6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 16:58:05 -0500
Received: from ppsw-9.csi.cam.ac.uk ([131.111.8.139]:32184 "EHLO
	ppsw-9.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932210AbVKEV6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 16:58:04 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Sat, 5 Nov 2005 21:58:01 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Roman Zippel <zippel@linux-m68k.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hfsplus: don't modify journaled volume
In-Reply-To: <Pine.LNX.4.61.0511052246480.12843@scrub.home>
Message-ID: <Pine.LNX.4.64.0511052155270.5813@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.61.0511031617090.12843@scrub.home>
 <20051104210213.1232a007.akpm@osdl.org> <Pine.LNX.4.64.0511051009090.13104@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.64.0511051333550.13104@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.61.0511052246480.12843@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Nov 2005, Roman Zippel wrote:
> On Sat, 5 Nov 2005, Anton Altaparmakov wrote:
> > > I would agree with that and further, is that not a bit draconian?  
> > > HFSPlus is designed to work without the journal.  Just change the last 
> > > mounted version to FSK! (0x46534b21) and everything will work as expected, 
> > > i.e. fsck will run a check instead of ignoring the volume and osx will 
> > > mount the volume and reinitialize the journal.  Remember older OSX 
> > > versions did not support journalling so if you attached your external 
> > > drive to one of those older osx boxes, you would also get non-journalled 
> > > writes to a journalled volume.  It's all designed for it...
> > 
> > And you do not need to be worried about journal reply because you 
> > already do not allow read/write mounts when the volume has not been 
> > unmounted cleanly, so there really is no reason not to allow mounting 
> > a volume with a journal...
> 
> Sorry, but I had too many reports about problems with journaled volumes, 
> so I prefer the safe solution, until we can at least replay the journal.

Yes but that would be because you leave an active journal and do changes 
behind its back without telling the OSX HFSPlus driver that you have done 
changes behind its back...  My suggestion was to tell the driver that you 
have done changes behind its back so it will be happy.

Anyway, you are the maintainer, you decide.  I was only highlighting how 
you could do it safely.

I compile my own kernels so I can always edit your patch out (I happen to 
want to write to journalled hfs+ volumes)...

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
