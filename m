Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751884AbWB1RME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751884AbWB1RME (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 12:12:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751891AbWB1RMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 12:12:03 -0500
Received: from detroit.securenet-server.net ([209.51.153.26]:42132 "EHLO
	detroit.securenet-server.net") by vger.kernel.org with ESMTP
	id S1751884AbWB1RL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 12:11:58 -0500
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Jes Sorensen <jes@sgi.com>
Subject: Re: [PATCH] Define wc_wmb, a write barrier for PCI write combining
Date: Tue, 28 Feb 2006 09:11:36 -0800
User-Agent: KMail/1.9.1
Cc: Roland Dreier <rdreier@cisco.com>, "Bryan O'Sullivan" <bos@pathscale.com>,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <1140841250.2587.33.camel@localhost.localdomain> <adar75nlcar.fsf@cisco.com> <44047565.3090202@sgi.com>
In-Reply-To: <44047565.3090202@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602280911.36970.jbarnes@virtuousgeek.org>
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

On Tuesday, February 28, 2006 8:08 am, Jes Sorensen wrote:
> Roland Dreier wrote:
> >     Jes> Could you explain why the current mmiowb() API won't
> > suffice Jes> for this?  It seems that this is basically trying to
> > achieve Jes> the same thing.
> >
> > I don't believe mmiowb() is at all the same thing.  mmiowb() is all
> > about ordering writes between _different_ CPUs without incurring the
> > cost of flushing posted writes by issuing a read on the bus.
>
> Not quite correct as far as I understand it. mmiowb() is supposed to
> guarantee that writes to MMIO space have completed before continuing.
> That of course covers the multi-CPU case, but it should also cover the
> write-combining case.

It only guarantees that any outstanding writes will hit the device before 
any subsequent writes.  mmiowb() doesn't make any guarantees about when 
the data will actually arrive at the device though.

> I wary of adding yet another variation unless there is a clear
> distinction between them that is easy to understandn for driver
> authors.

I think that's a valid concern, there are so many ill-understood barriers 
floating around; adding another one will create even more confusion.  
Are they all documented somewhere?  Are we sure that we don't have 
duplicates?

At any rate, any new ones we add should be very well documented (I think 
Andi suggested this implicitly when he asked for the semantics to be 
well-defined).

Jesse
