Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131580AbRCSUjo>; Mon, 19 Mar 2001 15:39:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131586AbRCSUje>; Mon, 19 Mar 2001 15:39:34 -0500
Received: from dfw-smtpout2.email.verio.net ([129.250.36.42]:12221 "EHLO
	dfw-smtpout2.email.verio.net") by vger.kernel.org with ESMTP
	id <S131580AbRCSUjU>; Mon, 19 Mar 2001 15:39:20 -0500
Message-ID: <3AB66E4D.5B7E3E7B@bigfoot.com>
Date: Mon, 19 Mar 2001 12:38:37 -0800
From: Tim Moore <timothymoore@bigfoot.com>
Organization: Yoyodyne Propulsion Systems, Inc.
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.19pre17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: UDMA 100 / PIIX4 question
In-Reply-To: <20010318165246Z131240-406+1417@vger.kernel.org> <3AB65C51.3DF150E5@bigfoot.com> <3AB66449.5F5C673F@coplanar.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You should be able to get about 30 MB/s at the start of the disk (zone 0) according to IBM's datasheet at
> 
> http://ssdweb01.storage.ibm.com/techsup/hddtech/prodspec/dtla_spw.pdf
> 
> so if you were testing say /dev/hda1 which is at the start of the disk it should be faster.

"should be" is yes and yes, but you will not see 30MB/s and there is no actual difference between
/dev/hda and /dev/had1.

> Try hdparm -i /dev/hda (or whatever) .. . note the reported MaxMultSect= value,
> and put it in place of X in command:
> 
> hdparm -u 1 -d 1 -m X -c 1 /dev/hda

I've spent more time with real world data transfer testing than god, both PIIX4-based motherboards
and network based (Network Appliance <-> linux).  The only hdparm parameter that makes any
measurable, significnat difference for most modern drive and chipset combinations is -d1 and the
correct UDMA mode.

Try partitioning your disk in 4 equal segments and run multiple tests in runlevel1 on /dev/hda[1-4]
for '/usr/bin/time hdparm -tT' plus permutations of -a[0248]c[013]m[024816]u[01],
and /usr/bin/time dd if=/dev/hda[1-4] of=/dev/null bs=1k count={32,64,128,256,512,1024}k.

rgds,
tim.
--
