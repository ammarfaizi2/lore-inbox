Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265914AbTL3W6L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 17:58:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265906AbTL3Wzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 17:55:50 -0500
Received: from fw.osdl.org ([65.172.181.6]:59344 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265904AbTL3WzE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 17:55:04 -0500
Date: Tue, 30 Dec 2003 14:54:40 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Rob Love <rml@ximian.com>
cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Daniel Tram Lux <daniel@starbattle.com>, steve@drifthost.com,
       James Bourne <jbourne@hardrock.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Gergely Tamas <dice@mfa.kfki.hu>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: no DRQ after issuing WRITE was Re: 2.4.23-uv3 patch set released
In-Reply-To: <1072823015.4350.40.camel@fur>
Message-ID: <Pine.LNX.4.58.0312301452370.2065@home.osdl.org>
References: <Pine.LNX.4.51.0312290052470.1599@cafe.hardrock.org> 
 <Pine.LNX.4.58L.0312300935040.22101@logos.cnet>  <Pine.LNX.4.58.0312301130430.2065@home.osdl.org>
  <Pine.LNX.4.58L.0312301849400.23875@logos.cnet>  <Pine.LNX.4.58.0312301352570.2065@home.osdl.org>
 <1072823015.4350.40.camel@fur>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 30 Dec 2003, Rob Love wrote:
> 
> Anyhow, if interrupts are disabled, preemption should be disabled (we
> check for that condition in both preempt_schedule() and
> return_from_intr).

Interrupts are _not_ disabled here, very much on purpose. If they were, 
then "jiffies" wouldn't update, and the timeouts wouldn't work.

This is what that _stupid_ "local_irq_set()" function does: it saves the 
old irq masking state, and then it enables it.

The whole concept doesn't make any sense. If you enable interrupts, there 
is little point in saving the callers irq mask, since it already got 
deflated.

		Linus
