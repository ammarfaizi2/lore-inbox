Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317484AbSFRQld>; Tue, 18 Jun 2002 12:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317485AbSFRQlc>; Tue, 18 Jun 2002 12:41:32 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:57847 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S317484AbSFRQlb>; Tue, 18 Jun 2002 12:41:31 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Tue, 18 Jun 2002 10:39:47 -0600
To: Austin Gonyou <austin@digitalroadkill.net>
Cc: DervishD <raul@pleyades.net>, Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Shrinking ext3 directories
Message-ID: <20020618163947.GO22427@clusterfs.com>
Mail-Followup-To: Austin Gonyou <austin@digitalroadkill.net>,
	DervishD <raul@pleyades.net>,
	Linux-kernel <linux-kernel@vger.kernel.org>
References: <3D0F5AFC.mailGSE111D9L@viadomus.com> <1024416626.7681.39.camel@UberGeek>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1024416626.7681.39.camel@UberGeek>
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 18, 2002  11:10 -0500, Austin Gonyou wrote:
> Use a volume manager?(LVM or EVMS maybe.) You can grow and shrink their
> volumes dynamically. EXT3 mus support ioctls for this, but if it does,
> cause I've seen it doesn with EXT2, then you're good.

Totally irrelevant.

> On Tue, 2002-06-18 at 11:08, DervishD wrote:
> >     Hi all :))
> > 
> >     All of you know that if you create a lot of files or directories
> > within a directory on ext2/3 and after that you remove them, the
> > blocks aren't freed (this is the reason behind the lost+found block
> > preallocation). If you want to 'shrink' the directory now that it
> > doesn't contain a lot of leafs, the only solution I know is creating
> > a new directory, move the remaining leafs to it, remove the
> > 'big-unshrinken' directory and after that renaming the new directory:
> > 
> >     $ mkdir new-dir
> >     $ mv bigone/* new-dir/
> >     $ rmdir bigone
> >     $ mv new-dir bigone
> >     (Well, sort of)
> > 
> >     Any other way of doing the same without the mess?

Not right now.  Truncating directories on a mounted filesystem is
probably going to be a big source of strange problems.  In the end
it isn't really a problem for most people, because if your directory
has grown big once it is likely to grow big again.

With htree directories we will have to make this work at some point,
because you will be able to create huge directories and not being able
to free directory blocks would be a big pain.  It isn't in the current
htree directory code yet, but it has been discussed a bit already.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

