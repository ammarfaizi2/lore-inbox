Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750989AbVJJXCc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbVJJXCc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 19:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750985AbVJJXCc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 19:02:32 -0400
Received: from tux06.ltc.ic.unicamp.br ([143.106.24.50]:35237 "EHLO
	tux06.ltc.ic.unicamp.br") by vger.kernel.org with ESMTP
	id S1750982AbVJJXCb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 19:02:31 -0400
Date: Mon, 10 Oct 2005 20:12:42 -0300
From: Glauber de Oliveira Costa <glommer@br.ibm.com>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, glommer@br.ibm.com,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, hirofumi@mail.parknet.co.jp,
       linux-ntfs-dev@lists.sourceforge.net, aia21@cantab.net,
       hch@infradead.org, viro@zeniv.linux.org.uk, akpm@osdl.org
Subject: Re: [PATCH] Use of getblk differs between locations
Message-ID: <20051010231242.GC11427@br.ibm.com>
References: <20051010204517.GA30867@br.ibm.com> <Pine.LNX.4.64.0510102217200.6247@hermes-1.csi.cam.ac.uk> <20051010214605.GA11427@br.ibm.com> <Pine.LNX.4.62.0510102347220.19021@artax.karlin.mff.cuni.cz> <Pine.LNX.4.64.0510102319100.6247@hermes-1.csi.cam.ac.uk> <Pine.LNX.4.62.0510110035110.19021@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0510110035110.19021@artax.karlin.mff.cuni.cz>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> What should a filesystem driver do if it can't suddenly read or write any 
> blocks on media?

Maybe stopping gracefully, warn about what happened, and let the system
keep going. You may be right about your main filesystem, but in the case
I'm running, for example, my system in an ext3 filesystem, and have a
vfat from a usb key. Should my system really hang because I'm not able
to read/write to the device?

> >Going BUG() is generally a bad thing if the error can be recovered from.
> >Certainly all my code attempts to recover from all error conditions it can
> >possibly encounter.
> >
> >I would much rather see NULL and then handle the error gracefully with an
> >error message than go BUG().  You can then still umount and remove the fs
> >module and everything works fine (you may need an fsck you may not depends
> >on how good your error handling is).  If you do a BUG() you are guaranteed
> >to cause corruption...
> >
> >I only use BUG() when something really cannot happen unless there is a 
> >bug in which case I want to know it...
> 
> Of course, this "can't happen unless there is a bug" is exactly the case 
> of __getblk_slow().
> 
> Mikulas
> 
> >Best regards,
> >
> >	Anton
> >-- 
> >Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
> >Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
> >Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
> >WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
> >
> 

-- 
=====================================
Glauber de Oliveira Costa
IBM Linux Technology Center - Brazil
glommer@br.ibm.com
=====================================
