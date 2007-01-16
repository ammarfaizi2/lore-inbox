Return-Path: <linux-kernel-owner+w=401wt.eu-S1750755AbXAPLZQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbXAPLZQ (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 06:25:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750846AbXAPLZP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 06:25:15 -0500
Received: from mail.cbxnet.de ([212.87.33.16]:60568 "EHLO mail1.combox.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750755AbXAPLZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 06:25:14 -0500
X-Greylist: delayed 2663 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Jan 2007 06:25:14 EST
Subject: Re: incorrect checksum on sent TCP-MD5 packets (2.6.20-rc5)
From: Torsten =?ISO-8859-1?Q?L=FCttgert?= <t.luettgert@cbxnet.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Stephen Hemminger <shemminger@osdl.org>, yoshfuji@linux-ipv6.org
In-Reply-To: <20070115101522.481e2f8f@freekitty>
References: <1168803154.3090.45.camel@elida.cbxnet.de>
	 <20070115101522.481e2f8f@freekitty>
Content-Type: text/plain
Date: Tue, 16 Jan 2007 11:40:48 +0100
Message-Id: <1168944048.3033.14.camel@sokrates.cff>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-3.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mo, 2007-01-15 at 10:15 -0800, Stephen Hemminger wrote:

> Are you running over a device that does checksum offload?

Ooh, I'm feeling stupid now. Yes, I was. Turns out the problem
are the md5 checksums after all. Crypto-enabled tcpdump says:

11:05:42.856702 IP (tos 0x0, ttl  64, id 35129, offset 0, flags [DF],
proto: TCP (6), length: 80) 212.87.33.4.60565 > 212.87.49.254.bgp: S,
cksum 0x4a03 (correct), 1122127063:1122127063(0) win 5840 <mss
1460,sackOK,timestamp 63686126 0,nop,wscale 5,nop,nop,md5:valid>

11:05:42.871809 IP (tos 0x0, ttl 253, id 0, offset 0, flags [none],
proto: TCP (6), length: 64) 212.87.49.254.bgp > 212.87.33.4.60565: S,
cksum 0x0cc9 (correct), 2943414712:2943414712(0) ack 1122127064 win
16384 <mss 516,md5:valid,eol>

11:05:42.872085 IP (tos 0x0, ttl  64, id 35130, offset 0, flags [DF],
proto: TCP (6), length: 60) 212.87.33.4.60565 > 212.87.49.254.bgp: .,
cksum 0x4160 (correct), ack 1 win 5840 <nop,nop,md5:valid>

11:05:42.872150 IP (tos 0x0, ttl  64, id 35131, offset 0, flags [DF],
proto: TCP (6), length: 105) 212.87.33.4.60565 > 212.87.49.254.bgp: P,
cksum 0x54ec (correct), 1:46(45) ack 1 win 5840 <nop,nop,md5:invalid>:
BGP, length: 45
...

- Torsten


