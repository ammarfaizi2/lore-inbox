Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318202AbSGQC6Z>; Tue, 16 Jul 2002 22:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318203AbSGQC6Y>; Tue, 16 Jul 2002 22:58:24 -0400
Received: from mail.eskimo.com ([204.122.16.4]:13578 "EHLO mail.eskimo.com")
	by vger.kernel.org with ESMTP id <S318202AbSGQC6X>;
	Tue, 16 Jul 2002 22:58:23 -0400
Date: Tue, 16 Jul 2002 20:00:43 -0700
To: Thunder from the hill <thunder@ngforever.de>
Cc: Elladan <elladan@eskimo.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Zack Weinberg <zack@codesourcery.com>, linux-kernel@vger.kernel.org
Subject: Re: close return value (was Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks)
Message-ID: <20020717030043.GA31110@eskimo.com>
References: <20020717022252.GA30570@eskimo.com> <Pine.LNX.4.44.0207162054050.3452-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207162054050.3452-100000@hawkeye.luckynet.adm>
User-Agent: Mutt/1.3.28i
From: Elladan <elladan@eskimo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2002 at 08:54:54PM -0600, Thunder from the hill wrote:
> Hi,
> 
> On Tue, 16 Jul 2002, Elladan wrote:
> > Two threads share the file descriptor table.  
> > 
> >   1. Thread 1 performs close() on a file descriptor.  close fails.
> >   2. Thread 2 performs open().
> > * 3. Thread 1 performs close() again, just to make sure.
> 
> Thread 2 shouldn't be able to reuse a currently open fd. This application 
> design is seriously broken.

No.

Thread 2 doesn't manage the file descriptor table, the kernel does.
Whether the kernel may re-use the descriptor or not depends on whether
the descriptor is closed or not.  The kernel knows, but unless close()
behaves in a defined way, the application does not at this point.  Thus,
step 3 may either be required, forbidden, or undefined.

-J
