Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbTJHXoc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 19:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbTJHXoc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 19:44:32 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:50314 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261744AbTJHXoa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 19:44:30 -0400
Date: Thu, 9 Oct 2003 00:43:40 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: vatsa@in.ibm.com, Dave Jones <davej@redhat.com>,
       lkcd-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
Subject: Re: [PATCH] Poll-based IDE driver
Message-ID: <20031008234340.GB17019@mail.shareable.org>
References: <20030917144120.A11425@in.ibm.com> <1063806900.12279.47.camel@dhcp23.swansea.linux.org.uk> <20031008151357.A31976@in.ibm.com> <20031008115051.GD705@redhat.com> <20031008174458.A32517@in.ibm.com> <1065649708.10565.23.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1065649708.10565.23.camel@dhcp23.swansea.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Mer, 2003-10-08 at 13:14, Srivatsa Vaddagiri wrote:
> > Since my code is supposed to run when system is crashing, I would like 
> > to avoid calling any function in the kernel as far as possible, since 
> > the kernel and its data structures may be in a inconsistent state 
> > and/or corrupted.
> 
> For x86 udelay is a tiny piece of code - you could easily inline it

No, because that changes the delay.  Things like whether the
instructions straddle a cache line or page boundary, or ar 4-byte or
16-byte aligned affect the timing on some x86 CPUs.

udelay must reside at a fixed memory location to get the nearest thing
to determinism that we know how to get.

-- Jamie
