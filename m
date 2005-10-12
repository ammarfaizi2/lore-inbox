Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932455AbVJLVfe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932455AbVJLVfe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 17:35:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932456AbVJLVfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 17:35:34 -0400
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:45251 "EHLO
	ppsw-1.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932444AbVJLVfd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 17:35:33 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Wed, 12 Oct 2005 22:35:26 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
cc: Jeff Mahoney <jeffm@suse.com>,
       Glauber de Oliveira Costa <glommer@br.ibm.com>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, hirofumi@mail.parknet.co.jp,
       linux-ntfs-dev@lists.sourceforge.net, aia21@cantab.net,
       hch@infradead.org, viro@zeniv.linux.org.uk, akpm@osdl.org
Subject: Re: [PATCH] Use of getblk differs between locations
In-Reply-To: <Pine.LNX.4.62.0510122221250.13771@artax.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.64.0510122228140.9696@hermes-1.csi.cam.ac.uk>
References: <20051010204517.GA30867@br.ibm.com> 
 <Pine.LNX.4.64.0510102217200.6247@hermes-1.csi.cam.ac.uk> 
 <20051010214605.GA11427@br.ibm.com>  <Pine.LNX.4.62.0510102347220.19021@artax.karlin.mff.cuni.cz>
  <Pine.LNX.4.64.0510102319100.6247@hermes-1.csi.cam.ac.uk> 
 <Pine.LNX.4.62.0510110035110.19021@artax.karlin.mff.cuni.cz>
 <1129017155.12336.4.camel@imp.csi.cam.ac.uk> <434D6932.1040703@suse.com>
 <Pine.LNX.4.62.0510122155390.9881@artax.karlin.mff.cuni.cz> <434D6CFA.4080802@suse.com>
 <Pine.LNX.4.62.0510122208210.11573@artax.karlin.mff.cuni.cz>
 <Pine.LNX.4.64.0510122114140.9696@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.62.0510122221250.13771@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Oct 2005, Mikulas Patocka wrote:
> > > But discarding data sometimes on USB unplug is even worse than discarding
> > > data
> > > always --- users will by experimenting learn that linux doesn't discard
> > > write-cached data and reminds them to replug the device --- and one day,
> > > randomly, they lose their data because of some memory management
> > > condition...
> > 
> > And how exactly is that worse than discarding the data every time?!?!?!?
> 
> Undeterministic behaviour is worse than deterministic. You can learn the
> system that behaves deterministically.
> 
> If you know that unplug damages filesystem on your USB disk, you replug it,
> recheck filesystem and copy the important data again --- you have 0%
> probability of data damage.
> However, if damage on unplug happens only with 1/100 probability, will you
> still check filesystem and copy all recently created files on it? You forget
> it (or you wouldn't even know that damage might occur) and you have 1%
> probability of data damage.

So display a warning that data may be lost (or may already have been 
lost), just like Windows does.

Also, your probabilities are ridiculous.  You are not telling me that 
there is a 1% probability of OOM every time I unplud a usb device?!?  I 
have used Linux for almost 10 years now and I have only ever have seen 
OOMs once when I had a bad memory leak.  To me that counts under 
"practically never happens" so I don't care too much about that case.  I 
would rather see it working correctly in majority of cases.  Getting 
everything right is _impossible_.  You cannot designd a sane system with 
sane performance that cannot OOM.  And when that happens applications will 
get killed so you will loose all your data anyway.  So who cares that 
some data on the usb stick may then be lost?

And anyway you are completely wrong/unknowledgeable about usb sticks and 
what filesystems are used on them if you think that "nothing is lost" at 
present since user just knows to do an fsck!  At the moment whenever I get 
a usb stick unplugged without properly "sync, umount, sync several times", 
I usually find that the fs on it is 100% destroyed the moment I try to use 
it on one of the "other" OS...  Fsck, ha!  Total data loss everytime for 
me!  And I would much rather have it just work on replugging every time 
except in the < 0.000000000000000000000000000001% chance of OOM than 
_never_ as it is now.

Think practical, not theoretical.  Theory is all nice except that it never 
meets with practice.  Just ask Linus what he thinks of 
Specifications which are another form of Theoretically Correct entity...  
(-;

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
