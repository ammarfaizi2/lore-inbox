Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932614AbWAKIn7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932614AbWAKIn7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 03:43:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932626AbWAKIn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 03:43:58 -0500
Received: from [200.77.213.249] ([200.77.213.249]:20973 "EHLO
	cmas-tj.cablemas.com") by vger.kernel.org with ESMTP
	id S932614AbWAKIn5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 03:43:57 -0500
X-Mail-Scanner: Scanned by qSheff 0.8-p3 against viruses and spams (http://www.enderunix.org/qsheff/)
Date: Wed, 11 Jan 2006 00:01:11 -0800
From: Octavio Alvarez Piza <alvarezp@alvarezp.ods.org>
To: "Octavio Alvarez" <alvarezp@alvarezp.ods.org>
Cc: "Dave Jones" <davej@redhat.com>, "Arjan van de Ven" <arjan@infradead.org>,
       "Andrew Morton" <akpm@osdl.org>, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: mm/rmap.c negative page map count BUG.
Message-ID: <20060111000111.5fa4bdce@octavio.alvarezp.pri>
In-Reply-To: <op.s2w4pyqm4oyyg1@octavio.tecbc.mx>
References: <20060103082609.GB11738@redhat.com>
	<43BA630F.1020805@yahoo.com.au>
	<20060103135312.GB18060@redhat.com>
	<20060104155326.351a9c01.akpm@osdl.org>
	<20060105074718.GF20809@redhat.com>
	<1136448712.2920.4.camel@laptopd505.fenrus.org>
	<20060105111520.GL20809@redhat.com>
	<op.s2w4pyqm4oyyg1@octavio.tecbc.mx>
Organization: (None)
X-Mailer: Sylpheed-Claws 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Jan 2006 11:00:41 -0800
"Octavio Alvarez" <alvarezp@alvarezp.ods.org> wrote:

> On Thu, 05 Jan 2006 03:15:20 -0800, Dave Jones <davej@redhat.com>
wrote:
> 
> > On Thu, Jan 05, 2006 at 09:11:51AM +0100, Arjan van de Ven wrote:
> >  >
> >  > > Quite a few Fedora users have hit it over the last year,
> >  > > but what I find fascinating is that there's not a single
> >  > > occurance of "BUG at mm/rmap.c" in our 2.6.9 based RHEL4 bug  
> > reports.
> >  >
> >  > could mean it's caused by consumer hardware code...
> >
> > Yeah. People buying enterprise distros do tend to buy branded RAM
> > with goodies like ECC from big name suppliers instead of a cheap $20
> > noname DIMM from "Joe's computers".
> >
> > So it *could* be a lot of these are crappy hardware, especially
> > as some of the reports do indicate that the problem went away
> > when they upgraded their RAM.  Some of the others though, I'm
> > not so sure.
> 
> Nevertheless, there are more instances of the bug in recent versions.
> For me, version 2.6.10 or 2.6.11 seems to be the big difference, from
> 1 bug monthly to --suddenly-- 4 weekly.
> 
> I'm experiecing that problem too. I have notice that sometimes
> "bad_page_state" trigger before the BUG is reported.
> 
> http://lkml.org/lkml/2005/12/14/449
> 
> I have already installed the instrumentation Dave provided. I'll see
how
> it goes.

I have found another instance of "bad_page_state" with mapcount:-1
before
hitting BUG_ON().

sh-3.00$ cat /var/log/kernel | tail -n 19
Bad page state at free_hot_cold_page (in process 'X', page c1140c60)
flags:0x80010008 mapping:00000000
mapcount:-65536 count:0
Backtrace:
 [<c012eee2>] bad_page+0x5c/0x92
 [<c012f56c>] free_hot_cold_page+0x58/0xc2
 [<c012fbb6>] __pagevec_free+0x17/0x1d
 [<c0133e28>] __pagevec_release_nonlru+0x72/0x7f
 [<c0134c04>] shrink_list+0x2ef/0x386
 [<c0134e23>] shrink_cache+0xe7/0x210
 [<c0135323>] shrink_zone+0xac/0xc4
 [<c0135389>] shrink_caches+0x4e/0x5b
 [<c0135466>] try_to_free_pages+0xd0/0x190
 [<c012fa0a>] __alloc_pages+0x170/0x271
 [<c01382ca>] do_anonymous_page+0x37/0x107
 [<c013865c>] __handle_mm_fault+0xa6/0x15e
 [<c02a4cf4>] do_page_fault+0x188/0x545
 [<c02a4b6c>] do_page_fault+0x0/0x545
 [<c0102c9f>] error_code+0x4f/0x54
Trying to fix it up, but a reboot is needed

sh-3.00$ uptime
 23:56:29 up 1 day,  2:45,  4 users,  load average: 1.22, 1.16, 1.12

sh-3.00$ uname -a
Linux octavio 2.6.15 #13 Sat Jan 7 17:37:22 PST 2006 i686 unknown
unknown GNU/Linux

I ran memtest86+ for 24 hours prior to installing the latest kernel boot
with no errors reported.
