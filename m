Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263468AbUAYAEP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 19:04:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263491AbUAYAEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 19:04:15 -0500
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:46255 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S263468AbUAYAEE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 19:04:04 -0500
Message-Id: <5.1.0.14.2.20040125105347.02acce68@171.71.163.14>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sun, 25 Jan 2004 11:03:54 +1100
To: JG <jg@cms.ac>
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: TG3: very high CPU usage
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040124134334.A0BF9202CA0@23.cms.ac>
References: <20040122125516.7B671202CDC@23.cms.ac>
 <5.1.0.14.2.20040121100550.03cff190@171.71.163.14>
 <20040119033527.GA11493@linux.comp>
 <20040119033527.GA11493@linux.comp>
 <5.1.0.14.2.20040121100550.03cff190@171.71.163.14>
 <5.1.0.14.2.20040122143222.02a06d68@171.71.163.14>
 <20040122125516.7B671202CDC@23.cms.ac>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

At 12:43 AM 25/01/2004, JG wrote:
>box1 was sending, box2 receiving:
>box1 # ttcp -t -l 65536 -v -b 2097152 -s -D -n100000 192.168.0.3
>ttcp-t: -2036334592 bytes in 1247.57 real seconds = 1768.00 KB/sec +++
>ttcp-t: -2036334592 bytes in 30.01 CPU seconds = 73492.73 KB/cpu sec

urgh, those are terrible numbers!

>now the opposite, box2 was sending, box1 receiving:
>box2 ttcp # ttcp -t -l 65536 -v -b 2097152 -s -D -n100000 192.168.0.2
>ttcp-t: -2036334592 bytes in 153.82 real seconds = 14339.52 KB/sec +++
>ttcp-t: -2036334592 bytes in 28.61 CPU seconds = 77085.45 KB/cpu sec

better, but still terrible.

even an old Pentium3 @ 500MHz here is capable of pushing GbE wire-rate (i 
just tested this using a Tigon2).

>i thought the cable could be defective because of the results, but i 
>tested with another machine (windows xp, 100mbit card) and both up and 
>download speed via ftp (from both boxes!) was at about 8-9MB/s. so no 
>problem with the cable and it seems also no problem with 100mbit, but as 
>soon as i connect the two tg3 cards together with 1000mbit, one direction 
>is slow (cable is gbit certified and worked with 2.4 kernels without any 
>problem).

actually, this isn't necessarily the case.

Fast Ethernet only uses 1 pair of wires each for Tx/Rx (4 wires), whereas 
copper GbE uses 2 pairs each for Tx/Rx (8 wires).
it may be the case that your cable has some bad connections on the pins 
only used for 1000baseT.

>as i already mentionend in a previous email, the errors on the tg3 cards 
>are quite high, but only in RX:
>box1:
>RX packets:18585312 errors:102500 dropped:0 overruns:0 frame:102598
>TX packets:12435471 errors:0 dropped:0 overruns:0 carrier:0
>box2:
>RX packets:6864695 errors:202162 dropped:0 overruns:0 frame:204652
>TX packets:10049776 errors:0 dropped:0 overruns:0 carrier:0

on a x-over cable, you should NEVER have any errors.
if this is indeed simply an x-over cable, then i'd replace it and try again.

(note that for 1000baseT you don't need to worry about whether the cable is 
x-over or not; 1000baseT on most NICs/switches will auto-detect the parity 
anyway..).

Broadcom have a tool on their web site called "BACS" which can take 
advantage of some of the neat stuff in the PHY used on these boards.  one 
of the tests it can do is to check the quality of the cable and report any 
problems it sees; it can run a signal/noise test on each pair.

FYI, doing a "Cable Analysis" on a single port of a BCM5703 here connected 
to a switch (not x-over) with a ~1 metre patch cable shows:
         Distance (m):                   ~1
         Margin (dB):                    5.132
         Frequency Margin (MHz): 41.382


cheers,

lincoln.

