Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262700AbREOJaw>; Tue, 15 May 2001 05:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262702AbREOJam>; Tue, 15 May 2001 05:30:42 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:37902 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262700AbREOJaa>; Tue, 15 May 2001 05:30:30 -0400
Subject: Re: LANANA: To Pending Device Number Registrants
To: torvalds@transmeta.com (Linus Torvalds)
Date: Tue, 15 May 2001 10:26:32 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), neilb@cse.unsw.edu.au (Neil Brown),
        jgarzik@mandrakesoft.com (Jeff Garzik),
        hpa@transmeta.com (H. Peter Anvin),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List),
        viro@math.psu.edu
In-Reply-To: <Pine.LNX.4.21.0105150204020.1078-100000@penguin.transmeta.com> from "Linus Torvalds" at May 15, 2001 02:08:45 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14zb68-0002Fq-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But the fact remains that some users want to (a) avoid devfs and (b) have
> static maintenance. And I'm ok with that too, but only if the static major
> number is in the form of a _generic_ number that has absolutely nothing to
> do with any specific drivers (which is why I'd be perfecly ok with still
> adding a "disk" major number, but which is why I do NOT want to have Peter
> give out "the random number of today" to various stupid device drivers).
> So we seem to be in violent agreement here.

Ok.

Then we need to open the second discussion which is:

Given a file handle 'X' how do I find out what ioctl groups I should apply to
it. So we can go from

	if(MAJOR(st.st_rdev) == ST_MAJOR)
		issue_scsi_ioctls
	else if(MAJOR(st.st_rdev) == FTAPE_MAJOR)
		issue_ftape_ioctls
	else ..
	else
		error

to

	/* Use scsi if possible [scsi, ide-scsi, usb-scsi, ...] */
	if(HAS_FEATURE_SET(fd, "scsi-tape"))
		...
	else if(HAS_FEATURE_SET(fd, "floppy-tape"))
		..

Alan

