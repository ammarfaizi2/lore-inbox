Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265212AbUFAUUD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265212AbUFAUUD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 16:20:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265214AbUFAUUD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 16:20:03 -0400
Received: from fw.osdl.org ([65.172.181.6]:33224 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265212AbUFAUT7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 16:19:59 -0400
Date: Tue, 1 Jun 2004 13:19:55 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] active_load_balance() deadlock
In-Reply-To: <200406011409.54478.bjorn.helgaas@hp.com>
Message-ID: <Pine.LNX.4.58.0406011316190.14095@ppc970.osdl.org>
References: <200406011409.54478.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 1 Jun 2004, Bjorn Helgaas wrote:
>
> active_load_balance() looks susceptible to deadlock when busiest==rq.
> Without the following patch, my 128-way box deadlocks consistently
> during boot-time driver init.

Makes sense. The regular "load_balance()" already has that test, although 
it also makes it a WARN_ON() for some unexplained reason (I assume 
find_busiest_group() isn't supposed to find the local group, although it 
doesn't seem to be documented anywhere).

Ingo, Andrew?

		Linus
