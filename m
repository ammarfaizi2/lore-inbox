Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278120AbRKXNDd>; Sat, 24 Nov 2001 08:03:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278163AbRKXNDY>; Sat, 24 Nov 2001 08:03:24 -0500
Received: from mercury.rus.uni-stuttgart.de ([129.69.1.226]:60804 "EHLO
	mercury.rus.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id <S278120AbRKXNDO>; Sat, 24 Nov 2001 08:03:14 -0500
To: linux-kernel@vger.kernel.org
Subject: Journaling pointless with today's hard disks?
From: Florian Weimer <Florian.Weimer@RUS.Uni-Stuttgart.DE>
Date: 24 Nov 2001 14:03:11 +0100
Message-ID: <tgpu68gw34.fsf@mercury.rus.uni-stuttgart.de>
User-Agent: Gnus/5.090001 (Oort Gnus v0.01) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the German computer community, a statement from IBM[1] is
circulating which describes a rather peculiar behavior of certain IBM
IDE hard drivers (the DTLA series):

When the drive is powered down during a write operation, the sector
which was being written has got an incorrect checksum stored on disk.
So far, so good---but if the sector is read later, the drive returns a
*permanent*, *hard* error, which can only be removed by a low-level
format (IBM provides a tool for it).  The drive does not automatically
map out such sectors.

IBM claims this isn't a firmware error, but thinks that this explains
the failures frequently observed with DTLA drivers (which might
reflect reality or not, I don't know, but that's not the point
anyway).

Now my question: Obviously, journaling file systems do not work
correctly on drivers with such behavior.  In contrast, a vital data
structure is frequently written to (the journal), so such file systems
*increase* the probability of complete failure (with a bad sector in
the journal, the file system is probably unusable; for non-journaling
file systems, only a part of the data becomes unavailable).  Is the
DTLA hard disk behavior regarding aborted writes more common among
contemporary hard drives?  Wouldn't this make journaling pretty
pointless?


1. http://www.cooling-solutions.de/dtla-faq (German)

-- 
Florian Weimer 	                  Florian.Weimer@RUS.Uni-Stuttgart.DE
University of Stuttgart           http://cert.uni-stuttgart.de/
RUS-CERT                          +49-711-685-5973/fax +49-711-685-5898
