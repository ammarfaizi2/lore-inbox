Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750909AbVIBXdu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750909AbVIBXdu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 19:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbVIBXdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 19:33:50 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:37291 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750909AbVIBXdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 19:33:47 -0400
Subject: Re: [PATCH 2.6.13] lockless pagecache 2/7
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andi Kleen <ak@suse.de>, Linux Memory Management <linux-mm@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4318C28A.5010000@yahoo.com.au>
References: <4317F071.1070403@yahoo.com.au> <4317F0F9.1080602@yahoo.com.au>
	 <4317F136.4040601@yahoo.com.au>
	 <1125666486.30867.11.camel@localhost.localdomain>
	 <p73k6hzqk1w.fsf@verdi.suse.de>  <4318C28A.5010000@yahoo.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 03 Sep 2005 00:57:51 +0100
Message-Id: <1125705471.30867.40.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2005-09-03 at 07:22 +1000, Nick Piggin wrote:
> > Actually we have cmpxchg on i386 these days - we don't support
> > any SMP i386s so it's just done non atomically.
> 
> Yes, I guess that's what Alan must have meant.

Well I was thinking about things like pre-empt. Also the x86 cmpxchg()
is defined for non i386 processors to allow certain things to use it
(ACPI, DRM etc) which know they won't be on a 386. The implementation in
this case will blow up on a 386 and the __HAVE_ARCH_CMPXCHG remains
false.

> but I suspect that SMP isn't supported on those CPUs without ll/sc,
> and thus an atomic_cmpxchg could be emulated by disabling interrupts.

It's obviously emulatable on any platform - the question is at what
cost. For x86 it probably isn't a big problem as there are very very few
people who need to build for 386 any more and there is already a big
penalty for such chips.

