Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751517AbWHWJ6c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751517AbWHWJ6c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 05:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751514AbWHWJ6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 05:58:32 -0400
Received: from cantor2.suse.de ([195.135.220.15]:9942 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751502AbWHWJ6b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 05:58:31 -0400
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Jari Sundell <sundell.software@gmail.com>,
       David Miller <davem@davemloft.net>, kuznet@ms2.inr.ac.ru,
       nmiell@comcast.net, linux-kernel@vger.kernel.org, drepper@redhat.com,
       netdev@vger.kernel.org, zach.brown@oracle.com, hch@infradead.org
Subject: Re: [take12 0/3] kevent: Generic event handling mechanism.
References: <b3f268590608221551q5e6a1057hd1474ee8b9811f10@mail.gmail.com>
	<20060822231129.GA18296@ms2.inr.ac.ru>
	<b3f268590608221728r6cffd03i2f2dd12421b9f37@mail.gmail.com>
	<20060822.173200.126578369.davem@davemloft.net>
	<b3f268590608221743o493080d0t41349bc4336bdd0b@mail.gmail.com>
	<20060823065659.GC24787@2ka.mipt.ru>
	<20060823000758.5ebed7dd.akpm@osdl.org>
	<20060823071002.GA16400@2ka.mipt.ru>
From: Andi Kleen <ak@suse.de>
Date: 23 Aug 2006 11:58:20 +0200
In-Reply-To: <20060823071002.GA16400@2ka.mipt.ru>
Message-ID: <p73pser7ozn.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov <johnpol@2ka.mipt.ru> writes:
> 
> Let's then place there a structure with 64bit seconds and nanoseconds,
> similar to timspec, but without longs there.

You need 64bit (or at least more than 32bit) for the seconds,
otherwise you add a y2038 problem which would be sad in new code.
Remember you might be still alive then ;-)

Ok one could argue that on 32bit architectures 2038 is so deeply
embedded that it doesn't make much difference, but I still
think it would be better to not readd it to new interfaces there.

64bit longs on 32bit is fine, as long as you use aligned_u64,
never long long or u64 (which has varying alignment between i386 and x86-64)

-Andi
