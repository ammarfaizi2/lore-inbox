Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132028AbQLJVCw>; Sun, 10 Dec 2000 16:02:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132900AbQLJVCm>; Sun, 10 Dec 2000 16:02:42 -0500
Received: from ja.ssi.bg ([193.68.177.189]:35591 "EHLO u.domain.uli")
	by vger.kernel.org with ESMTP id <S132028AbQLJVC3>;
	Sun, 10 Dec 2000 16:02:29 -0500
Date: Sun, 10 Dec 2000 22:32:43 +0000 (GMT)
From: Julian Anastasov <ja@ssi.bg>
To: "Victor J. Orlikowski" <v.j.orlikowski@gte.net>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.18pre25, S3, AMD K6-2, and MTRR....
In-Reply-To: <14898.50377.593756.7641@critterling.garfield.home>
Message-ID: <Pine.LNX.4.21.0012102150490.2089-100000@u>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello,

On Sat, 9 Dec 2000, Victor J. Orlikowski wrote:

> After doing some googling....
> It would appear that, in Family 5, Model 8, Stepping 12 of the K6-2,
> AMD used a different CPU core, that was more similar to the K6-3, and
> that there is a slightly odd way of doing write-combining.

	I'm now investigating the problem. It seems it is related
to XF86_SVGA (3.3.6):

S3VGEReset called from s3v_accel.c line 300

	Hm, what can trigger this reset

	On total lockup I can't activate ikd nor to use sysrq.
I can reproduce the temporary lockups afetr 1 minute of testing and
usually receive the above message. I have a ktrace output (not
sure if I catch the problem in this output) and this strace -r for
the XF86_SVGA program:

     0.001019 brk(0x851a000)            = 0x851a000
     0.009577 gettimeofday({976474616, 24017}, NULL) = 0
     4.865610 write(2, "\tS3VGEReset called from s3v_acce"..., 45) = 45
     0.000410 nanosleep({0, 10000000}, NULL) = 0
     0.012520 nanosleep({0, 10000000}, NULL) = 0
     0.019712 nanosleep({0, 10000000}, NULL) = 0
     0.019997 nanosleep({0, 10000000}, NULL) = 0

	What means 4.8 seconds between gettimeofday() and write() ?
Can this be a problem raised from gettimeofday? I have CONFIG_RTC=y
in all tests.

> Perhaps this is the problem?
> Anyone with more knowledge on the AMD cores care to comment?
>
> Victor

	So, I'm not sure whether the problem is in XFree or is
hardware/kernel related. IMO, it is not related to the MTRR
support. Any ideas for testing are welcome!


Regards

--
Julian Anastasov <ja@ssi.bg>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
