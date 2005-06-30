Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262861AbVF3GC7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262861AbVF3GC7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 02:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262858AbVF3GC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 02:02:59 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:28394 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262861AbVF3GCh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 02:02:37 -0400
Date: Thu, 30 Jun 2005 02:02:06 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
Reply-To: rostedt@goodmis.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Arjan van de Ven <arjan@infradead.org>, Denis Vlasenko <vda@ilport.com.ua>,
       Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: kmalloc without GFP_xxx?
In-Reply-To: <1120093373.31924.39.camel@gaston>
Message-ID: <Pine.LNX.4.58.0506300158100.14989@localhost.localdomain>
References: <200506291402.18064.vda@ilport.com.ua> 
 <1120043739.3196.32.camel@laptopd505.fenrus.org>  <200506291420.09956.vda@ilport.com.ua>
  <1120045024.3196.34.camel@laptopd505.fenrus.org> 
 <Pine.LNX.4.58.0506290927370.22775@localhost.localdomain>
 <1120093373.31924.39.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 30 Jun 2005, Benjamin Herrenschmidt wrote:

>
> There are cases where using spin_lock instead of _irqsave version is a
> matter of correctness. For example, the page table lock beeing always
> taking without _irq is important to let the IPIs flow.
>

There's always exceptions! ;-)

As Jörn mentioned, you don't just use spin_lock_irqsave just to keep from
thinking, which I totally agree, but most of the time I use spin_locks, it
is better to not let interrupts flow, and for this reason, I try to keep
the places that use spin_locks as short as possible, since I don't want
100ms latencies.

-- Steve

