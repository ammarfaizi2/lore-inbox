Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265219AbSJaMNa>; Thu, 31 Oct 2002 07:13:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265220AbSJaMNa>; Thu, 31 Oct 2002 07:13:30 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:12255 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id <S265219AbSJaMN3>;
	Thu, 31 Oct 2002 07:13:29 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Duncan Sands <baldrick@wanadoo.fr>
Date: Thu, 31 Oct 2002 13:19:23 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Htree ate my hard drive, was: post-halloween 0.2
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net, adilger@clusterfs.com
X-mailer: Pegasus Mail v3.50
Message-ID: <62C20ED5AAC@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 31 Oct 02 at 9:20, Duncan Sands wrote:
> > I wonder if there is still a bug in the e2fsck code for re-hashing
> > directories?  It shouldn't be possible to have e2fsck complete and
> > there still be an error in the filesystem (ok, sometimes it happens,
> > but in those cases it spews a lot of warnings about the filesystem
> > not being fixed yet and to run manually).
> 
> It is possible that the filesystem was fine when fsck completed, but
> was damaged afterwards, i.e. in the time between fsck completing
> and the reboot.

Just stupid idea. Two or three months ago I complained that if
my box crashes shortly after boot, following things happen:

(1) system for some reason reads /var/run directory to page cache
(2) fsck finds that /var/run/* entries points to invalid nodes, and
    removes them (through block device access)
(4) / is remounted read-write    
(5) because of page cache for block device and directory is not
    coherent (or what...), system still sees /var/run/* populated
(6) rm /var/run/* is run. FS is remounted read-only due to
    freeing inode already freeed...
(7) Reboot, run fsck again, reboot, fine...
    
Nobody answered it at that time, and it happened at least 5 times
again to me - until I modified initscripts to do unconditional
reboot if "fsck /" did ANY modifications to filesystem.

Maybe kernel still uses old directory indexes structure after
fsck created new one?
                                            Best regards,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
