Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132729AbRDORLf>; Sun, 15 Apr 2001 13:11:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132728AbRDORL0>; Sun, 15 Apr 2001 13:11:26 -0400
Received: from virgo.cus.cam.ac.uk ([131.111.8.20]:32493 "EHLO
	virgo.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S132729AbRDORLP>; Sun, 15 Apr 2001 13:11:15 -0400
Date: Sun, 15 Apr 2001 18:11:08 +0100 (BST)
From: Anton Altaparmakov <aia21@cus.cam.ac.uk>
Reply-To: Anton Altaparmakov <aia21@cus.cam.ac.uk>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <Linus.Torvalds@Helsinki.FI>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NTFS comment expanded, small fix.
Message-ID: <Pine.SOL.3.96.1010415173424.19123A-100000@libra.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, Alan,

Please do not apply this patch as both the comment and the code are wrong
and unnecessary, respectively.

Can the numerous ntfs fixes in the -ac series be applied to the mainstream
kernel instead? Thanks.

Rogier and everyone doing any NTFS work, please use -ac series kernels as
ntfs has had major updates which are now proven to be a Good Thing
(TM)... - I get bug reports for mainstream kernel ntfs several times a
month while I haven't received a single one for the -ac series (perhaps
due to smaller userbase admittedly, but all bugs reported are fixed in the
-ac patches).

Also, if you need info about ntfs read the ntfs docs at:
	http://linux-ntfs.sourceforge.net/ntfs

For example the fixups are explained at:
	http://linux-ntfs.sourceforge.net/ntfs/concepts/fixup.html

And if the docs don't suffice (they are work in progress), look at the
linux-ntfs project source code.  Especially at the doc directory and the
include directory (and sometimes the libntfs directory). Either the header
files or the library files contain extensive documentation about the
meaning of each and every field in the ntfs structures. For example, the
fixup mechanism is described in: 
	linux-ntfs/include/layout.h, lines 84 to 110.
You can find the most current code in CVS on sourceforge. The project page
is:
	http://sourceforge.net/projects/linux-ntfs/

You can browse the cvs cvs on the web or download the lot. (don't use the
now out of date packaged linux-ntfs-0.0.1 distribution as it is out of
date...)

At 13:53 15/04/2001, Rogier Wolff wrote:
>I am studying an NTFS problem, and came across the NTFS fixup mechanism. 

Care to elaborate? - We could save you some time perhaps...

>It took me much too long to understand the fixup mechanism, even though
a comment tried to explain it. So I rewrote the comment. 

If you read what I referenced above you will want to revise your own
comment....

>Also, the "start" value that is read from the record, could be much 
larger than expected, which could lead to accessing random data. The
fixup should fail then, and this is also patched below.

No it can't (in theory). The volume would be corrupt if it was. That kind
of check belongs in ntfs fsck utility but not in kernel code.

In any case, the correct check, if you want one, would be:

if (start + (count * 2) > size)
	return 0;

And it has to happen before the:

count--;

Hope this helps,

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS maintainer / WWW: http://sourceforge.net/projects/linux-ntfs/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

