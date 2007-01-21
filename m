Return-Path: <linux-kernel-owner+w=401wt.eu-S1751293AbXAUSBS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbXAUSBS (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 13:01:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbXAUSBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 13:01:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:35716 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751293AbXAUSBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 13:01:17 -0500
X-Authenticated: #5039886
Date: Sun, 21 Jan 2007 19:01:14 +0100
From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: Chr <chunkeey@web.de>
Cc: Robert Hancock <hancockr@shaw.ca>, Jeff Garzik <jeff@garzik.org>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       linux-kernel@vger.kernel.org, htejun@gmail.com, jens.axboe@oracle.com,
       lwalton@real.com
Subject: Re: SATA exceptions with 2.6.20-rc5
Message-ID: <20070121180113.GC2441@atjola.homenet>
Mail-Followup-To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Chr <chunkeey@web.de>, Robert Hancock <hancockr@shaw.ca>,
	Jeff Garzik <jeff@garzik.org>,
	Alistair John Strachan <s0348365@sms.ed.ac.uk>,
	linux-kernel@vger.kernel.org, htejun@gmail.com,
	jens.axboe@oracle.com, lwalton@real.com
References: <fa.hif5u4ZXua+b0mVNaWEcItWv9i0@ifi.uio.no> <45B30A98.3030206@shaw.ca> <20070121083618.GA2434@atjola.homenet> <200701211834.41306.chunkeey@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200701211834.41306.chunkeey@web.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2007.01.21 18:34:40 +0100, Chr wrote:
> On Sunday, 21. January 2007 09:36, Björn Steinbrink wrote:
> > On 2007.01.21 00:39:20 -0600, Robert Hancock wrote:
> >
> > Ah, right... sata_nv.c of course interacts with the outside world, d'oh!
> >
> > Up to now, I only got bad kernels, latest tested being:
> > 94fcda1f8ab5e0cacc381c5ca1cc9aa6ad523576
> >
> > Which, unless I missed a commit in the diff, only USB changes,
> > continuing anyway.
> >
> > Just to make sure, here's my little helper for this bisect run, I hope
> > it does what you expected:
> >
> > #!/bin/bash
> > cp ../sata_nv.c.orig drivers/ata/sata_nv.c
> > git bisect good
> > cp drivers/ata/sata_nv.c ../sata_nv.c.orig
> > cp ../sata_nv.c drivers/ata/
> > make oldconfig
> > make -j4
> >
> > Where "../sata_nv.c" is the version from 2.6.20-rc5. The copying is done
> > to avoid conflicts and keep git happy. Of course there's also a version
> > for bad kernels ;) No idea, why I didn't make that an argument to the
> > script...
> >
> > Thanks,
> > Björn
> 
> Argggg, 2.6.19 (with 2.6.20-rc5 adma stuff) is affected too (BTW, what do you 
> do to trigger the exceptions? Because, it takes hours to "reproduces" this
> silly *************).

I run those two in parallel:
while /bin/true; do ls -lR / > /dev/null 2>&1; done
while /bin/true; do echo 255 > /proc/sys/vm/drop_caches; sleep 1; done

Not sure if running them in parallel is necessary, but I don't want to
change the test setup ;) Takes between 1 and 40 minutes to trigger it.
Most of the time it's around 15 minutes now, doing more random stuff in
addition to that seems to trigger it even easier (like reading mail,
rebuilding the kernel etc.).

I'm down to 2 commits after 2.6.19 now, only bad kernels, so I tend to
say that 2.6.19 with 2.6.20-rc5's sata_nv.c will also fail for me, but I
thought I might finish bisection just to be sure.

> But, this time it looks slightly different:
> ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata3.00: tag 0 cmd 0xec Emask 0x4 stat 0x40 err 0x0 (timeout)

> [Rest of the error message + SMART error snipped]

I get the same exception every time, doesn't change for me. And neither
do I get any SMART errors or something.

Thanks,
Björn
