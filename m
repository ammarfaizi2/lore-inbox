Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292277AbSBBNiz>; Sat, 2 Feb 2002 08:38:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292280AbSBBNij>; Sat, 2 Feb 2002 08:38:39 -0500
Received: from hera.cwi.nl ([192.16.191.8]:40180 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S292277AbSBBNi1>;
	Sat, 2 Feb 2002 08:38:27 -0500
From: Andries.Brouwer@cwi.nl
Date: Sat, 2 Feb 2002 13:38:22 GMT
Message-Id: <UTC200202021338.NAA124053.aeb@cwi.nl>
To: Andries.Brouwer@cwi.nl, andre@linuxdiskcert.org, p_gortmaker@yahoo.com
Subject: Re: [PATCH] clipped disk reports clipped lba size
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Paul Gortmaker <p_gortmaker@yahoo.com>

    > (1) *_AEB is intended as private namespace for me, not for inclusion
    > in an official kernel. So, some official name, like HDIO_DRIVE_TASK,
    > must be better.

    Yes, DRIVE_TASK is of course the official name - I just knew you would
    immediately recognize *_AEB  & and know context/usage :)   BTW, if you
    didn't want it in an official kernel, it is a bit late for that. It has
    been in for some time in 2.4 .... <grep>  2.3.99pre9 to be exact.

Yes. But it is unnecessary and can be removed.

    > to solve both problems without involving ioctl's, or boot
    > parameters, or config parameters. All should just work
    > in the common case.

    This is a valid point - in an ideal situation things should just work
    without user intervention or setmax util, etc.  What are you currently
    recommending to 2.2.x kernel users that come across this limitation
    prior to such an ideal fix being released in a 2.2.x kernel?

Precisely what you also suggest: setmax plus the kernel patch that
makes it work. (Or: go to 2.4.)

    From Andre Hedrick <andre@linuxdiskcert.org>

    It is a valid and techincally correct operation; however, it is only one
    half of the solution.  Your "SETMAX" user-space IOCTL, is great if you do
    not have partitions that bridge that boundary, other wise TOAST.

If an extended partition table sector is located past the accessible
area of the disk, then probably accessing it yields an I/O error.
Later, using partx or "blockdev --rereadpt" or so, one can add the
missing partitions again. A bit ugly and kludgy, that is why the
kernel should do this itself, and automatically.

    Now the problem I have not addressed is the reboot issue,
    and neither have you.

Only partially. Details depend on type of disk and BIOS.
But roughly speaking, if one wants a warm reboot, one can
invoke setmax again to clip the disk (or hold F4 down
during the reboot).

Andries
