Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263010AbUKYHaw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263010AbUKYHaw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Nov 2004 02:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263008AbUKYHav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Nov 2004 02:30:51 -0500
Received: from rev.193.226.233.139.euroweb.hu ([193.226.233.139]:64981 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S263007AbUKYHaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Nov 2004 02:30:22 -0500
To: bulb@ucw.cz
CC: avi@argo.co.il, alan@lxorguk.ukuu.org.uk, torvalds@osdl.org,
       hbryan@us.ibm.com, akpm@osdl.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, pavel@ucw.cz
In-reply-to: <20041125062649.GB29278@vagabond> (message from Jan Hudec on Thu,
	25 Nov 2004 07:26:49 +0100)
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
References: <OF28252066.81A6726A-ON88256F50.005D917A-88256F50.005EA7D9@us.ibm.com> <E1CUq57-00043P-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.58.0411180959450.2222@ppc970.osdl.org> <1100798975.6018.26.camel@localhost.localdomain> <41A47B67.6070108@argo.co.il> <E1CWwqF-0007Ng-00@dorka.pomaz.szeredi.hu> <20041125062649.GB29278@vagabond>
Message-Id: <E1CXE4k-0000Ow-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 25 Nov 2004 08:29:58 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > There are already "strange" filesystems in the kernel which cannot
> > really get rid of dirty data.  I'm thinking of tmpfs and ramfs.
> > Neither of them are prone to deadlock, though both of them are "worse
> > off" than a userspace filesystem, in the sense that they have not even
> > the remotest chance of getting rid of the dirty data.
> > 
> > Of course, implementing this is probably not trivial.  But I don't see
> > it as a theoretical problem as Linus does. 
> > 
> > Is there something which I'm missing here?
> 
> But they KNOW that they won't be able to get rid of the dirty data. But
> fuse does not.

Why not?  I can set bdi->memory_backed to 1 just like ramfs, implement
my own writeback thread, and voila, no deadlock.

Of course I believe, that it's probably easier to tweak the page cache
to teach it that fuse pages _can_ be written back, but not reliably
like a disk filesystem.  And there's the small problem of limiting the
number of writable pages allocated to FUSE.

Miklos
