Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032498AbWLGRF5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032498AbWLGRF5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 12:05:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162536AbWLGRF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 12:05:56 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:40106 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1162533AbWLGRFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 12:05:55 -0500
Message-ID: <457849E2.3080909@garzik.org>
Date: Thu, 07 Dec 2006 12:05:38 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, macro@linux-mips.org
CC: David Howells <dhowells@redhat.com>, rdreier@cisco.com,
       afleming@freescale.com, ben.collins@ubuntu.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Export current_is_keventd() for libphy
References: <20061206234942.79d6db01.akpm@osdl.org>	<1165125055.5320.14.camel@gullible>	<20061203011625.60268114.akpm@osdl.org>	<Pine.LNX.4.64N.0612051642001.7108@blysk.ds.pg.gda.pl>	<20061205123958.497a7bd6.akpm@osdl.org>	<6FD5FD7A-4CC2-481A-BC87-B869F045B347@freescale.com>	<20061205132643.d16db23b.akpm@osdl.org>	<adaac22c9cu.fsf@cisco.com>	<20061205135753.9c3844f8.akpm@osdl.org>	<Pine.LNX.4.64N.0612061506460.29000@blysk.ds.pg.gda.pl>	<20061206075729.b2b6aa52.akpm@osdl.org>	<Pine.LNX.4.64.0612060822260.3542@woody.osdl.org>	<Pine.LNX.4.64.0612061719420.3542@woody.osdl.org>	<20061206224207.8a8335ee.akpm@osdl.org>	<9392.1165487379@redhat.com> <20061207024211.be739a4a.akpm@osdl.org>
In-Reply-To: <20061207024211.be739a4a.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, I merged the code, but looking deeper at phy its clear I missed 
some things.

Looking into libphy's workqueue stuff, it has the following sequence:

	disable interrupts
	schedule_work()

	... time passes ...
	... workqueue routine is called ...

	enable interrupts
	handle interrupt

I really have to question if a workqueue was the best choice of 
direction for such a sequence.  You don't want to put off handling an 
interrupt, with interrupts disabled, for a potentially unbounded amount 
of time.

Maybe the best course of action is to mark it with CONFIG_BROKEN until 
it gets fixed.

	Jeff



