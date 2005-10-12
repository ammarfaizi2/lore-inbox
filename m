Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751538AbVJLUI6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751538AbVJLUI6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 16:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751537AbVJLUI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 16:08:58 -0400
Received: from ppsw-9.csi.cam.ac.uk ([131.111.8.139]:34014 "EHLO
	ppsw-9.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751533AbVJLUI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 16:08:56 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Wed, 12 Oct 2005 21:08:42 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Jeff Mahoney <jeffm@suse.com>
cc: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
       Glauber de Oliveira Costa <glommer@br.ibm.com>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, hirofumi@mail.parknet.co.jp,
       linux-ntfs-dev@lists.sourceforge.net, aia21@cantab.net,
       hch@infradead.org, viro@zeniv.linux.org.uk, akpm@osdl.org
Subject: Re: [PATCH] Use of getblk differs between locations
In-Reply-To: <434D6932.1040703@suse.com>
Message-ID: <Pine.LNX.4.64.0510122106200.9696@hermes-1.csi.cam.ac.uk>
References: <20051010204517.GA30867@br.ibm.com> 
 <Pine.LNX.4.64.0510102217200.6247@hermes-1.csi.cam.ac.uk> 
 <20051010214605.GA11427@br.ibm.com>  <Pine.LNX.4.62.0510102347220.19021@artax.karlin.mff.cuni.cz>
  <Pine.LNX.4.64.0510102319100.6247@hermes-1.csi.cam.ac.uk> 
 <Pine.LNX.4.62.0510110035110.19021@artax.karlin.mff.cuni.cz>
 <1129017155.12336.4.camel@imp.csi.cam.ac.uk> <434D6932.1040703@suse.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Oct 2005, Jeff Mahoney wrote:
> Anton Altaparmakov wrote:
> > On Tue, 2005-10-11 at 00:49 +0200, Mikulas Patocka wrote:
> >> On Mon, 10 Oct 2005, Anton Altaparmakov wrote:
> >>> On Mon, 10 Oct 2005, Mikulas Patocka wrote:
> >>>> On Mon, 10 Oct 2005, Glauber de Oliveira Costa wrote:
> >>>> As comment in buffer.c says, getblk will deadlock if the machine is out of
> >>>> memory. It is questionable whether to deadlock or return NULL and corrupt
> >>>> filesystem in this case --- deadlock is probably better.
> >>> What do you mean corrupt filesystem?  If a filesystem is written so badly
> >>> that it will cause corruption when a NULL is returned somewhere, I
> >>> certainly don't want to have anything to do with it.
> >> What should a filesystem driver do if it can't suddenly read or write any 
> >> blocks on media?
> > 
> > Two clear choices:
> > 
> > 1) Switch to read-only and use the cached data to fulfil requests and
> > fail all others.
> > 
> > 2) Ask the user to insert the media/plug the device back in (this is by
> > far the most likely cause of all requests suddenly failing) and then
> > continue where they left off.
> > 
> > It is unfortunate that Linux does not allow for 2) so you need to do 1).
> 
> I recently looked into 2) a bit and the dm multipath code is almost
> enough to do exactly this.
> 
> If you configure your block device as an mpath device that queues on
> path failure, and change the table to the new device location on device
> re-attach, the queued up i/o will be flushed out. Almost. Right now,
> when you change the table and resume the dm mapping, it does a suspend
> which attempts to write out the data to a device which is no longer
> there, causing it to just be dropped on the floor. If this were changed
> not to do that, and perhaps set a timer so that the dirty data wouldn't
> be left around forever if the device wasn't reattached, 2) would
> definitely be possible.
> 
> I realize that the userspace intervention required may involve a bit of
> dark magic, but my point is most of the code required on the kernel side
> is already implemented.

Cool.  I didn't know that.  On Linux as you say the userspace intervention 
is the real problem due to non-X vs X and gnome vs KDE vs whatnot...  But 
I would imagine a simple userspace helper a-la /sbin/modprobe and things 
like that would be enough.  And that could then be system specific to 
display a message to the local user...

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
