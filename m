Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284246AbRLPFff>; Sun, 16 Dec 2001 00:35:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284248AbRLPFfZ>; Sun, 16 Dec 2001 00:35:25 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:8198 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S284246AbRLPFfO>; Sun, 16 Dec 2001 00:35:14 -0500
Message-ID: <3C1C3252.EFA44817@zip.com.au>
Date: Sat, 15 Dec 2001 21:34:10 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Patrick Mau <mau@oscar.prima.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Oops with 2.4.16-pre1 (nfs related)
In-Reply-To: <20011216015622.GA913@oscar.dorf.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mau wrote:
> 
> Hi all,
> 
> today I had the following oops which makes the machine hang.
> Lots of processes where in D state and I had no keyboard so
> I pushed the Big Button and rebooted.
> 
> The kernel runs without modules and uses ext3.
> Hardware is an old AMD K6-2, 384MB RAM, IDE Disks
> VIA chipset ... what else is important ?

Old.

Was this just a once-off?

> ...
> 
> >>EIP; c0129cf8 <__insert_into_lru_list+1c/5c>   <=====
> Trace; c012a5f0 <__refile_buffer+48/50>
> Trace; c012a600 <refile_buffer+8/10>
> Trace; c014dca4 <journal_dirty_data+168/19c>
> Trace; c0146ab8 <journal_dirty_sync_data+14/58>
> Trace; c0146922 <walk_page_buffers+56/7c>
> Trace; c0146ccc <ext3_commit_write+104/1b4>
> Trace; c0146aa4 <journal_dirty_sync_data+0/58>
> Trace; c0120834 <generic_file_write+498/640>
> Trace; c0144a06 <ext3_file_write+42/4c>
> Trace; c0173638 <nfsd_write+120/29c>
> Trace; c01782f2 <nfsd3_proc_write+ea/108>
> Trace; c0170032 <nfsd_dispatch+d2/1a0>
> Trace; c0215604 <svc_process+28c/4d8>
> Trace; c016fe2a <nfsd+1b2/2e8>

If anything, that would be an ext3 bug.  But that particular code
path has been trodden so many times by so many machines that
I'd be suspecting your RAM.  There are a couple of pointers
in the buffer_head which should be zero, and one of them is not.


-
