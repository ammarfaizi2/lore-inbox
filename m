Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312402AbSC3L5m>; Sat, 30 Mar 2002 06:57:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312458AbSC3L5c>; Sat, 30 Mar 2002 06:57:32 -0500
Received: from ce06d.unt0.torres.ka0.zugschlus.de ([212.126.206.6]:56324 "EHLO
	torres.ka0.zugschlus.de") by vger.kernel.org with ESMTP
	id <S312402AbSC3L5U>; Sat, 30 Mar 2002 06:57:20 -0500
Date: Sat, 30 Mar 2002 12:57:18 +0100
From: Marc Haber <mh+linux-kernel@zugschlus.de>
To: linux-kernel@vger.kernel.org
Subject: [ATM] PCA200E driver seems to ignore UBR Peak Cell Rate
Message-ID: <20020330125718.A5985@torres.ka0.zugschlus.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I recently had to spend some time with a funky ATM problem, and didn't
find any info on web, mailing list archives or Usenet. We are using a
Linux machine (running Debian GNU/Linux with kernel 2.4.18, atm-tools
0.79 and a Fore 200E card). Here is the syslog output from the kernel
module loading:

|Mar 18 16:20:08 elena kernel: fore200e: device PCA-200E found at 0xec000000, IRQ 10
|Mar 18 16:20:08 elena kernel: fore200e: device PCA-200E-0 self-test passed
|Mar 18 16:20:08 elena kernel: fore200e: device PCA-200E-0 firmware started
|Mar 18 16:20:08 elena kernel: fore200e: device PCA-200E-0 initialized
|Mar 18 16:20:08 elena kernel: fore200e: device PCA-200E-0, rev. A, S/N: 48400, ESI: 00:20:48:04:bd:10
|Mar 18 16:20:08 elena kernel: fore200e: IRQ 10 reserved for device PCA-200E-0

For our application (termination of bandwidth limited PVCs connecting
DSL customers), we need UBR with a specified peak cell rate. However,
when I try to program this for the PVC (using the command atmarp -s
10.33.66.62 0.0.33 qos ubr:max_pcr=144kbps), the card seems to ignore
the pcr, "blasting away" at link speed. This causes the ATM switch on
the link (which is not under our control) to drop cells, making the IP
link nearly unuseable.

This doesn't seem to apply for CBR, though. cbr:max_pcr=1Mbit yields a
throughput of 60 KByte/s (way too slow for an 1 Mbit link), and
cbr:max_pcr=2Mbit yields about 180 Kbyte/s (still too slow for the
bandwidth allocated, but not double 1 Mbit). Is the Fore 200E hardware
capable to do UBR with a specified peak cell rate? Do you have any
idea what I might be doing wrong?

Any hints will be greatly appreciated. Thanks.

Greetings
Marc

-- 
-----------------------------------------------------------------------------
Marc Haber         | "I don't trust Computers. They | Mailadresse im Header
Karlsruhe, Germany |  lose things."    Winona Ryder | Fon: *49 721 966 32 15
Nordisch by Nature |  How to make an American Quilt | Fax: *49 721 966 31 29
