Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262198AbTJNGtl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 02:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262201AbTJNGtl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 02:49:41 -0400
Received: from users.linvision.com ([62.58.92.114]:48020 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S262198AbTJNGt2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 02:49:28 -0400
Date: Tue, 14 Oct 2003 08:49:25 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Norman Diamond <ndiamond@wta.att.ne.jp>
Cc: John Bradford <john@grabjohn.com>, linux-kernel@vger.kernel.org
Subject: Re: Why are bad disk sectors numbered strangely, and what happens to them?
Message-ID: <20031014064925.GA12342@bitwizard.nl>
References: <32a101c3916c$e282e330$5cee4ca5@DIAMONDLX60> <200310131014.h9DAEwY3000241@81-2-122-30.bradfords.org.uk> <33a201c39174$2b936660$5cee4ca5@DIAMONDLX60>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33a201c39174$2b936660$5cee4ca5@DIAMONDLX60>
User-Agent: Mutt/1.3.28i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 13, 2003 at 07:24:00PM +0900, Norman Diamond wrote:
> John Bradford replied to me:
> 
> > > How can I tell Linux to read every sector in the partition?  Oh, I might
> > > know this one,
> > >   dd if=/dev/hda8 of=/dev/null
> > > I want to make sure that the drive is now using a non-defective
> > > replacement sector.
> >
> > A read won't necessarily do that.  You might have to write to a
> > defective sector to force re-allocation.
> 
> I agree, we are not sure if a read will do that.  That is the reason why two
> of my preceding questions were:

I've seen a disk (which now failed and will be replaced 3 hours from now)
remap defective sectors without reporting any errors to the OS. 
The SMART "remapped sector count" just went up, but no errors in the
logs. So apparently, the disk noticed something and remapped teh sector
without anybody noticing. 

>    How can I find out which file contains the bad sector?  I would like to
>    try to recreate the file from a source of good data.

Try: 
	tar cf - / | dd of=/dev/null

(note some people will try to abbreviate that to 
	tar cf /dev/null / 
but that won't work: Tar will recognise that it's writing to /dev/null
and skip reading the files! That's a bug in tar in my book. )

>    How can I tell Linux to mark the sector as bad, knowing the LBA sector
>    number?

man tune2fs .

You have to do the math on the LBA sector numbers (subtract the
partition start, divide by two). 

Also, you can use the "badblocks" program. 

			Roger. 
-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
**** "Linux is like a wigwam -  no windows, no gates, apache inside!" ****
