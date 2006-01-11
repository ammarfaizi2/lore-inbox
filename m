Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751689AbWAKRZF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751689AbWAKRZF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 12:25:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751692AbWAKRZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 12:25:04 -0500
Received: from smtp.osdl.org ([65.172.181.4]:64130 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751689AbWAKRZC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 12:25:02 -0500
Date: Wed, 11 Jan 2006 09:24:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: Octavio Alvarez Piza <alvarezp@alvarezp.ods.org>
Cc: hugh@veritas.com, davej@redhat.com, arjan@infradead.org,
       nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
Subject: Re: mm/rmap.c negative page map count BUG.
Message-Id: <20060111092428.358b2443.akpm@osdl.org>
In-Reply-To: <20060111085843.1d79e045@octavio.alvarezp.pri>
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
	<20060111085843.1d79e045@octavio.alvarezp.pri>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Octavio Alvarez Piza <alvarezp@alvarezp.ods.org> wrote:
>
> > That means page->_mapcount contained 0xfffeffff when it should have
>  > contained 0xffffffff.  A single bit got cleared.  Probably bad memory,
>  > overheating, something of that kind.
> 
>  BTW, what's the first 8 in flags:0x80010008? I can't find 1<<31 in
>  include/linux/page-flags.h

That's the page's zone identifier.  We stuff that into the high bits of
page->flags for page_zone().
