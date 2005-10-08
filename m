Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932167AbVJHQaL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbVJHQaL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 12:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbVJHQaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 12:30:10 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:31665 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S932167AbVJHQaJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 12:30:09 -0400
Message-ID: <4347F3DE.8070505@vc.cvut.cz>
Date: Sat, 08 Oct 2005 18:29:18 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.7.11) Gecko/20050914 Debian/1.7.11-1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc2-almost-rc3, ext3 and memory corruption
References: <20051001030027.GA8784@vana.vc.cvut.cz>
In-Reply-To: <20051001030027.GA8784@vana.vc.cvut.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Vandrovec wrote:
> Hello,
>   I was so happy that 2.6.13-rc3 was released that I tried to grab it,
> and while I was doing that, box said:
> 
> Slab corruption: start=ffff8100005e5bf8, len=96
> Redzone: 0x5a2cf071/0x5a2cf071.
> Last user: [<ffffffff801ec42d>](journal_remove_journal_head+0x6d/0xb0)
> 000: 6b 6b 6b 6b 6b 6b 6b 6b 01 00 00 00 6b 6b 6b 6b
> Prev obj: start=ffff8100005e5b80, len=96
> Redzone: 0x5a2cf071/0x5a2cf071.
> Last user: [<ffffffff801ec42d>](journal_remove_journal_head+0x6d/0xb0)
> 000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> 010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> Next obj: start=ffff8100005e5c70, len=96
> Redzone: 0x5a2cf071/0x5a2cf071.
> Last user: [<ffffffff801ec42d>](journal_remove_journal_head+0x6d/0xb0)
> 000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> 010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b

Hello,
   so I've enabled JBD-DEBUG, and unfortunately somebody corrupted inode instead 
of journal head this time :-(  But corruption looks same - somebody wrote 32bit 
value 1 somewhere it should not...  Does anybody have something like 
CONFIG_DEBUG_PAGE_ALLOC for x86-64?

Slab corruption: start=ffff8100005e7c00, len=976
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<ffffffff801aa690>](destroy_inode+0x30/0x50)
080: 01 00 00 00 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Prev obj: start=ffff8100005e7818, len=976
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<ffffffff801aa690>](destroy_inode+0x30/0x50)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
ppc:~$ uname -a
Linux ppc 2.6.14-rc3-dd72 #1 SMP PREEMPT Tue Oct 4 21:12:16 CEST 2005 x86_64 
GNU/Linux
ppc:~$

This time I was not doing anything special, just building new kernel & browsing web.
						Thanks,
							Petr Vandrovec

> Box in question has single Athlon64 processor, runs SMP PREEMPT kernel
> with almost all debugging options set (but not CONFIG_JBD_DEBUG).  Box 
> has 2GB of ECC RAM.  Root filesystem is on pata disk connected to the 
> pata port on Promise's 20378 (using sata_promise).  Disk with git repository 
> is plugged to pata port on Via's VT8237.  Kernel's configuration is 
> at http://platan.vc.cvut.cz/vana_at_home_config.txt, dmesg at 
> http://platan.vc.cvut.cz/vana_at_home_dmesg.txt.


