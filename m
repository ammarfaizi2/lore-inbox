Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269544AbTGJSAu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 14:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269558AbTGJSAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 14:00:50 -0400
Received: from air-2.osdl.org ([65.172.181.6]:10197 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269544AbTGJSAs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 14:00:48 -0400
Date: Thu, 10 Jul 2003 11:15:25 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: davidm@hpl.hp.com
cc: Rusty Russell <rusty@rustcorp.com.au>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, <ak@suse.de>
Subject: Re: per_cpu fixes 
In-Reply-To: <16141.43130.657025.952793@napali.hpl.hp.com>
Message-ID: <Pine.LNX.4.44.0307101112320.16847-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 10 Jul 2003, David Mosberger wrote:
> 
> You mean there would be three primitives:
> 
>  (1) get value from a per-CPU variable
>  (2) set value of a per-CPU variable
>  (3) get the (canonical) address of a per-CPU variable

Argh.

We'd better have the rule that if there are any virtual caches or other
issues, then the "canonical address" had better be the _only_ address (or
at least any virtual remapping has to be done in such a way that it never
causes aliasing or other performance problems with the canonical address).

This is already turning fairly ugly, and I just don't want to see even 
more ugly rules like "you can't mix direct accesses with pointer accesses"

		Linus

