Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313421AbSEYEbo>; Sat, 25 May 2002 00:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313492AbSEYEbo>; Sat, 25 May 2002 00:31:44 -0400
Received: from jwhite-home.codeweavers.com ([209.240.253.22]:23664 "EHLO
	jwhiteh.whitesen.org") by vger.kernel.org with ESMTP
	id <S313421AbSEYEbm>; Sat, 25 May 2002 00:31:42 -0400
Subject: isofs unhide option:  troubles with Wine
From: Jeremy White <jwhite@codeweavers.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 24 May 2002 23:30:29 -0500
Message-Id: <1022301029.2443.28.camel@jwhiteh>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

When installing Microsoft Office with Wine, we find that some
MS CDs have certain files marked as hidden on the CD.

With the default isofs mount options, these files are
completely inaccessible.  (Relevant code is in 
fs/isofs/namei.c, and dir.c; search for unhide).

You're forced to remount the CD with the -unhide option
to make these files visible.

Now, forgive me if I've overlooked TFM, but I did not
find any discussion of the unhide option in the archives
I could search.

Further, imho, the unhide code is incorrectly implemented
in Linux.

The use of the 'hide' bit in Windows has no good parallel in
Linux.  The current implementation treats a hidden file
as if it didn't exist at all, there is no possible way 
a user space program can see that file.  In Windows, the
file just is hidden from 'normal' programs, you can still
get to the file if you work hard enough.

Further, I hypothesize (perhaps wrongly) that the only use
of this hidden bit is on Windows CDs, and largely on MS
Office CDs, and so I think it is reasonable for me to
call for a change.  (Understand, I'm trying to help
very basic users to use MS Office; for them to have to
su to root, umount, and then mount -o unhide, is a pretty tough thing
to ask.  See the following article to see why I'm so upset about this:
    http://biz.yahoo.com/fo/020523/linux_gets_friendlier_1.html)

Unfortunately, I don't have a strong feeling for what the
'right' solution is.  I see several options:

    1.  Invert the logic of the option, make it 'hide' instead
        of unhide, and so unhide is the default.

    2.  Make it possible to set this mount option from user
        space (I don't like this, but it would get me around
        the problem).

    3.  Make it so that isofs/dir.c still strips out hidden
        files, but enable isofs/namei.c to return a hidden file that
        is opened directly by name.

I am willing to submit a patch to implement the appropriate solution.

Comments and opinions are greatly appreciated; please copy me directly
though, as I am not subscribed.

Thanks,

Jeremy

