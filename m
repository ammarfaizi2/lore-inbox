Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267396AbUIPJ3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267396AbUIPJ3W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 05:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267880AbUIPJ3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 05:29:22 -0400
Received: from [62.159.120.65] ([62.159.120.65]:55992 "EHLO
	srv-adh-vm-0007.adminsend.de") by vger.kernel.org with ESMTP
	id S267396AbUIPJ3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 05:29:16 -0400
Message-ID: <41495CC8.3010904@adminsend.de>
Date: Thu, 16 Sep 2004 11:28:40 +0200
From: Andreas Huemmer <swing@adminsend.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 3ware 9500 ("3w-9xxx") w/ dual Opteron (Tyan 2885)
References: <2CdNY-57s-9@gated-at.bofh.it> <2ENNk-1Dl-5@gated-at.bofh.it> <2ENNk-1Dl-3@gated-at.bofh.it>
In-Reply-To: <2ENNk-1Dl-3@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ed,

du You use a riser card in Your system. Some time ago there has been som 
bus/electrical probs with this, expecially on tyan mb and 3ware controllers?

however, You may have noticed that the 9xxx controller sets hav some 
cache ram on it, which makes them very vulnerable if any machine probs 
occure. As You pointed out on the web link a kernel paging request 
failed with that controller. Recentley there has been some other issues 
on this list discussing this and related topics, (blame me if I m not 
right) but no one at all found a final solution on these topics. 
nevertheless, there are several things you can try, to get you 
controller running stable:

oh, just for reference: Im running an dual athlon with two 9000/12 
controllers with the original driver source from 3Ware (rev. 9), but 
this should make any differnence.

yes, what you can do, to avoid unsuccessfull paging requests in this 
case is:

a) rizing the preasure tho sync data to disc (can anyone post the 
respective sysctl parameter...I know there was a thread here in the 
list...but I can t find it .-()

b) rize the minimum of free mem before the system starts to free some 
itself to something like 20 Megs (which worked for me - no more oopses 
anymore after this setting - even under high load)

vm.min_free_kbytes : 20000

When I m following some threads right there has also been some fixes to 
  patch-releases of the kernel which should also solve the problem, so 
consider the things mentioned above as a workaround...

cioa
andi

Ed Hill wrote:
> On Wed, 2004-09-08 at 13:01, Denis Vlasenko wrote:
> 
>>On Wednesday 08 September 2004 19:40, Ed Hill wrote:
>>
>>>Hi folks,
>>>
>>>Has anyone managed to get a 3ware 9500-series RAID controller working
>>>stably on an SMP Opteron system?  
> 
> 
>>Post oopses to the list.
> 
> 
> 
> Hi Denis,
> 
> Below is an oops from a "vanilla" 2.6.8.1 w/ latest 3ware 2.6 driver
> from their web site.  More details are available at:
> 
>   http://acesgrid.org/ACESwiki/StorageAdamsAsimov
> 
> thanks,
> Ed
> 
> === "vanilla" 2.6.8.1 w/ latest 3ware 2.6 driver from their web site ===
> 
> Sep  2 19:37:19 adams kernel: Unable to handle kernel paging request at
> 000003010383a8d0 RIP: 
> Sep  2 19:37:19 adams kernel: <ffffffff801349c8>{__wake_up_common+40}
> Sep  2 19:37:19 adams kernel: PML4 0 
> Sep  2 19:37:19 adams kernel: Oops: 0000 [1] SMP 
> Sep  2 19:37:19 adams kernel: CPU 1 
> Sep  2 19:37:19 adams kernel: Modules linked in: nfsd exportfs ipv6 parport_pc lp \
>   parport autofs4 nfs lockd sunrpc iptable_filter ip_tables tg3 ohci1394 ieee1394 \
>   sd_mod dm_mod ohci_hcd button battery asus_acpi ac
> Sep  2 19:37:19 adams kernel: Pid: 62, comm: kswapd1 Not tainted 2.6.8.1
> Sep  2 19:37:19 adams kernel: RIP: 0010:[<ffffffff801349c8>] <ffffffff801349c8>{__wake_up_common+40}
> Sep  2 19:37:19 adams kernel: RSP: 0018:00000101ffee1b88  EFLAGS: 00010006
> Sep  2 19:37:19 adams kernel: RAX: 000003010383a8d0 RBX: 000001010383a8c8 RCX: 0000000000000000
> Sep  2 19:37:19 adams kernel: RDX: 0000000000000001 RSI: 0000000000000003 RDI: 000001010383a8c8
> Sep  2 19:37:19 adams kernel: RBP: 00000101ffee1bb8 R08: 000001010335b0d8 R09: 00000101ffee1ad0
> Sep  2 19:37:19 adams kernel: R10: 00000100cd7b4c80 R11: 0000000000000000 R12: 00000101ffee1db8
> Sep  2 19:37:19 adams kernel: R13: 0000000000000001 R14: 000001010383a8d0 R15: 000001010335b0d8
> Sep  2 19:37:19 adams kernel: FS:  0000002a9557e800(0000) GS:ffffffff80542e80(0000) knlGS:0000000000000000
> Sep  2 19:37:19 adams kernel: CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
> Sep  2 19:37:19 adams kernel: CR2: 000003010383a8d0 CR3: 0000000004872000 CR4: 00000000000006e0
> Sep  2 19:37:19 adams kernel: Process kswapd1 (pid: 62, threadinfo 00000101ffee0000, task 00000100d9ef33f0)
> Sep  2 19:37:19 adams kernel: Stack: 0000000300000000 000001010383a8c8 00000101ffee1db8 00000100d89cce50 
> Sep  2 19:37:19 adams kernel:        00000101ffee1e58 0000000000000001 00000101ffee1bd8 ffffffff80134a37 
> Sep  2 19:37:19 adams kernel:        0000000000000202 00000100d89cce50 
> Sep  2 19:37:19 adams kernel: Call Trace:<ffffffff80134a37>{__wake_up+39} <ffffffff80163834>{shrink_list+1124} 
> Sep  2 19:37:19 adams kernel:        <ffffffff80163bb4>{shrink_cache+628} <ffffffff801644e1>{shrink_zone+225} 
> Sep  2 19:37:19 adams kernel:        <ffffffff801648fd>{balance_pgdat+493} <ffffffff801365b0>{prepare_to_wait+80} 
> Sep  2 19:37:19 adams kernel:        <ffffffff80164afa>{kswapd+282} <ffffffff80136680>{autoremove_wake_function+0} 
> Sep  2 19:37:19 adams kernel:        <ffffffff80136680>{autoremove_wake_function+0} <ffffffff80132e31>{schedule_tail+17} 
> Sep  2 19:37:19 adams kernel:        <ffffffff80112587>{child_rip+8} <ffffffff8015de60>{pdflush+0} 
> Sep  2 19:37:19 adams kernel:        <ffffffff801649e0>{kswapd+0} <ffffffff8011257f>{child_rip+0} 
> Sep  2 19:37:19 adams kernel:        
> Sep  2 19:37:19 adams kernel: 
> Sep  2 19:37:19 adams kernel: Code: 4c 8b 20 74 30 66 66 90 48 8d 78 e8 8b 58 e8 4c 89 f9 8b 55 
> Sep  2 19:37:19 adams kernel: RIP <ffffffff801349c8>{__wake_up_common+40} RSP <00000101ffee1b88>
> Sep  2 19:37:19 adams kernel: CR2: 000003010383a8d0
> 

