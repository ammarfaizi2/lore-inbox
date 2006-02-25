Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932678AbWBYRqv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932678AbWBYRqv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 12:46:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932680AbWBYRqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 12:46:51 -0500
Received: from kanga.kvack.org ([66.96.29.28]:45501 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S932678AbWBYRqu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 12:46:50 -0500
Date: Sat, 25 Feb 2006 12:41:34 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Define wc_wmb, a write barrier for PCI write combining
Message-ID: <20060225174134.GA18291@kvack.org>
References: <1140841250.2587.33.camel@localhost.localdomain> <20060225142814.GB17844@kvack.org> <1140887517.9852.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1140887517.9852.4.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 25, 2006 at 09:11:57AM -0800, Bryan O'Sullivan wrote:
> On Sat, 2006-02-25 at 09:28 -0500, Benjamin LaHaise wrote:
> 
> > sfence has no impact 
> > on the flushing of the write combining buffers
> 
> The sfence instruction guarantees that every store that precedes it in
> program order is globally visible, including over the likes of the PCI
> bus, before any store instruction that follows the fence.

That is not the same as saying the write buffers are flushed and wholly 
visible to their destination, it just means that subsequent reads or 
writes will not be reordered prior to the sfence instruction.  It is 
entirely possible that the writes will remain in buffers on the CPU until 
well after the sfence instruction has executed, sfence only affects the 
order in which they become visible on the bus.  If you want to force a 
flush, a read from the PCI device is the only way to accomplish that.

		-ben
-- 
"Ladies and gentlemen, I'm sorry to interrupt, but the police are here 
and they've asked us to stop the party."  Don't Email: <dont@kvack.org>.
