Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753335AbWKGUwm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753335AbWKGUwm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 15:52:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753334AbWKGUwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 15:52:41 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:63453
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1753255AbWKGUwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 15:52:40 -0500
Date: Tue, 07 Nov 2006 12:52:41 -0800 (PST)
Message-Id: <20061107.125241.39157521.davem@davemloft.net>
To: akpm@osdl.org
Cc: jeff@garzik.org, johnpol@2ka.mipt.ru, drepper@redhat.com,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [take21 0/4] kevent: Generic event handling mechanism.
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061107113400.880e1ce9.akpm@osdl.org>
References: <20061107115111.GA13028@2ka.mipt.ru>
	<45507CD4.5030600@garzik.org>
	<20061107113400.880e1ce9.akpm@osdl.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>
Date: Tue, 7 Nov 2006 11:34:00 -0800

> What Evgeniy means here is that copy_to_user() is slower than memcpy() (on
> his machine, with his kernel config, at least).
> 
> Which is kinda weird and unexpected and is something which we should
> investigate independently from this project.  (Rather than simply going
> and bypassing it!)

It's straightforward to me. :-)

If the kerne memcpy()'s, it uses those nice 4MB PTE mappings to
the kernel pages.  With copy_to_user() you run through tiny
4K or 8K PTE mappings which thrash the TLB.

The TLB is therefore able to hold more of the accessed state at
a time if you touch the pages on the kernel side.
