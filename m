Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262762AbRE2GVg>; Tue, 29 May 2001 02:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262733AbRE2GV0>; Tue, 29 May 2001 02:21:26 -0400
Received: from ws17.krasu.ru ([62.76.120.47]:16132 "EHLO ws17.krasu.ru")
	by vger.kernel.org with ESMTP id <S263217AbRE2GVL>;
	Tue, 29 May 2001 02:21:11 -0400
Date: Tue, 29 May 2001 14:20:19 +0800
From: Anton Voloshin <vav@isv.ru>
To: linux-kernel@vger.kernel.org
Subject: BUG REPORT: 2.4.4 hang on large network transfers with RTL-8139
Message-ID: <20010529142019.C757@ws17.krasu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've got a kernel hang (can easily be reproduced on my computer).
It happens on relatively large outgoing network traffic.
For instance, on trying to upload some large file from workstation to
other machine via SMB or FTP.

On 2.4.4 hang was after sending about 20Kb.
On 2.4.5 it seems to hang after 870+ Kb.
When sending data via slow link (e.g. local Ethernet -> remote modem),
everything is Ok.

Network card is (taken from /proc/pci):

  Bus  1, device  11, function  0:
    Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 16).
      IRQ 10.
      Master Capable.  Latency=208.  Min Gnt=32.Max Lat=64.
      I/O at 0x7800 [0x78ff].
      Non-prefetchable 32 bit memory at 0xfebfff00 [0xfebfffff].

2.4.3 works Ok, 2.4.4 and 2.4.5 both has this problem.

Lamer's assumption: maybe troubles with sendfile() after zero-copy patches?

-- 
Anton <vav@isv.ru>
