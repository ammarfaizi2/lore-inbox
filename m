Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265135AbTFMFLF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 01:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265136AbTFMFLF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 01:11:05 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:20746 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S265135AbTFMFLD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 01:11:03 -0400
Date: Thu, 12 Jun 2003 22:24:27 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: davidm@hpl.hp.com
cc: roland@redhat.com, <linux-kernel@vger.kernel.org>
Subject: Re: FIXMAP-related change to mm/memory.c
In-Reply-To: <200306130124.h5D1O2DT025311@napali.hpl.hp.com>
Message-ID: <Pine.LNX.4.44.0306122219580.2989-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 12 Jun 2003, David Mosberger wrote:
>
> Is it possible to constrain the FIXADDR range on x86/x86-64
> (FIXADDR_START-FIXADDR_TOP) such that the entire range is read-only by
> user-level?  If so, we could simplify the permission test like this:

Well, you could replace the uses of FIXADDR_START/FIXADDR_TOP with 
something like FIXADDR_USER_START/FIXADDR_USER_TOP, and then force those 
to cover only the _one_ user-accessible page.

Something like

	#define FIXADDR_USER_START (fix_to_virt(FIX_VSYSCALL))
	#define FIXADDR_USER_END (FIXADDR_USER_START + PAGE_SIZE)

should work. In that case you can drop the page table testing, since we 
"know" it is safe.

But I'm too lazy to test, so please send a tested patch,

		Linus

