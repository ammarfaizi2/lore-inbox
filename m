Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315048AbSEYRFA>; Sat, 25 May 2002 13:05:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315119AbSEYRE7>; Sat, 25 May 2002 13:04:59 -0400
Received: from hera.cwi.nl ([192.16.191.8]:26307 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S315048AbSEYRE6>;
	Sat, 25 May 2002 13:04:58 -0400
From: Andries.Brouwer@cwi.nl
Date: Sat, 25 May 2002 19:04:57 +0200 (MEST)
Message-Id: <UTC200205251704.g4PH4vS15831.aeb@smtp.cwi.nl>
To: alan@lxorguk.ukuu.org.uk
Subject: Re: isofs unhide option:  troubles with Wine
Cc: linux-kernel@vger.kernel.org, olaf.dietsche--list.linux-kernel@exmail.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> Further, I would argue that if you accept that unhide is a
>> reasonable default for me to force into the fstab, then
>> it is a reasonable default for the kernel to have.

> I'd tend to agree, simply because the defaults ought to make things
> possible rather than impossible. Question is - why was hide the default
> and what was that decision based upon ?

Inspection of the patch history shows:

1.1.63:
+                 /* Do not report hidden or associated files */

1.1.94:
+                       if (inode->i_sb->u.isofs_sb.s_unhide=='n') {
				/* Do not report hidden or associated files */
+       popt->unhide = 'n';

I do not think my linux-kernel archives contain any discussion.

As far as I can see there is no objection at all to make unhide
the default.

But note:
The test &5 tests two bits.
bit 0 is the hidden bit - see ECMA 119 - 9.1.6
bit 2 is the test for associated files.

http://developer.apple.com/technotes/fl/fl_36.html explains:

-----------------------------------------------------------------
Associated files are exactly analogous to resource forks.

An associated file is defined as having the associated bit set in
the file flags byte of the directory record. It has exactly the same
file identifier as its counterpart, and resides immediately before
its counterpart in the directory. The associated file is treated as the
resource fork, its counterpart is treated as the data fork of the file.

For example, if a file "FOO.;1" has an associated file, there will be
two adjacent directory records named "FOO.;1"; the first one (the
resource fork) will have the associated bit set, the second one
(the data fork) will have the associated bit clear.
-----------------------------------------------------------------

I think that the right default would be to show hidden files,
but not to show associated files.


Andries
