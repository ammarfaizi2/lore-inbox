Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261695AbVGDNei@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261695AbVGDNei (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 09:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261690AbVGDNe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 09:34:27 -0400
Received: from ws6-4.us4.outblaze.com ([205.158.62.107]:62105 "HELO
	ws6-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S261695AbVGDNSi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 09:18:38 -0400
Message-ID: <42C93733.1090708@grimmer.com>
Date: Mon, 04 Jul 2005 15:18:43 +0200
From: Lenz Grimmer <lenz@grimmer.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: hdaps-devel@lists.sourceforge.net,
       LKML List <linux-kernel@vger.kernel.org>
Subject: Re: IBM HDAPS things are looking up
References: <9a8748490507031832546f383a@mail.gmail.com> <42C8D06C.2020608@grimmer.com> <20050704061713.GA1444@suse.de> <42C8C978.4030409@linuxwireless.org> <20050704063741.GC1444@suse.de> <1120461401.3174.10.camel@laptopd505.fenrus.org> <20050704072231.GG1444@suse.de> <1120462037.3174.25.camel@laptopd505.fenrus.org> <20050704073031.GI1444@suse.de> <42C91073.80900@grimmer.com> <20050704110604.GL1444@suse.de>
In-Reply-To: <20050704110604.GL1444@suse.de>
X-Enigmail-Version: 0.91.0.0
OpenPGP: id=B27291F2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Jens!

Thanks for the sample code. I've trimmed the recipient list a bit...

Jens Axboe wrote:

> Perhaps the IDLE or IDLEIMMEDIATE commands imply a head parking, that
> would make sense. As you say, you can hear a drive parking its head.
> Here's a test case, it doesn't sound like it's parking the hard here.

Not here either, but let me check, if I understand this correctly:

> #include <stdio.h>
> #include <unistd.h>
> #include <fcntl.h>
> #include <sys/ioctl.h>
> #include <linux/hdreg.h>
> 
> int main(int argc, char *argv[])
> {
> 	char cmd[4] = { 0xe1, 0, 0, 0 };

The "0xe1" in here is what is defined as "WIN_IDLEIMMEDIATE" in hdreg.h,
correct?

> 	int fd;
> 
> 	if (argc < 2) {
> 		printf("%s <dev>\n", argv[0]);
> 		return 1;
> 	}
> 
> 	fd = open(argv[1], O_RDONLY);

Hmm, don't I need to actually have *write* access for sending an ioctl?

> 	if (fd == -1) {
> 		perror("open");
> 		return 1;
> 	}
> 
> 	if (ioctl(fd, HDIO_DRIVE_CMD, cmd))
> 		perror("ioctl");
> 
> 	close(fd);
> 	return 0;
> }

I will give it another try, after clarifying the above questions - maybe
there is a command that will perform the desired task. If not, I guess
we're back at snooping what the Windows driver does here...

Bye,
	LenZ
- --
- ------------------------------------------------------------------
 Lenz Grimmer <lenz@grimmer.com>                             -o)
 [ICQ: 160767607 | Jabber: LenZGr@jabber.org]                /\\
 http://www.lenzg.org/                                       V_V
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCyTcySVDhKrJykfIRAqAEAJ93Fx7EpdtAfoR7ab61D9CDgIFX1ACfekHD
9Dxg1MDYwph+8tQfHicWii8=
=YM7P
-----END PGP SIGNATURE-----
