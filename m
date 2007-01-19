Return-Path: <linux-kernel-owner+w=401wt.eu-S964830AbXASFPP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964830AbXASFPP (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 00:15:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964843AbXASFPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 00:15:15 -0500
Received: from 1wt.eu ([62.212.114.60]:1996 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964830AbXASFPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 00:15:14 -0500
Date: Fri, 19 Jan 2007 06:15:06 +0100
From: Willy Tarreau <w@1wt.eu>
To: dann frazier <dannf@debian.org>
Cc: Santiago Garcia Mantinan <manty@debian.org>, linux-kernel@vger.kernel.org,
       debian-kernel@lists.debian.org
Subject: Re: problems with latest smbfs changes on 2.4.34 and security backports
Message-ID: <20070119051506.GA17306@1wt.eu>
References: <20070117100030.GA11251@clandestino.aytolacoruna.es> <20070117215519.GX24090@1wt.eu> <20070119010040.GR16053@colo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070119010040.GR16053@colo>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dann !

On Thu, Jan 18, 2007 at 06:00:40PM -0700, dann frazier wrote:
> On Wed, Jan 17, 2007 at 10:55:19PM +0100, Willy Tarreau wrote:
> > @@ -505,8 +510,13 @@
> >  		mnt->file_mode = (oldmnt->file_mode & S_IRWXUGO) | S_IFREG;
> >  		mnt->dir_mode = (oldmnt->dir_mode & S_IRWXUGO) | S_IFDIR;
> >  
> > -		mnt->flags = (oldmnt->file_mode >> 9);
> > +		mnt->flags = (oldmnt->file_mode >> 9) | SMB_MOUNT_UID |
> > +			SMB_MOUNT_GID | SMB_MOUNT_FMODE | SMB_MOUNT_DMODE;
> >  	} else {
> > +		mnt->file_mode = mnt->dir_mode = S_IRWXU | S_IRGRP | S_IXGRP |
> > +						S_IROTH | S_IXOTH | S_IFREG;
> > +		mnt->dir_mode = mnt->dir_mode = S_IRWXU | S_IRGRP | S_IXGRP |
> > +						S_IROTH | S_IXOTH | S_IFDIR;
> >  		if (parse_options(mnt, raw_data))
> >  			goto out_bad_option;
> >  	}
> > 
> > 
> > See above ? mnt->dir_mode being assigned 3 times. It still *seems* to do the
> > expected thing like this but I wonder if the initial intent was
> > exactly this.
> 
> Wow - sorry about that, that's certainly a cut & paste error. But the
> end result appears to match current 2.6, which was the intent.

OK.

> > Also, would not it be necessary to add "|S_IFLNK" to the file_mode ? Maybe
> > what I say is stupid, but it's just a guess.
> 
> I really don't know the correct answer to that, I was merely copying
> the 2.6 flags. 

Don't waste your time on this one, it did not work.

> [Still working on getting a 2.4 smbfs test system up...]

Thanks !

Best regards,
Willy

