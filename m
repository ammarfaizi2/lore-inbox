Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162600AbWLGR6F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162600AbWLGR6F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 12:58:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162602AbWLGR6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 12:58:05 -0500
Received: from smtp.osdl.org ([65.172.181.25]:50717 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1162600AbWLGR6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 12:58:02 -0500
Date: Thu, 7 Dec 2006 09:57:15 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: torvalds@osdl.org, macro@linux-mips.org,
       David Howells <dhowells@redhat.com>, rdreier@cisco.com,
       afleming@freescale.com, ben.collins@ubuntu.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Export current_is_keventd() for libphy
Message-Id: <20061207095715.0cafffb9.akpm@osdl.org>
In-Reply-To: <457849E2.3080909@garzik.org>
References: <20061206234942.79d6db01.akpm@osdl.org>
	<1165125055.5320.14.camel@gullible>
	<20061203011625.60268114.akpm@osdl.org>
	<Pine.LNX.4.64N.0612051642001.7108@blysk.ds.pg.gda.pl>
	<20061205123958.497a7bd6.akpm@osdl.org>
	<6FD5FD7A-4CC2-481A-BC87-B869F045B347@freescale.com>
	<20061205132643.d16db23b.akpm@osdl.org>
	<adaac22c9cu.fsf@cisco.com>
	<20061205135753.9c3844f8.akpm@osdl.org>
	<Pine.LNX.4.64N.0612061506460.29000@blysk.ds.pg.gda.pl>
	<20061206075729.b2b6aa52.akpm@osdl.org>
	<Pine.LNX.4.64.0612060822260.3542@woody.osdl.org>
	<Pine.LNX.4.64.0612061719420.3542@woody.osdl.org>
	<20061206224207.8a8335ee.akpm@osdl.org>
	<9392.1165487379@redhat.com>
	<20061207024211.be739a4a.akpm@osdl.org>
	<457849E2.3080909@garzik.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Dec 2006 12:05:38 -0500
Jeff Garzik <jeff@garzik.org> wrote:

> Yes, I merged the code, but looking deeper at phy its clear I missed 
> some things.
> 
> Looking into libphy's workqueue stuff, it has the following sequence:
> 
> 	disable interrupts
> 	schedule_work()
> 
> 	... time passes ...
> 	... workqueue routine is called ...
> 
> 	enable interrupts
> 	handle interrupt
> 
> I really have to question if a workqueue was the best choice of 
> direction for such a sequence.  You don't want to put off handling an 
> interrupt, with interrupts disabled, for a potentially unbounded amount 
> of time.

That'll lock the box on UP, or if the timer fires on the current CPU?

> Maybe the best course of action is to mark it with CONFIG_BROKEN until 
> it gets fixed.

hm, maybe.  I wonder if as a short-term palliative we could remove the
current_is_keventd() call and drop rtnl_lock.  Or export current_is_keventd ;)
