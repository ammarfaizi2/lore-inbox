Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267875AbRGZMb5>; Thu, 26 Jul 2001 08:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267890AbRGZMbs>; Thu, 26 Jul 2001 08:31:48 -0400
Received: from weta.f00f.org ([203.167.249.89]:41605 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S267875AbRGZMbj>;
	Thu, 26 Jul 2001 08:31:39 -0400
Date: Fri, 27 Jul 2001 00:32:08 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Andrew Morton <akpm@zip.com.au>
Cc: Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        lkml <linux-kernel@vger.kernel.org>,
        "ext3-users@redhat.com" <ext3-users@redhat.com>
Subject: Re: ext3-2.4-0.9.4
Message-ID: <20010727003208.A29436@weta.f00f.org>
In-Reply-To: <3B5FC7FB.D5AF0932@zip.com.au>, <3B5FC7FB.D5AF0932@zip.com.au> <20010726130809.D17244@emma1.emma.line.org> <3B60022D.C397D80E@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B60022D.C397D80E@zip.com.au>
User-Agent: Mutt/1.3.18i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Thu, Jul 26, 2001 at 09:42:37PM +1000, Andrew Morton wrote:

    If postfix is capable of opening the files O_SYNC or of doing
    fsync() on them then the `chattr +s' is no longer necessary -
    unlike ext2, when the O_SYNC write() or the fsync() return, the
    directory contents (as well as the inode, bitmaps, data, etc) will
    all be tight on disk and will be restored after a crash.

    This should speed things up considerably, especially with
    journalled-data mode.  I need to test and characterise this some
    more to come up with some quantitative results and configuration
    recommendations.

Postfix does an fsync on file before closing them, it then does a
rename and expects once rename as returned, the renamed actually
occured --- even if the fs crashes.  It also expects if you fsync a
file, then it will appear in the parent directory with certainty and
not say /lost+found after fsck on reboot.

Without +s under ext2, you can loose file(s) in /lost+found because
open+write+fsync+close works and ensures the data is on disk, but the
parent directory doesn't get synced to disk, so it might get lost.




  --cw
