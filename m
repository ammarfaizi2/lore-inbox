Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263622AbTKFO0s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 09:26:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263620AbTKFO0q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 09:26:46 -0500
Received: from smtprelay01.ispgateway.de ([62.67.200.156]:61598 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S263575AbTKFO0l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 09:26:41 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: "Theodore Ts'o" <tytso@mit.edu>,
       Robert Gyazig <juliarobertz_fan@yahoo.com>
Subject: Re: undo an mke2fs !!
Date: Thu, 6 Nov 2003 15:25:41 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <20031106055601.75420.qmail@web21505.mail.yahoo.com> <20031106133442.GB23624@thunk.org>
In-Reply-To: <20031106133442.GB23624@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311061525.41914.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 06 November 2003 14:34, Theodore Ts'o wrote:
> On Wed, Nov 05, 2003 at 09:56:01PM -0800, Robert Gyazig wrote:
> > Hi Ted and others,
> >
> > I created a new partition on my disk, and without
> > noticing the change in the hdaX of the partition i did
> > an  mke2fs /dev/hdaX. :(
> >
> > Unfortunately it was my /home partition and was an
> > ext3 partition earlier. Can anyone please advice on
> > how to retrieve the old data.
> >
> > I read that mke2fs nukes all the meta information, so
> > does that mean all inodes are destroyed and there is
> > no hope for me ?!?!?
>
> Unfortunately, you're correct.  The location of which blocks were
> associated with which inodes are irretrievably lost.
>
> If you had backed up the metadata using an e2image command, you would
> have been fine, but that command takes a while to run, so most people
> don't bother to do this.  (Not a bad idea for the absolute paranoids
> in the house would be to run e2image out of a cron script and save the
> image file on some *other* filesystem.)
>
> I've thought about making mke2fs run e2image and saving the result
> somewhere else, but that takes a long time, and people would get
> annoyed if I did that.  Still, enough people have gotten screwed by
> this that I've been tempted to add this as an option.  Another
> possibility is for mke2fs to notice when the filesystem is already
> formatted using ext2/3, and then printing a warning message and
> waiting 10 seconds before continueing, so the user has a chance to
> type control-C.  This would probably be the least annoying as far as
> already existing scripts that use mke2fs, although of course there
> would be an option to turn this behaviour off.
>
> > i did a cat /dev/hdaX > /dev/hdaY, which was an empty
> > partition earlier so that I can play around a bit. I
> > tried couple of things with debugfs but coudn't go
> > much far.
>
> You can use a disk editor to find the text strings of critical files
> that you wish to rescue, and hope they were contiguously allocated,
> but that's probably the best you can do....
>
> Sorry, but that's the current Unix design philosophy, which is to
> assume that the system administrator knows what he/she is doing.  I
> never, ever type the mke2fs command without a certain amount of fear
> and trepidition, and always check and triple check before doing so.
> Still, as Linux becomes more mainstream, we do need to think about
> adding safety checks so that to avoid accidents by less careful system
> administrators.  The challenge is to figure out ways of doing so in
> the least obstrusive way as possible, to avoid annoying the existing
> population.
>
> 						- Ted
>
> P.S.  The other approach, which might also be the right one, is to use
> a front-end program --- call it newfs --- which does many more safety
> checks and which could do things like use e2image to backup the inode
> blocks before doing an mke2fs.  That way, administrators can choose
> whether they want the additional safety checks or not.
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

