Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311919AbSD2NBg>; Mon, 29 Apr 2002 09:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315155AbSD2NBf>; Mon, 29 Apr 2002 09:01:35 -0400
Received: from imladris.infradead.org ([194.205.184.45]:39940 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S311919AbSD2NBe>; Mon, 29 Apr 2002 09:01:34 -0400
Date: Mon, 29 Apr 2002 14:01:21 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Anton Altaparmakov <aia21@cantab.net>
Cc: Nikita Danilov <Nikita@Namesys.COM>, Jan Harkes <jaharkes@cs.cmu.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: [prepatch] address_space-based writeback
Message-ID: <20020429140121.A3890@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Anton Altaparmakov <aia21@cantab.net>,
	Nikita Danilov <Nikita@Namesys.COM>,
	Jan Harkes <jaharkes@cs.cmu.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <5.1.0.14.2.20020429115231.00b1d900@pop.cus.cam.ac.uk> <5.1.0.14.2.20020427191820.04003500@pop.cus.cam.ac.uk> <5.1.0.14.2.20020412080524.00ac6220@pop.cus.cam.ac.uk> <3CB4203D.C3BE7298@zip.com.au> <20020410221211.GA6076@ravel.coda.cs.cmu.edu> <5.1.0.14.2.20020410235415.03d41d00@pop.cus.cam.ac.uk> <5.1.0.14.2.20020412015633.01f1f3c0@pop.cus.cam.ac.uk> <5.1.0.14.2.20020429115231.00b1d900@pop.cus.cam.ac.uk> <15565.13742.140693.146727@laputa.namesys.com> <5.1.0.14.2.20020429131258.04913ab0@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2002 at 01:34:02PM +0100, Anton Altaparmakov wrote:
> Basically one could just change iget4 into two functions: iget calling 
> fs->read_inode (with read_inode2 removed) and iget4 without the 
> ->read_inode and ->read_inode2 and returning a locked inode instead.
> 
> That would make it fs specific.
> 
> If we wanted to make it generic we do need a special method in the 
> operations, but wait, we already have read_inode2! So perhaps it isn't as 
> much of a hack after all...
> 
> If you wanted to get rid of the hackish nature of the beast, one could just 
> remove ->read_inode and rename ->read_inode2 to ->read_inode. Then change 
> all fs to accept two dummy parameters in their ->read_inode declaration...
> 
> If that would be an acceptable approach I would be happy to do a patch to 
> convert all in kernel file systems in 2.5.x.

Please take a look at icreate & surrounding code in the 2.5 XFS tree.
The code needs some cleanup, but I think the API is exactly what we want.

	Christoph

