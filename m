Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280448AbRKNLCI>; Wed, 14 Nov 2001 06:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280450AbRKNLB5>; Wed, 14 Nov 2001 06:01:57 -0500
Received: from kweetal.tue.nl ([131.155.2.7]:17192 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S280448AbRKNLBw>;
	Wed, 14 Nov 2001 06:01:52 -0500
Message-ID: <20011114120218.B21270@win.tue.nl>
Date: Wed, 14 Nov 2001 12:02:18 +0100
From: Guest section DW <dwguest@win.tue.nl>
To: Robert Holmberg <robert.holmberg@helsinki.fi>,
        linux-kernel@vger.kernel.org
Subject: Re: [OT] Odd partition overlapping problem
In-Reply-To: <Pine.LNX.3.95.1011113095524.1544A-100000@chaos.analogic.com> <1005691726.2007.0.camel@localhost> <1005724114.405.0.camel@spinel> <1005750180.1234.2.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <1005750180.1234.2.camel@localhost>; from Robert Holmberg on Wed, Nov 14, 2001 at 10:02:59AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2001 at 10:02:59AM -0500, Robert Holmberg wrote:

> It seems my hda 6 is overlapping my hda4.
> 
> Partition table: 
> Device 	  Boot    Start       End    Blocks   Id  System
> /dev/hda1   *         1       523   4200966    c  Win95 FAT32 (LBA)
> /dev/hda2           524       525     16065   83  Linux
> /dev/hda3           526      2647  17044965   83  Linux
> /dev/hda4          2648      3736   8747392+   5  Extended
> /dev/hda5          2648      2713    530113+  82  Linux swap
> /dev/hda6          2714      3736   8217216    c  Win95 FAT32 (LBA)

There is nothing wrong with this partition table,
from a Linux point of view.

But lots of things may be wrong in the Windows - Linux cooperation.

Windows has its own data independent of the partition table.
So, if you change the partition table Windows may still use
the original partitioning.

Something else that may be bad: type 5 becomes type f when LBA
should be used. Since you are past cylinder 1024 you do not
want the CHS data to be used.

Something else that may be bad: DOS/Windows expects that type 5/f is
their own. At least the first partition in an extended should
be a DOS/Windows one, otherwise some programs will be unhappy.

Etc.

Try first f instead of 5, that is the easiest change.
