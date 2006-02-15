Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423053AbWBOJBf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423053AbWBOJBf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 04:01:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423054AbWBOJBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 04:01:35 -0500
Received: from host-a-002.milc.com.pl ([213.17.132.2]:7620 "EHLO milc.com.pl")
	by vger.kernel.org with ESMTP id S1423053AbWBOJBe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 04:01:34 -0500
Date: Wed, 15 Feb 2006 10:01:30 +0100
From: Yoss <bartek@milc.com.pl>
To: Willy TARREAU <willy@w.ods.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Memory leak in 2.4.33-pre1?
Message-ID: <20060215090130.GA3343@milc.com.pl>
References: <20060213214651.GA27844@milc.com.pl> <20060214000529.GJ11380@w.ods.org> <20060214082136.GA9993@milc.com.pl> <20060214214349.GA298@w.ods.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060214214349.GA298@w.ods.org>
User-Agent: Mutt/1.3.28i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.4 (milc.com.pl [127.0.0.1]); Wed, 15 Feb 2006 10:01:30 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2006 at 10:43:49PM +0100, Willy TARREAU wrote:
> On Tue, Feb 14, 2006 at 09:21:36AM +0100, Yoss wrote:
> > I downgraded hernel to 2.4.33 last night.
> I presume you mean 2.4.32 here.

Right. :)

> 
> > So there is no slabinfo from that problem now. But thank you for reply.
> > Why is this memory not showed somewhere in top or free?
> 
> I don't know, it's some gray area for me too, it's just that I'm used to
> this behaviour. I even have a program that I run to free it when I want
> to prioritize disk cache usage over dentry cache (appended to this mail).

I think it is grey for me too ;\
After about 36h of run the summary size of processes is 714MB. Free
says:

webcache:~# free -m
             total       used       free     shared    buffers  cached
Mem:          1009        996         13          0		    50      93
-/+ buffers/cache:        852        157
Swap:         1953          0       1953

So thereis 139MB of difference. But:

#slabtop -s c -o | head -20

Active / Total Objects (% used)    : 793971 / 805664 (98.5%)
 Active / Total Slabs (% used)      : 66499 / 66513 (100.0%)
 Active / Total Caches (% used)     : 36 / 59 (61.0%)
 Active / Total Size (% used)       : 235510.62K / 236644.88K (99.5%)
 Minimum / Average / Maximum Object : 0.02K / 0.29K / 128.00K

OBJS ACTIVE  USE OBJ SIZE  SLABS OBJ/SLAB CACHE SIZE NAME
362495 362490  99%    0.50K  51785        8     207140K inode_cache
380910 380900  99%    0.12K  12697       32      50788K dentry_cache
44800  35342  78%    0.09K   1120       42        4480K	buffer_head
636    607  95%    2.00K    318        2          1272K size-2048
139    139 100%    4.00K    139        1           556K size-4096
2064   1891  91%    0.16K     86       25          344K ip_dst_cache
232    224  96%    0.91K     58        4           232K	sock
2080   2048  98%    0.09K     52       42	       208K blkdev_requests
5198   4495  86%    0.03K     46      128		   184K size-32
1032    658  63%    0.16K     43       25		   172K skbuff_head_cache
870    864  99%    0.12K     29       32		   116K filp
1416   1381  97%    0.06K     24       64		    96K size-64
570    545  95%    0.12K     19			 32         76K size-128
								 
> Have you noticed the difference ? So the memory is not wasted at all. It's
> just reported as 'used'.

I see. I also noticed that I simply cannot tell what for is this memory
used. Is this better for me to enlarge cache_mem in squid for about
100MB and have less *_cache or is better to have more *_cache? :)

> > > If you don't believe me, simply allocate 1 GB in a process, then free it.
> > If that what you said is rigth, day after tomorow I'll have the same
> > situation - only thing I have changed is kernel. So we'll see. :)
> 
> If you encounter it, simply run the tool below with a size in kB. Warning!
> a wrong parameter associated with improper ulimit will hang your system !
> Ask it to allocate what you *know* you can free (eg: the swapfree space).

I don't matter is this memory used for cache or free. I just want to be
sure that it is not leaking :)

-- 
Bart³omiej Butyn aka Yoss
Nie ma tego z³ego co by na gorsze nie wysz³o.
