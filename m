Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264286AbTDKBBg (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 21:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264287AbTDKBBg (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 21:01:36 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:24257 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264286AbTDKBBb (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 21:01:31 -0400
Date: Thu, 10 Apr 2003 18:15:01 -0700
From: Hanna Linder <hannal@us.ibm.com>
Reply-To: Hanna Linder <hannal@us.ibm.com>
To: akpm@digeo.com
cc: linux-kernel@vger.kernel.org, hannal@us.ibm.com
Subject: [Lockmeter 2.5] BKL with 51ms hold time, prove me wrong
Message-ID: <46950000.1050023701@w-hlinder>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


My original purpose was to verify my lockmeter port is producing 
valid data so I was comparing to readprofile results. However, I saw 
these high hold times and wanted to show them to you. Here is the 
whole lockmeter output file: 
http://prdownloads.sourceforge.net/lse/lockmeter.rmapm

Below is a snippet of lockmeter data from running Andrew Morton's
rmap-test -m -i 10 -n 50 -s 600 -t 100 foo
on a 2-way PIII 256MB RAM 500MHz System

If my port of the lockmeter tool is correct then this high hold
time is a bad thing. If the lockmeter tool is incorrect please let 
me know. Here is the link to a lockmeter patch (originally written 
by John Hawkes, I simply ported it): 
http://prdownloads.sourceforge.net/lse/lockmeter1.5-2.5.64-1.diff

Thanks.

Hanna

___________________________________________________________________________
System: Linux w-hlinder2 2.5.66-mjb2lm #3 SMP Thu Apr 10 18:58:09 PDT 2003 i686
Total counts

All (2) CPUs

Start time: Thu Apr 10 19:03:39 2003
End   time: Thu Apr 10 19:08:19 2003
Delta Time: 280.24 sec.
Hash table slots in use:      217.
Global read lock slots in use: 161.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
SPINLOCKS         HOLD            WAIT
  UTIL  CON    MEAN(  MAX )   MEAN(  MAX )(% CPU)     TOTAL NOWAIT SPIN RJECT  NAME

       13.7%  2.4us(  51ms)  1.1us(  22ms)(0.15%)   6360789 86.3% 11.2%  2.6%  *TOTAL*

 0.12%    0%  0.3us(  22ms)    0us                  1033785  100%    0%    0%  journal_datalist_lock
 0.04%    0% 2348us(  22ms)    0us                       43  100%    0%    0%    journal_commit_transaction+0x2a0

 0.59% 0.82%   13us(  51ms)   89us(  22ms)(0.02%)    126172 99.2% 0.82%    0%  kernel_flag
 0.02%    0%   26ms(  51ms)    0us                        2  100%    0%    0%    ext3_delete_inode+0x34
 0.06% 48.7%   79us(  22ms)   35us(  20ms)(0.01%)      2115 51.3% 48.7%    0%    schedule+0x48c

 0.00% 36.0%  2.9us(  12us)  1.1us( 3.0us)(0.00%)        25 64.0% 36.0%    0%  runqueues
 0.00% 36.0%  2.9us(  12us)  1.1us( 3.0us)(0.00%)        25 64.0% 36.0%    0%    load_balance+0x148

    0%  100%                   0us                   134325    0%    0%  100%  cache_alloc_refill+0x15c
    0%  100%                   0us                    14658    0%    0%  100%  cache_alloc_refill+0x1f0
 0.03%    0%  7.4us(  24us)    0us                    10472  100%    0%    0%  cache_alloc_refill+0x78
    0%  100%                   0us                    14658    0%    0%  100%  cache_alloc_refill+0xcc
 
 0.62%    0% 5084us(  48ms)    0us                      339  100%    0%    0%  unmap_vmas+0x1c0

