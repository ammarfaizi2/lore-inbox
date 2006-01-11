Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751182AbWAKRDx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbWAKRDx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 12:03:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbWAKRDx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 12:03:53 -0500
Received: from [200.77.213.249] ([200.77.213.249]:64685 "EHLO
	cmas-tj.cablemas.com") by vger.kernel.org with ESMTP
	id S1751182AbWAKRDw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 12:03:52 -0500
X-Mail-Scanner: Scanned by qSheff 0.8-p3 against viruses and spams (http://www.enderunix.org/qsheff/)
Date: Wed, 11 Jan 2006 08:58:43 -0800
From: Octavio Alvarez Piza <alvarezp@alvarezp.ods.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: Dave Jones <davej@redhat.com>, Arjan van de Ven <arjan@infradead.org>,
       Andrew Morton <akpm@osdl.org>, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: mm/rmap.c negative page map count BUG.
Message-ID: <20060111085843.1d79e045@octavio.alvarezp.pri>
In-Reply-To: <Pine.LNX.4.61.0601111603520.4337@goblin.wat.veritas.com>
References: <20060103082609.GB11738@redhat.com>
	<43BA630F.1020805@yahoo.com.au>
	<20060103135312.GB18060@redhat.com>
	<20060104155326.351a9c01.akpm@osdl.org>
	<20060105074718.GF20809@redhat.com>
	<1136448712.2920.4.camel@laptopd505.fenrus.org>
	<20060105111520.GL20809@redhat.com>
	<op.s2w4pyqm4oyyg1@octavio.tecbc.mx>
	<20060111000111.5fa4bdce@octavio.alvarezp.pri>
	<Pine.LNX.4.61.0601111603520.4337@goblin.wat.veritas.com>
Organization: (None)
X-Mailer: Sylpheed-Claws 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jan 2006 16:12:54 +0000 (GMT)
Hugh Dickins <hugh@veritas.com> wrote:

> On Wed, 11 Jan 2006, Octavio Alvarez Piza wrote:
> > On Thu, 05 Jan 2006 11:00:41 -0800
> > "Octavio Alvarez" <alvarezp@alvarezp.ods.org> wrote:
> > 
> > I have found another instance of "bad_page_state" with mapcount:-1
> > before hitting BUG_ON().
> > 
> > Bad page state at free_hot_cold_page (in process 'X', page c1140c60)
> > flags:0x80010008 mapping:00000000 mapcount:-65536 count:0
> 
> No, that's mapcount -65536 not -1.
> 

That's right, this might be a different issue. Now that it was X and not
"kswap0d" and that Arjan has asked me, I've realized that I'm using the
binary nVidia driver. I had gotten pretty much the same issue with the
open driver, though. Still, since I changed kernels to 2.6.15, I'll try
again to catch the bad page state with the nv free driver.
 
> That means page->_mapcount contained 0xfffeffff when it should have
> contained 0xffffffff.  A single bit got cleared.  Probably bad memory,
> overheating, something of that kind.

BTW, what's the first 8 in flags:0x80010008? I can't find 1<<31 in
include/linux/page-flags.h

Octavio.
