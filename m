Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262884AbVAQVbW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262884AbVAQVbW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 16:31:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262891AbVAQVbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 16:31:22 -0500
Received: from smtp.hickorytech.net ([216.114.192.16]:4237 "EHLO
	avalanche.hickorytech.net") by vger.kernel.org with ESMTP
	id S262884AbVAQVae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 16:30:34 -0500
Message-ID: <41EC2ECF.6010701@mnsu.edu>
Date: Mon, 17 Jan 2005 15:31:59 -0600
From: Jeffrey Hundstad <jeffrey.hundstad@mnsu.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a6) Gecko/20050111
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jakob Oestergaard <jakob@unthought.net>
Cc: Christoph Hellwig <hch@infradead.org>, David Greaves <david@dgreaves.com>,
       Jan Kasprzak <kas@fi.muni.cz>, linux-kernel@vger.kernel.org,
       kruty@fi.muni.cz
Subject: journaled filesystems -- known instability; Was: XFS: inode with
 st_mode == 0
References: <20041209125918.GO9994@fi.muni.cz> <20041209135322.GK347@unthought.net> <20041209215414.GA21503@infradead.org> <20041221184304.GF16913@fi.muni.cz> <20041222084158.GG347@unthought.net> <20041222182344.GB14586@infradead.org> <41E80C1F.3070905@dgreaves.com> <20050114182308.GE347@unthought.net> <20050116135112.GA24814@infradead.org> <20050117100746.GI347@unthought.net>
In-Reply-To: <20050117100746.GI347@unthought.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For more of this look up subjects:
  Bad things happening to journaled filesystem machines
  Oops in kjournald
and from author:
  Anders Saaby

I also can't keep a recent 2.6 or 2.6*-ac* kernel up more than a few 
hours on a machine under real load.   Perhaps us folks with the problem 
need to talk to the powers who be to come up with a strategy to make a 
report they can use.  My guess is we're not sending something that can 
be used.

-- 
jeffrey hundstad


Jakob Oestergaard wrote:

>On Sun, Jan 16, 2005 at 01:51:12PM +0000, Christoph Hellwig wrote:
>  
>
>>On Fri, Jan 14, 2005 at 07:23:09PM +0100, Jakob Oestergaard wrote:
>>    
>>
>>>So apart from the general well known instability problems that will
>>>occur when you actually start *using* the system, there should be no
>>>      
>>>
>>What known instabilities?
>>    
>>
>
>Where should I begin?  ;)
>
>Most of the following have already been posted to LKML - primarily by
>Anders (as@cohaesio.com) - it seems that noone cares, but I'll repost a
>summary that Anders sent me below:
>
>-------
>Scenario 1: Mailservers:
>  2.6.10 (~24-40 hours uptime):
>  Running ext3 on mailqueue:
>
><SNIP>
>Unable to handle kernel NULL pointer dereference at virtual address 00000004
>printing eip:
>c018a095
>*pde = 00000000
>Oops: 0002 [#1]
>SMP
>Modules linked in: nfs e1000 iptable_nat ipt_connlimit rtc
>CPU:    2
>EIP:    0060:[<c018a095>]    Not tainted
>EFLAGS: 00010286   (2.6.8.1)
>EIP is at journal_commit_transaction+0x535/0x10e5
>eax: cac1e26c   ebx: 00000000   ecx: f7cec400   edx: f7cec400
>esi: f65f3000   edi: cac1e26c   ebp: f65f3000   esp: f65f3dc0
>ds: 007b   es: 007b   ss: 0068
>Process kjournald (pid: 174, threadinfo=f65f3000 task=c2308b70)
>Stack: f65f3e64 00000000 00000000 00000000 00000000 00000000 f7cec400 cda565fc
>       0000149a 00000004 f65f3e48 c01132d8 00000002 c202ad20 00000001 f65f3e5c
>       c202ad20 c202ad20 00000002 00000001 0000001e 01c1af60 f65f3e68 c0407dc0
>Call Trace:
> [<c01132d8>] scheduler_tick+0x468/0x470
> [<c01127b5>] find_busiest_group+0x105/0x310
> [<c011db8e>] del_timer_sync+0x7e/0xa0
> [<c018cd4d>] kjournald+0xbd/0x230
> [<c0114b10>] autoremove_wake_function+0x0/0x40
> [<c0114b10>] autoremove_wake_function+0x0/0x40
> [<c0103f16>] ret_from_fork+0x6/0x14
> [<c018cc70>] commit_timeout+0x0/0x10
> [<c018cc90>] kjournald+0x0/0x230
> [<c01024bd>] kernel_thread_helper+0x5/0x18
>Code: f0 ff 43 04 8b 03 83 e0 04 74 4c 8b 8c 24 b8 01 00 00 c6 81
> <2>SoftDog: Initiating system reboot
></SNIP>
>
>-------
>Scenario 2: Mailservers:
>  Running XFS on mailqueue:
>
><SNIP>
>Filesystem "sdb1": xfs_trans_delete_ail: attempting to delete a log item that 
>is not in the AIL
>xfs_force_shutdown(sdb1,0x8) called from line 382 of file 
>fs/xfs/xfs_trans_ail.c.  Return address = 0xc0216a56
>@Linux version 2.6.9 (root@mail1.domain.tld) (gcc version 2.96 20000731 (Red 
>Hat Linux 7.3 2.96-113)) #1 SMP Tue Oct 19 16:04:55 CEST 2004
></SNIP>
>
>
>=======
>Resolution to the mailserver problem:
> 2.4.28 is perfectly stable on these machines.
>
>-------
>Scenario 3: Webservers:
>
>  2.6.10, 2.6.10-ac8 (~3-12 hours uptime):
>
>    <SNIP>
>    Unable to handle kernel paging request
>    <2>SoftDog: Initiating system reboot.
>    <SNIP>
>    (No more...) :(
>
>=======
>Resolution to the webserver problem:
> 2.4.28/2.4.29-rc2 are stable here
>
>-------
>Scenario 4: Storageservers: 
>  2.6.8.1:
>    Oopses after ~5-10 hours whith SMP on. - Cannot find the actual Oopses 
>anymore and 2.6.8+ havent been tested as we cannot afford anymore downtime on 
>these servers.
>
>
>=======
>Resolution to the storage server problem:
> 2.6.8.1 UP is stable (but oopses regularly after memory allocation
> failures)
>
>
>
>Hardware on all servers: IBM x335 and x345.
>
>Mentioned errors seen on a total of 17 servers.
>
>  
>
