Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280776AbRKYJNE>; Sun, 25 Nov 2001 04:13:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280774AbRKYJMz>; Sun, 25 Nov 2001 04:12:55 -0500
Received: from weta.f00f.org ([203.167.249.89]:2969 "EHLO weta.f00f.org")
	by vger.kernel.org with ESMTP id <S280776AbRKYJMm>;
	Sun, 25 Nov 2001 04:12:42 -0500
Date: Sun, 25 Nov 2001 22:14:18 +1300
From: Chris Wedgwood <cw@f00f.org>
To: Florian Weimer <Florian.Weimer@RUS.Uni-Stuttgart.DE>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Journaling pointless with today's hard disks?
Message-ID: <20011125221418.A9672@weta.f00f.org>
In-Reply-To: <tgpu68gw34.fsf@mercury.rus.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tgpu68gw34.fsf@mercury.rus.uni-stuttgart.de>
User-Agent: Mutt/1.3.23i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2001 at 02:03:11PM +0100, Florian Weimer wrote:

    When the drive is powered down during a write operation, the
    sector which was being written has got an incorrect checksum
    stored on disk.  So far, so good---but if the sector is read
    later, the drive returns a *permanent*, *hard* error, which can
    only be removed by a low-level format (IBM provides a tool for
    it).  The drive does not automatically map out such sectors.

AVOID SUCH DRIVES... I have both Seagate and IBM SCSI drives which a
are hot-swappable in a test machine that I used for testing various
journalling filesystems a while back for reliability.

Some (many) of those tests involved removed the disk during writes
(literally) and checking the results afterwards.

The drives were set not to write-cache (they don't by default, but all
my IDE drives do, so maybe this is a SCSI thing?)

At no point did I ever see a partial write or corrupted sector; nor
have I seen any appear in the grown table, so as best as I can tell
even under removal with sustain writes there are SOME DRIVES WHERE
THIS ISN'T A PROBLEM.


Now, since EMC, NetApp, Sun, HP, Compaq, etc. all have products which
presumable depend on this behavior, I don't think it's going to go
away, it perhaps will just become important to know which drives are
brain-damaged and list them so people can avoid them.

As this will affect the Windows world too consumer pressure will
hopefully rectify this problem.




  --cw

P.S. Write-caching in hard-drives is insanely dangerous for
     journalling filesystems and can result in all sorts of nasties.
     I recommend people turn this off in their init scripts (perhaps I
     will send a patch for the kernel to do this on boot, I just
     wonder if it will eat some drives).
