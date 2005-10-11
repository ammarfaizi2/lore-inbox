Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751413AbVJKHww@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413AbVJKHww (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 03:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbVJKHww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 03:52:52 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:34457 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751409AbVJKHwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 03:52:50 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Subject: Re: [PATCH] Use of getblk differs between locations
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: Glauber de Oliveira Costa <glommer@br.ibm.com>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, hirofumi@mail.parknet.co.jp,
       linux-ntfs-dev@lists.sourceforge.net, aia21@cantab.net,
       hch@infradead.org, viro@zeniv.linux.org.uk, akpm@osdl.org
In-Reply-To: <Pine.LNX.4.62.0510110035110.19021@artax.karlin.mff.cuni.cz>
References: <20051010204517.GA30867@br.ibm.com>
	 <Pine.LNX.4.64.0510102217200.6247@hermes-1.csi.cam.ac.uk>
	 <20051010214605.GA11427@br.ibm.com>
	 <Pine.LNX.4.62.0510102347220.19021@artax.karlin.mff.cuni.cz>
	 <Pine.LNX.4.64.0510102319100.6247@hermes-1.csi.cam.ac.uk>
	 <Pine.LNX.4.62.0510110035110.19021@artax.karlin.mff.cuni.cz>
Content-Type: text/plain
Organization: Computing Service, University of Cambridge, UK
Date: Tue, 11 Oct 2005 08:52:35 +0100
Message-Id: <1129017155.12336.4.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-10-11 at 00:49 +0200, Mikulas Patocka wrote:
> On Mon, 10 Oct 2005, Anton Altaparmakov wrote:
> > On Mon, 10 Oct 2005, Mikulas Patocka wrote:
> >> On Mon, 10 Oct 2005, Glauber de Oliveira Costa wrote:
> >> As comment in buffer.c says, getblk will deadlock if the machine is out of
> >> memory. It is questionable whether to deadlock or return NULL and corrupt
> >> filesystem in this case --- deadlock is probably better.
> >
> > What do you mean corrupt filesystem?  If a filesystem is written so badly
> > that it will cause corruption when a NULL is returned somewhere, I
> > certainly don't want to have anything to do with it.
> 
> What should a filesystem driver do if it can't suddenly read or write any 
> blocks on media?

Two clear choices:

1) Switch to read-only and use the cached data to fulfil requests and
fail all others.

2) Ask the user to insert the media/plug the device back in (this is by
far the most likely cause of all requests suddenly failing) and then
continue where they left off.

It is unfortunate that Linux does not allow for 2) so you need to do 1).

I completely disagree with people who want the system to panic() or even
BUG() in such case.  I don't want "me accidentally knocking the
flashdrive attached to my keyboard's usb ports" to panic() my system
thank you very much!  And I don't want it to go BUG() either!

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

