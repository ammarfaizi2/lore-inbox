Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267088AbUBEXtg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 18:49:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267091AbUBEXtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 18:49:36 -0500
Received: from perkunas4.omnitel.net ([194.176.32.101]:47817 "EHLO
	perkunas4.omnitel.net") by vger.kernel.org with ESMTP
	id S267088AbUBEXtd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 18:49:33 -0500
Message-ID: <4022D68B.6090002@e-net.lt>
Date: Fri, 06 Feb 2004 01:49:31 +0200
From: Simonas Leleiva <Simonas.Leleiva@e-net.lt>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: benchmarking bandwidth Northbridge<->RAM
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I'm writing a benchmarking program under Linux.

Here's what I do (and what I sadly find inefficient):

1. I use the PCI_MEMORY_BAR0 address from the PCI device 00:00.0 (as
given in 'lspci' it's the Host (or North) bridge) and then I mmap the
opened /dev/mem with this address into user space, as it would be done
with any PCI device, which memory I want to access.

2. I manipulate on the returned pointer and the malloc'ed pointer (to
represent RAM) with memset command, keeping in mind that: A time for
data to flow between NB and RAM is equal to the time a RAM<->RAM
operation is completed minus the one with NB<->RAM (as I asume the
data goes RAM->NB->CPU->NB->RAM and NB->CPU->NB->RAM).

Now my doubts on each step mentioned above are:

1. Is such approach corrent? I doubt, because I've come across with
such Host bridges, which do NOT have an addresable memory region (on
my AMD Athlon NB starts @ 0xd0000000 and is of 128MB length; elsewhere
I've found it starting @ 0xe8000000-32MB, but recently my programme
crashed because the were NO addressable PCI region to the Host
bridge).
   After all, is this the way to directly accessing NB?

2. But what about L1/L2 caching ruining the benchmark, about which I judge
from very big results (~5GB/s is truly not the correct benchmark with my
2x166MHz RAM and 64bit bus - in the best case it should not overflow
2.5GB/s)? I've searched the web for cache disablings, but what I've only
found was the memtest's source-code, which works only under plain non-Linux
(non PM) environment (memtest makes a bootable floppy and then launches 'bare
naked'). So I find memtest's inline assembly useless under linux..
   The present workaround is to launch my benchmark with different set of
mem-chunks, and observing a speed-decrease at the specific size (when the
chunk doesn't fit in cache. In my case - decrease from 5GB/s to 2.9GB/s -
still too big..) and then treat that sized-chunks to be the actual benchmark
results.. However, part of the chunk may lay in cache anyway..

Where am I thinking wrong? Hope to get a tip from you out-there :)

Hear ya (hopefully soon) !

--
Simon





