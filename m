Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266061AbUA1PyS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 10:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266072AbUA1PyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 10:54:18 -0500
Received: from c-24-19-70-33.client.comcast.net ([24.19.70.33]:56706 "EHLO
	waltsathlon.localhost.net") by vger.kernel.org with ESMTP
	id S266061AbUA1PxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 10:53:15 -0500
Message-ID: <4017DAE3.90803@comcast.net>
Date: Wed, 28 Jan 2004 07:53:07 -0800
From: Walt H <waltabbyh@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040121
X-Accept-Language: en-us
MIME-Version: 1.0
To: maneesh@in.ibm.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.1-mm2: BUG in kswapd? /  Oops in kobject_put during rsync
References: <40153A6E.5030300@comcast.net> <400762F9.5010908@comcast.net> <20040116094037.GA1276@in.ibm.com> <20040116102211.GC1276@in.ibm.com> <40080A98.4080105@comcast.net> <20040128111333.GA2990@in.ibm.com>
In-Reply-To: <20040128111333.GA2990@in.ibm.com>
X-Enigmail-Version: 0.83.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maneesh Soni wrote:
> Hi Walt,
> 
> Earlier you had BUG in kswapd while running rsync and reverting this patch 
> solved the problem.
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.1/2.6.1-mm3/broken-out/sysfs_remove_dir-vs-dcache_readdir-race-fix.patch
> 
> Did you get the kswapd BUG hit again on 2.6.1-mm3 with the debug patch I sent 
> you earlier? If you have got any logs with this then please send them to me.
> 
> If I am not wrong the kobject_put() oops is the new one you are seeing now
> and reverting this sysfs-pin-kobjects.patch solves this oops. The call trace
> for kobject_put oops seems some what surprising to me because on -mm kernels
> I don't think we can have sysfs dentries on the LRU list, sysfs dentries are 
> not pruned due to any memory pressure. sysfs dentries are pinned in memory 
> so there is no question of them being pruned due to memory pressure.
> 
> Now this is somewhat different in case of -mjb kernels as it has sysfs backing
> store patches and with that I can think of sysfs dentires coming to LRU list
> and getting pruned due to memory pressure. 
> 
> Are you using -mjb tree or the sysfs backing store patches? I would like
> to take a look at the kobject_put() oops you are having. 
>  
> Thanks
> Maneesh
> 

Hi Maneesh,

Good memory. You are correct, this oops is new. Reverting the
sysfs-pin-kobjects patch fixes it for me. I could reliably (like last
time that is) trigger an oops during rsync.

I'm running 2.6.2-rc1 with the -mm3 patchset and the mppe/mppc patches
located at: http://www.polbox.com/h/hs001/
No -mjb patches are used.

I did patch 2.6.1-mm3 with the debug patch you sent earlier, but alas,
it didn't BUG on me when I did the rsync with it. I don't believe that I
gave it much opportunity though, because -mm4 was released shortly
thereafter. Unfortunately, the BUG was nasty, in that it completely
stopped the system forcing an emergency sync, unmount reboot situation,
so I was anxious to get away from it ;)

-Walt

