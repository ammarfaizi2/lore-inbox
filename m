Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131979AbRARF3G>; Thu, 18 Jan 2001 00:29:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132048AbRARF25>; Thu, 18 Jan 2001 00:28:57 -0500
Received: from snark.tuxedo.org ([207.106.50.26]:31238 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S132035AbRARF2w>;
	Thu, 18 Jan 2001 00:28:52 -0500
Date: Thu, 18 Jan 2001 00:28:12 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Documenting stat(2)
Message-ID: <20010118002812.A19810@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to pin down and document the behavior of the size field in
stat(2) on Linux and under various stat emulations on Windows and the
Mac.  What I find out will be documented where it will do some good (in
particular I'll send a stat.2 man page patch to Andries Brouwer).

Here is what I think I know about stat(2) that isn't in the
Linux man pages:

* For a plain file or directory (S_IFREG or S_IFDIR), the st_size
field reports the size of the file in bytes.

* For a symlink (S_IFLNK) it reports the size of the link file, not the
size of the file the link points to. 

* For a socket or FIFO (S_IFSOCK, S_IFIFO) it reports the count of bytes
waiting to be read. 

* For a block special device (S_IFBLK) it returns 0.

I don't know what it should be expected to return for terminal or
other special devices.  My guess is number of characters waiting
in clists.

Can anyone verify, correct, or expand on the above?  Reply to 
esr@thyrsus.com, please, and thanks in advance.

(Among other things, this may turn into a substantial improvement
in the documented capabilities of Perl and Python.)
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

The spirit of resistance to government is so valuable on certain
occasions, that I wish it always to be kept alive.  It will often be
exercised when wrong, but better so than not to be exercised at all.
I like a little rebellion now and then.  It is like a storm in the
Atmosphere.
	-- Thomas Jefferson, letter to Abigail Adams, 1787
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
