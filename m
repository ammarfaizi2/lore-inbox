Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751876AbWI1QSR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751876AbWI1QSR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 12:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751878AbWI1QSR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 12:18:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12465 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751876AbWI1QSP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 12:18:15 -0400
Date: Thu, 28 Sep 2006 09:18:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andi Kleen <ak@muc.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Put the BUG __FILE__ and __LINE__ info out of line
Message-Id: <20060928091809.0253ce4f.akpm@osdl.org>
In-Reply-To: <451BA380.7030502@goop.org>
References: <451B64E3.9020900@goop.org>
	<20060927233509.f675c02d.akpm@osdl.org>
	<451B708D.20505@goop.org>
	<20060928000019.3fb4b317.akpm@osdl.org>
	<451BA380.7030502@goop.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Sep 2006 03:27:12 -0700
Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> Andrew Morton wrote:
> > Plan #17 is to just put the BUG inline and then put the EIP+file*+line into
> > a separate section, then search that section at BUG time to find the record
> > whose EIP points back at this ud2a.
> >   
> 
> Sure, but it seems a bit complex for this; I think simpler is better 
> when the kernel has got itself into an iffy state.

It's just a linear search.

> > It's a bit messy for modules, but it minimises the .text impact and keeps
> > disassembly happy, no?
> >   
> I'm not quite sure I understand your concern.  You're worried about the 
> size increase to vmlinux in the case where you specify 
> CONFIG_DEBUG_BUGVERBOSE?

- We're using ten bytes of instruction cache where we could use two bytes

- If this is done right, other architectures can use the look-it-up code,
  thus cleaning up the kernel codebase.

And looky, powerpc already does this, so it'd be a matter of librarifying
their code.

