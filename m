Return-Path: <linux-kernel-owner+w=401wt.eu-S1751539AbXAUUNb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751539AbXAUUNb (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 15:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751577AbXAUUNa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 15:13:30 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:57817 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751539AbXAUUNa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 15:13:30 -0500
From: Chr <chunkeey@web.de>
To: =?iso-8859-1?q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
Subject: Re: SATA exceptions with 2.6.20-rc5
Date: Sun, 21 Jan 2007 21:13:21 +0100
User-Agent: KMail/1.9.5
Cc: Robert Hancock <hancockr@shaw.ca>, Jeff Garzik <jeff@garzik.org>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       linux-kernel@vger.kernel.org, htejun@gmail.com, jens.axboe@oracle.com,
       lwalton@real.com, chunkeey@web.de
References: <fa.hif5u4ZXua+b0mVNaWEcItWv9i0@ifi.uio.no> <200701211834.41306.chunkeey@web.de> <20070121180113.GC2441@atjola.homenet>
In-Reply-To: <20070121180113.GC2441@atjola.homenet>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200701212113.22965.chunkeey@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, 21. January 2007 19:01, Björn Steinbrink wrote:
> On 2007.01.21 18:34:40 +0100, Chr wrote:
>
> I run those two in parallel:
> while /bin/true; do ls -lR / > /dev/null 2>&1; done
> while /bin/true; do echo 255 > /proc/sys/vm/drop_caches; sleep 1; done
>
> Not sure if running them in parallel is necessary, but I don't want to
> change the test setup ;) Takes between 1 and 40 minutes to trigger it.
> Most of the time it's around 15 minutes now, doing more random stuff in
> addition to that seems to trigger it even easier (like reading mail,
> rebuilding the kernel etc.).
>
> I'm down to 2 commits after 2.6.19 now, only bad kernels, so I tend to
> say that 2.6.19 with 2.6.20-rc5's sata_nv.c will also fail for me, but I
> thought I might finish bisection just to be sure.
>
> > But, this time it looks slightly different:
> > ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> > ata3.00: tag 0 cmd 0xec Emask 0x4 stat 0x40 err 0x0 (timeout)
> >
> > [Rest of the error message + SMART error snipped]
>
> I get the same exception every time, doesn't change for me. And neither
> do I get any SMART errors or something.
>
> Thanks,
> Björn

Ok, you won't believe this... I opened my case and rewired my drives... 
And guess what, my second (aka the "good") HDD is now failing! 
I guess, my mainboard has a (but maybe two, or three :( ) "bad" sata-port(s)!  

But, one small question remains: when I opened my case, I saw that my drivers
are pluged in SATA jack 1 and 2... The BIOS also says they're on 1 and 2.
Now, Linux says they're on port 3 & 4! 



it's always ata3.00!
"ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata3.00: tag 0 cmd 0xea Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3: soft resetting port
ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata3.00: configured for UDMA/133
ata3: EH complete
SCSI device sda: 490234752 512-byte hdwr sectors (251000 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back"


Thanks,
Chr.
