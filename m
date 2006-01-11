Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751027AbWAKQMX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbWAKQMX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 11:12:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751026AbWAKQMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 11:12:23 -0500
Received: from gold.veritas.com ([143.127.12.110]:52528 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1750777AbWAKQMX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 11:12:23 -0500
Date: Wed, 11 Jan 2006 16:12:54 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Octavio Alvarez Piza <alvarezp@alvarezp.ods.org>
cc: Dave Jones <davej@redhat.com>, Arjan van de Ven <arjan@infradead.org>,
       Andrew Morton <akpm@osdl.org>, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: mm/rmap.c negative page map count BUG.
In-Reply-To: <20060111000111.5fa4bdce@octavio.alvarezp.pri>
Message-ID: <Pine.LNX.4.61.0601111603520.4337@goblin.wat.veritas.com>
References: <20060103082609.GB11738@redhat.com> <43BA630F.1020805@yahoo.com.au>
 <20060103135312.GB18060@redhat.com> <20060104155326.351a9c01.akpm@osdl.org>
 <20060105074718.GF20809@redhat.com> <1136448712.2920.4.camel@laptopd505.fenrus.org>
 <20060105111520.GL20809@redhat.com> <op.s2w4pyqm4oyyg1@octavio.tecbc.mx>
 <20060111000111.5fa4bdce@octavio.alvarezp.pri>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 11 Jan 2006 16:12:22.0905 (UTC) FILETIME=[CE1F8E90:01C616C9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jan 2006, Octavio Alvarez Piza wrote:
> On Thu, 05 Jan 2006 11:00:41 -0800
> "Octavio Alvarez" <alvarezp@alvarezp.ods.org> wrote:
> 
> I have found another instance of "bad_page_state" with mapcount:-1
> before hitting BUG_ON().
> 
> Bad page state at free_hot_cold_page (in process 'X', page c1140c60)
> flags:0x80010008 mapping:00000000 mapcount:-65536 count:0

No, that's mapcount -65536 not -1.

That means page->_mapcount contained 0xfffeffff when it should have
contained 0xffffffff.  A single bit got cleared.  Probably bad memory,
overheating, something of that kind.

> I ran memtest86+ for 24 hours prior to installing the latest kernel boot
> with no errors reported.

Well, you've done your best to rule out that possibility, yes.

We can't rule out that something somewhere in the kernel has
scribbled on that location, but I've no guesses what.

Hugh
