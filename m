Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271578AbRH1P3b>; Tue, 28 Aug 2001 11:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271505AbRH1P3W>; Tue, 28 Aug 2001 11:29:22 -0400
Received: from mg03.austin.ibm.com ([192.35.232.20]:26558 "EHLO
	mg03.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S271507AbRH1P3G>; Tue, 28 Aug 2001 11:29:06 -0400
Message-ID: <3B8BB895.179331CE@us.ibm.com>
Date: Tue, 28 Aug 2001 10:28:21 -0500
From: Andrew Theurer <habanero@us.ibm.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Roberto Nibali <ratz@tac.ch>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Journal Filesystem Comparison on Netbench
In-Reply-To: <3B8A6122.3C784F2D@us.ibm.com> <3B8B6CEF.17C616C0@tac.ch>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roberto Nibali wrote:
> 
> Hello,
> 
> Thank you for those interesting tests.
> 
> > Some optimizations were used for linux, including zerocopy,
> > IRQ affinity, and interrupt delay for the gigabit cards,
> > and process affinity for the smbd processes.
> 
> Why is ext3 the only tested journaling filesystem that showed
> dropped packets [1] during the test and how do you explain it?
> 
> [1]: http://lse.sourceforge.net/benchmarks/netbench/results/\
>      august_2001/filesystems/raid1e/ext3/4p/droppped_packets.txt

Dropped packets are usually a side effect of the interrupt delay option
in the e1000 driver.  I choose 256 usec delay (default is 64) for all
these tests, and usually there is a very small % of dropped packets,
which usually shows up as 0.00%, since I only show 1/100's of a percent
in that output.  The other tests do have dropped packets, and I should
change that script to have more significant digits to show that.  I'm
not sure why ext3 shows more than the others.  Does ext3 have any spin
locks with interrupts disabled?

Andrew Theurer
