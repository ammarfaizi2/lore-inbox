Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269184AbTCBAr5>; Sat, 1 Mar 2003 19:47:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269185AbTCBAr5>; Sat, 1 Mar 2003 19:47:57 -0500
Received: from imo-d05.mx.aol.com ([205.188.157.37]:63487 "EHLO
	imo-d05.mx.aol.com") by vger.kernel.org with ESMTP
	id <S269184AbTCBAr4>; Sat, 1 Mar 2003 19:47:56 -0500
Message-ID: <3E615645.4010206@netscape.net>
Date: Sat, 01 Mar 2003 19:54:29 -0500
From: Nicholas Wourms <nwourms@netscape.net>
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.0.2) Gecko/20021120 Netscape/7.01
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Incorrect 80 wire detection with amd 760mpx & 2.4.21-pre4-ac7
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: Unknown (No Version)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI:
I suspect that: 
http://marc.theaimsgroup.com/?l=linux-kernel&m=104619727013220&w=2
is related to my problem.

Anyhow, I'm using a UDMA5 WesternDigital drive on a ASUS 
K7M266-D motherboard.  With a plain, stock 2.4.20 kernel, 
the viper driver properly recognizes which channel has the 
80 wire cable (in my case ide0).  The hard disk is the 
primary master, a cd-r drive is the primary slave, and a zip 
drive is the secondary slave.  I can successfully set UDMA5 
with hdparm without any problems.  However, after upgrading 
to 2.4.21-pre4-ac7, I noticed that the drive was stuck at 
UDMA2.  Checking /proc/ide/amd74XX yeilds some unexpected 
results:

----------AMD BusMastering IDE Configuration----------------
Driver Version:                     2.9
South Bridge:                       Advanced Micro Devices 
[AMD] AMD-768 [Opus] IDE
Revision:                           IDE 0x4
Highest DMA rate:                   UDMA100
BM-DMA base:                        0xd800
PCI clock:                          33.3MHz
-----------------------Primary IDE-------Secondary IDE------
Prefetch Buffer:              yes                 yes
Post Write Buffer:            yes                 yes
Enabled:                      yes                 yes
Simplex only:                  no                  no
Cable Type:                   40w                 80w
-------------------drive0----drive1----drive2----drive3-----
Transfer Mode:       UDMA      UDMA      UDMA       PIO
Address Setup:       30ns      30ns      30ns     120ns
Cmd Active:          90ns      90ns      90ns      90ns
Cmd Recovery:        90ns      90ns      30ns      30ns
Data Active:         90ns      90ns      90ns     330ns
Data Recovery:       30ns      90ns      30ns     270ns
Cycle Time:          60ns      60ns      60ns     600ns
Transfer Rate:   33.3MB/s  33.3MB/s  33.3MB/s   3.3MB/s

It appears that the driver has got it backwards, identifying 
my 80 wire cable as a 40 wire cable and visa-versa.  As I 
mentioned, this is completely opposite to the behavior of 
2.4.20.  I've poked around the source, but I can't come up 
with anything new to what the other person discovered. 
Trying to pass ide0=ata66 doesn't seem to have any effect on 
the situation.  I can provide further information upon 
request, but I don't think it will be necessary at this point.

Cheers,
Nicholas

