Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292094AbSBAV4Q>; Fri, 1 Feb 2002 16:56:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292096AbSBAV4G>; Fri, 1 Feb 2002 16:56:06 -0500
Received: from hera.cwi.nl ([192.16.191.8]:48040 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S292094AbSBAVz6>;
	Fri, 1 Feb 2002 16:55:58 -0500
From: Andries.Brouwer@cwi.nl
Date: Fri, 1 Feb 2002 21:55:54 GMT
Message-Id: <UTC200202012155.VAA123193.aeb@cwi.nl>
To: Andries.Brouwer@cwi.nl, p_gortmaker@yahoo.com
Subject: Re: [PATCH] clipped disk reports clipped lba size
Cc: alan@lxorguk.ukuu.org.uk, andre@linux-ide.org,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Paul Gortmaker <p_gortmaker@yahoo.com>

    Andries.Brouwer@cwi.nl wrote:

    > Some disk types fake LBA at 33.8GB, but allow access past this point.
    > Some disks actually give I/O errors past the 33.8GB (when jumpered),
    > and a SETMAX command is needed to make the rest accessible.
    > 
    > Two years ago I wrote a tiny utility setmax that does this.
    > If I am not mistaken this stuff is now part of the 2.5 kernel.
    > No doubt some of it will eventually be backported to 2.4 / 2.2 / 2.0.
    > It is in 2.4.18-pre7-ac1.

    Alan has said (quite reasonably) that he is not interested in inclusion
    of the big IDE patch that exists for 2.2.x -- however, a minimal cut and 
    paste backport from 2.4.x IDE to just support HDIO_DRIVE_CMD_AEB (and thus
    support setmax) is only about a 100 line diff which I did a while ago.

    If there is any interest in this I can check it still applies cleanly to 
    current 2.2 pre kernel and send it along for inclusion.

(1) *_AEB is intended as private namespace for me, not for inclusion
in an official kernel. So, some official name, like HDIO_DRIVE_TASK,
must be better.

(2) Long ago very little information was available and I wrote a small
program that worked for me and solicited experiences from others.
By now we have a better idea of the variations that exist.
Moreover, this is beginning 2.5 time, so experiments are allowed.
That means that we can delete CONFIG_IDEDISK_STROKE, and make the
kernel do what we think is right. Once this gets to a state where
there are no complaints anymore we can move it to some 2.4 tree,
and if that still does not produce complaints to 2.2 and 2.0.

In the area of big disks there are two main hurdles these days:
(a) capacity-limiting jumpers to overcome BIOS problems
(b) disks larger than 137 GB, the old ATA limit.

Both problems can be solved with relatively small patches,
no big monolithic IDE patch required. And I would prefer
to solve both problems without involving ioctl's, or boot
parameters, or config parameters. All should just work
in the common case.

Andries

