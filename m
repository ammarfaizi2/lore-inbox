Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932293AbVKKAz2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293AbVKKAz2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 19:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932294AbVKKAz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 19:55:28 -0500
Received: from ozlabs.org ([203.10.76.45]:15293 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932293AbVKKAz2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 19:55:28 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17267.60410.120520.63951@cargo.ozlabs.ibm.com>
Date: Fri, 11 Nov 2005 11:55:22 +1100
From: Paul Mackerras <paulus@samba.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH,RFC 2.6.14 11/15] KGDB: ppc64-specific changes
In-Reply-To: <20051110164409.20950.43161.sendpatchset@localhost.localdomain>
References: <20051110163906.20950.45704.sendpatchset@localhost.localdomain>
	<20051110164409.20950.43161.sendpatchset@localhost.localdomain>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini writes:

> This adds basic KGDB support to ppc64, and support for kgdb8250 on the 'Maple'
> board.  All of this was done by Frank Rowand (who is on vacation right now,
> but I'll try and answer for him).  This should work on any ppc64 board via
> kgdboe, so long as there is an eth driver that supports netpoll.  At the
> moment this is mutually exclusive with XMON.  It is probably possible to allow
> them to be chained, but that sounds dangerous to me.  This is similar to
> ppc32, but ppc32 does not explicitly test.

We already have infrastructure to allow either xmon or kdb to be used,
and in fact both can be built in and you can select at runtime which
you prefer.  See the __debugger stuff in system.h.  You should just be
able to hook kgdb into that same infrastructure.  We're also planning
to move to using the die_notify stuff for getting all the significant
events to the debugger.

Paul.
