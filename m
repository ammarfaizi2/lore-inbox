Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbVKSAbq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbVKSAbq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 19:31:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbVKSAbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 19:31:46 -0500
Received: from webbox4.loswebos.de ([213.187.93.205]:60364 "EHLO
	webbox4.loswebos.de") by vger.kernel.org with ESMTP
	id S1750806AbVKSAbq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 19:31:46 -0500
Date: Sat, 19 Nov 2005 01:31:47 +0100
From: Marc Koschewski <marc@osknowledge.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: Marc Koschewski <marc@osknowledge.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc1-mm2 unsusable on DELL Inspiron 8200, 2.6.15-rc1 works fine
Message-ID: <20051119003147.GA6603@stiffy.osknowledge.org>
References: <20051118182910.GJ6640@stiffy.osknowledge.org> <Pine.LNX.4.61.0511181916130.2946@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <Pine.LNX.4.61.0511181916130.2946@goblin.wat.veritas.com>
X-PGP-Fingerprint: D514 7DC1 B5F5 8989 083E  38C9 5ECF E5BD 3430 ABF5
X-PGP-Key: http://www.osknowledge.org/~marc/pubkey.asc
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Hugh Dickins <hugh@veritas.com> [2005-11-18 19:28:09 +0000]:

> On Fri, 18 Nov 2005, Marc Koschewski wrote:
> > 
> > I didn't manage to read all the archive yet
> 
> That should only keep you busy for a year or two!
> 
> > and I'm new to the list
> > anyways. I wanted to report that 2.6.15-rc1-mm2 is unusable in an X
> > enviroment due to the mouse pointer hanging, jumping or not even working
> > at all. The behaviour occurs randomly.
> 
> Many thanks for the report.  It looks from the messages at the end as
> if this is a manifestation of my PageReserved "Bad page states" that
> 2.6.15-rc1-mm2 was particularly put out to check for.
> 
> Unfortunately your logging system is cutting out the most important info
> (perhaps because that's marked KERN_EMERG and the stack trace is not):
> I get lost in these logging setups myself so can't tell you what to do
> to correct it: but maybe running "dmesg" will give the full output.
> 
> However, I've got four other reporters (though you're the first to
> mention the mouse), and hope to be able to work it out from their info,
> so don't worry if you can't track down the full Bad page state messages.
> 
> Thanks,
> Hugh

Hi Hugh,

I'm glad the report was at least a little useful. To be 'more precise':
I ran dmesg at the time all the stuff appeared in any console I had open
at that time. In between the enormous amount of lines of data the kernel
told me something about 'reboot needed' as well as the kernel tries to
cleanup something. Maybe that helps you, too. I just grep'ing the sources
to locate the printk() spiting the messages... 

I located the message at mm/page_alloc.c:149 in bad_page(), just as you
told. ;)

HTH,
	Marc

> 
> > Nov 18 13:05:12 stiffy kernel:  [bad_page+134/318] bad_page+0x86/0x13e
> > Nov 18 13:05:12 stiffy kernel:  [free_hot_cold_page+66/285] free_hot_cold_page+0x42/0x11d
> > Nov 18 13:05:13 stiffy kernel:  [do_gettimeofday+20/188] do_gettimeofday+0x14/0xbc
> > Nov 18 13:05:13 stiffy kernel:  [zap_pte_range+305/719] zap_pte_range+0x131/0x2cf
> > Nov 18 13:05:13 stiffy kernel:  [unmap_page_range+236/273] unmap_page_range+0xec/0x111
> > Nov 18 13:05:13 stiffy kernel:  [unmap_vmas+193/476] unmap_vmas+0xc1/0x1dc
> > Nov 18 13:05:13 stiffy kernel:  [unmap_region+150/289] unmap_region+0x96/0x121
> > Nov 18 13:05:13 stiffy kernel:  [do_munmap+235/300] do_munmap+0xeb/0x12c
> > Nov 18 13:05:13 stiffy kernel:  [sys_munmap+62/88] sys_munmap+0x3e/0x58
> > Nov 18 13:05:13 stiffy kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
> > Nov 18 13:05:14 stiffy kernel:  [bad_page+134/318] bad_page+0x86/0x13e
> > Nov 18 13:05:14 stiffy kernel:  [free_hot_cold_page+66/285] free_hot_cold_page+0x42/0x11d
> > ....
> 
