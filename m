Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288127AbSBABtl>; Thu, 31 Jan 2002 20:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291487AbSBABtb>; Thu, 31 Jan 2002 20:49:31 -0500
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:57327 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S288127AbSBABtR>; Thu, 31 Jan 2002 20:49:17 -0500
Message-Id: <5.1.0.14.2.20020201013842.04e9be40@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 01 Feb 2002 01:49:14 +0000
To: Eli Carter <eli.carter@inet.com>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: vfs.txt and i_ino
Cc: Anton Altaparmakov <aia21@cus.cam.ac.uk>,
        Richard Gooch <rgooch@atnf.csiro.au>, linux-kernel@vger.kernel.org
In-Reply-To: <3C59B487.64B7631A@inet.com>
In-Reply-To: <Pine.SOL.3.96.1020131205057.15330A-100000@virgo.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 21:17 31/01/02, Eli Carter wrote:
>Anton Altaparmakov wrote:
> >
> > On Thu, 31 Jan 2002, Eli Carter wrote:
> > > It appears that struct inode i_ino has a special value of 0.  I don't
> > > see a mention of that in vfs.txt, and I haven't found anything obvious
> > > in the fs code... Would it be possible to add some documentation of
> > > that, along with an explaination of what i_ino==0 is supposed to
> > > indicate?  (Bad/invalid inode?)
> >
> > i_ino = 0 is perfectly valid and is in fact one of the system files in
> > NTFS. And accessing inode 0 from user space works fine, too. The only
> > thing which is odd is that a simple "ls" (or "ls -l") doesn't show the
> > file with i_ino=0, while an explicit ls a-la "ls \$MFT" (or "ls -l \$MFT")
> > does show the file. I believe this to be purely a userspace problem but
> > when I looked at the /bin/ls source I got scared and ran away... A short
> > investigation into /bin/ls source didn't make anything obvious appear but
> > I do think it is /bin/ls at fault and not the kernel...
> >
> > So I guess my point is that i_ino=0 is not special as far as the kernel is
> > concerned.
>
>Hmm... 'ls -al' doesn't show the file for me.  I was using i_ino=0 for
>the root inode, and found that 'ls -al' did not display '.' or '..'.  It
>very well may be a user-space error... do you know who I should ask
>about it?

<bug-fileutils@gnu.org> might be a good start...

Or one of the people who wrote it? To quote from the top of ls.c:
----snip----
/* Written by Richard Stallman and David MacKenzie.  */

/* Color support by Peter Anvin <Peter.Anvin@linux.org> and Dennis
    Flaherty <dennisf@denix.elk.miles.com> based on original patches by
    Greg Lee <lee@uhunix.uhcc.hawaii.edu>.  */
----snip----

Anton


>TIA,
>
>Eli
>--------------------.     Real Users find the one combination of bizarre
>Eli Carter           \ input values that shuts down the system for days.
>eli.carter(a)inet.com `-------------------------------------------------
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

