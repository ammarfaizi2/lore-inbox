Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265728AbTL3KSD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 05:18:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265729AbTL3KSD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 05:18:03 -0500
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:28570
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP id S265728AbTL3KSB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 05:18:01 -0500
Subject: Re: [PATCH] optimize ia32 memmove
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       manfred@colorfullife.com,
       Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0312300152250.2065@home.osdl.org>
References: <200312300713.hBU7DGC4024213@hera.kernel.org>
	 <3FF129F9.7080703@pobox.com> <20031229235158.755e026c.akpm@osdl.org>
	 <3FF12FC7.5030202@pobox.com>
	 <Pine.LNX.4.58.0312300152250.2065@home.osdl.org>
Content-Type: text/plain
Message-Id: <1072779479.16344.95.camel@ixodes.goop.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 30 Dec 2003 02:17:59 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-12-30 at 01:58, Linus Torvalds wrote:
> But then anything that does the loads in ascending order is still ok, so
> it shouldn't matter - by the time "dest" has been overwritten, the source
> data has already been read. And all the "memcpy()"  implementations had
> better do that anyway, in order to get nice memory access patterns. "rep
> movsl" certainly does.

A PPC memcpy may end up clearing the destination before reading the
source (using the cache-line zeroing instruction, to prevent the
destination from being spuriously read to populate the cache line).

	J

