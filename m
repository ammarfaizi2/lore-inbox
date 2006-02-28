Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932299AbWB1SD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbWB1SD5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 13:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932334AbWB1SD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 13:03:57 -0500
Received: from kanga.kvack.org ([66.96.29.28]:16807 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S932299AbWB1SD4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 13:03:56 -0500
Date: Tue, 28 Feb 2006 12:58:38 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Define wc_wmb, a write barrier for PCI write combining
Message-ID: <20060228175838.GD24306@kvack.org>
References: <1140841250.2587.33.camel@localhost.localdomain> <20060225142814.GB17844@kvack.org> <1140887517.9852.4.camel@localhost.localdomain> <20060225174134.GA18291@kvack.org> <1141149009.24103.8.camel@camp4.serpentine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141149009.24103.8.camel@camp4.serpentine.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2006 at 09:50:08AM -0800, Bryan O'Sullivan wrote:
> The last 32-bit write triggers the chip to put the packet on the wire.
> We make sure it happens after the earlier bulk write using a barrier.

The barrier you're looking for is wmb() in asm/system.h, which is defined 
on both SMP and UP.  On x86 you do not need the sfence as writes will show 
up on the bus in program order, but you do need wmb() to prevent gcc from 
reordering your code.  Adding a new primative only makes things slower as 
the sfence isn't necessary most of the time (it rightly has a dependancy on 
CONFIG_UNORDERED_IO, which the jury is still out on).

		-ben
-- 
"Ladies and gentlemen, I'm sorry to interrupt, but the police are here 
and they've asked us to stop the party."  Don't Email: <dont@kvack.org>.
