Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267235AbUIJK3l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267235AbUIJK3l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 06:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267234AbUIJK3l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 06:29:41 -0400
Received: from the-village.bc.nu ([81.2.110.252]:62638 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267235AbUIJK3S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 06:29:18 -0400
Subject: Re: [PATCH 1/3] Separate IRQ-stacks from 4K-stacks option
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Chris Wedgwood <cw@f00f.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>
In-Reply-To: <20040909232532.GA13572@taniwha.stupidest.org>
References: <20040909232532.GA13572@taniwha.stupidest.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094808406.17029.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 10 Sep 2004 10:27:00 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-09-10 at 00:25, Chris Wedgwood wrote:
> Right now CONFIG_4KSTACKS implies IRQ-stacks.  Some people though
> really need 8K stacks and it would be nice to have IRQ-stacks for them
> too.

This is a lot of added code and complexity that does nothing. In
8K stack mode without IRQ stacks you already can only safely use 4K.
So any code that is broken in 4K stack mode is broken in the current
8K stack mode although it'll fail less often since the failure will
depend upon random IRQ/other timings.

8K + IRQ stacks is just making the stacks bigger (which is expensive)
and stressing the vm more. Fix the broken code instead, or just stop
supporting gcc 2.9x which will fix most of it for you

