Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932142AbWB1RN5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142AbWB1RN5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 12:13:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932171AbWB1RN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 12:13:56 -0500
Received: from detroit.securenet-server.net ([209.51.153.26]:30101 "EHLO
	detroit.securenet-server.net") by vger.kernel.org with ESMTP
	id S932142AbWB1RN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 12:13:56 -0500
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Roland Dreier <rdreier@cisco.com>
Subject: Re: [PATCH] Define wc_wmb, a write barrier for PCI write combining
Date: Tue, 28 Feb 2006 09:13:41 -0800
User-Agent: KMail/1.9.1
Cc: Jes Sorensen <jes@sgi.com>, "Bryan O'Sullivan" <bos@pathscale.com>,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <1140841250.2587.33.camel@localhost.localdomain> <44047565.3090202@sgi.com> <adafym3l8lk.fsf@cisco.com>
In-Reply-To: <adafym3l8lk.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602280913.41938.jbarnes@virtuousgeek.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - detroit.securenet-server.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - virtuousgeek.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, February 28, 2006 9:02 am, Roland Dreier wrote:
>     Jes> Not quite correct as far as I understand it. mmiowb() is
>     Jes> supposed to guarantee that writes to MMIO space have
>     Jes> completed before continuing.  That of course covers the
>     Jes> multi-CPU case, but it should also cover the write-combining
>     Jes> case.
>
> I don't believe this is correct.  mmiowb() does not guarantee that
> writes have completed -- they may still be pending in a buffer in a
> bridge somewhere.  The _only_ effect of mmiowb() is to make sure that
> writes which have been ordered between CPUs using some other mechanism
> (i.e. a lock) are properly ordered by the rest of the system.  This
> only has an effect systems like very large ia64 systems, where (as I
> understand it), writes can pass each other on the way to the PCI bus.
> In fact, mmiowb() is a NOP on essentially every architecture.

I think it could be implemented meaningfully on ppc64, mips64, and 
perhaps some parisc systems, but I don't think their respective 
maintainers have gotten around to that yet.

Anyway, it looks like the write combine ordering Bryan is talking about 
really is a distinct semantic.  Not sure if it's possible (or desirable) 
to overload an existing barrier op to include the semantics he wants.

Jesse
