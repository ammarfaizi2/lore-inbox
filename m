Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131018AbRCMNTN>; Tue, 13 Mar 2001 08:19:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131025AbRCMNTD>; Tue, 13 Mar 2001 08:19:03 -0500
Received: from mailhost.tue.nl ([131.155.2.5]:15959 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S131018AbRCMNSw>;
	Tue, 13 Mar 2001 08:18:52 -0500
Message-ID: <20010313141828.A6599@win.tue.nl>
Date: Tue, 13 Mar 2001 14:18:28 +0100
From: Guest section DW <dwguest@win.tue.nl>
To: Doug Siebert <dsiebert@divms.uiowa.edu>, linux-kernel@vger.kernel.org
Subject: Re: Issues with disk block devices
In-Reply-To: <200103130836.CAA06967@server.divms.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <200103130836.CAA06967@server.divms.uiowa.edu>; from Doug Siebert on Tue, Mar 13, 2001 at 02:36:09AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2001 at 02:36:09AM -0600, Doug Siebert wrote:

> This note is sort of a half question half bug report.

[devices are accessed in blocksize-size units, and this unit is changed
upon a mount, and is 1024 to start with; this gives problems if one
wants to access the last few sectors of a drive]

Yes, a known problem.
It will go in 2.5.
The problem is old, but until recently nobody complained -
sacrificing 1 or 3 sectors at the end of a disk to the roundoff
was something like sacrificing 62 sectors to DOS-compatibility.
These days people put partition tables and other interesting stuff
at the very end of a disk and this suddenly becomes a problem.

If you really want to touch the last sector of a disk, then
you can start a partition an integral number of blocks before
the end. Messy, but at least all of the disk is accessible.
An ioctl to change the block size of a partition (or the full disk)
is slightly better, but is dangerous - it can be used only
when nothing is mounted, etc.
(My memory is bad, but it seems to me that such an ioctl was
proposed, and I suggested to add the checks [not in use,
no mount, not swap device] but I don't know what happened
to this proposal afterwards. Must check.)

Andries

