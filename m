Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265891AbTL3W1I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 17:27:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265872AbTL3WYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 17:24:16 -0500
Received: from imf20aec.mail.bellsouth.net ([205.152.59.68]:57550 "EHLO
	imf20aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S265880AbTL3WXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 17:23:38 -0500
Subject: Re: no DRQ after issuing WRITE was Re: 2.4.23-uv3 patch set
	released
From: Rob Love <rml@ximian.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Daniel Tram Lux <daniel@starbattle.com>, steve@drifthost.com,
       James Bourne <jbourne@hardrock.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Gergely Tamas <dice@mfa.kfki.hu>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
In-Reply-To: <Pine.LNX.4.58.0312301352570.2065@home.osdl.org>
References: <Pine.LNX.4.51.0312290052470.1599@cafe.hardrock.org>
	 <Pine.LNX.4.58L.0312300935040.22101@logos.cnet>
	 <Pine.LNX.4.58.0312301130430.2065@home.osdl.org>
	 <Pine.LNX.4.58L.0312301849400.23875@logos.cnet>
	 <Pine.LNX.4.58.0312301352570.2065@home.osdl.org>
Content-Type: text/plain
Message-Id: <1072823015.4350.40.camel@fur>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Tue, 30 Dec 2003 17:23:35 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-12-30 at 16:57, Linus Torvalds wrote:

> Is CONFIG_PREEMPT on in the cases, and is there really no locking 
> anywhere? Preempting in the middle of the data transfer phase sounds like 
> a fundamentally bad idea, and maybe the code needs a few preempt 
> disable/enable pairs somewhere?

Is the kernel patched with kernel preemption?  It is not in stock 2.4.

Anyhow, if interrupts are disabled, preemption should be disabled (we
check for that condition in both preempt_schedule() and
return_from_intr).

If interrupts are not disabled, then preempting would definitely be a
bad thing.  But I would think, for the same reasons you do not want to
preempt, you would want interrupts disabled ..

	Rob Love


