Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261185AbUKAEgx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261185AbUKAEgx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 23:36:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261223AbUKAEgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 23:36:52 -0500
Received: from koto.vergenet.net ([210.128.90.7]:34500 "HELO koto.vergenet.net")
	by vger.kernel.org with SMTP id S261185AbUKAEgu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 23:36:50 -0500
Date: Mon, 1 Nov 2004 13:35:59 +0900
From: Horms <horms@verge.net.au>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Siep Kroonenberg <siepo@cybercomm.nl>, 278068@bugs.debian.org
Subject: chmod messes up permissions on hfs filesystem
Message-ID: <20041101043559.GA12500@verge.net.au>
In-Reply-To: 200410241621.i9OGLiS1003875@dep.oprit.rug.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Cluestick: seven
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 24, 2004 at 05:21:44PM +0200, Siep Kroonenberg wrote:
> Package: kernel-image-2.6.8-powerpc Version: 2.6.8-6 Severity: normal
> 
> 
> chmod commands on files on hfs partitions tend to give weird results,
> e.g.:
> 
> original: -rw-r--r-- after chmod g+w: -----w--w- after chmod g-w:
> ---------- after unmounting and remounting the partition: -r--r--r--
> 
> I assume this is kernel-related, since with a 2.4 kernel, chmod
> commands mostly got ignored on this hfs partition. Anyhow, the
> maintainer of coreutils doesn't consider this a problem with chmod.

That is very strange indeed. I have sent this on to LKML so see if he has
any ideas.

>From reading hfs_inode_setattr() in fs/hfs/inode.c I observe that, it
only honours changes for the write flag, and it changes the global,
group and user flag simultaneously. I guess HFS only has one permission
flag, write, which can be on or off. The relevant code in the hfs tree
doesn't seem to have changed for many moons, so either it has always
been broken in 2.6 or something strange has happened elsewhere. 

In any case the behaviuor describe above is weird and should work
more along the lines of. 

-rw-r--r--
after chmod g+w:
-rw-rw-rw-
after chmod g-w:
-r--r--r--
after unmounting and remounting the partition:
-r--r--r--


-- 
Horms
