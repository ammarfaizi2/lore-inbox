Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932802AbWGBJj4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932802AbWGBJj4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 05:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932805AbWGBJj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 05:39:56 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:46219 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932802AbWGBJjz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 05:39:55 -0400
Subject: Re: make PROT_WRITE imply PROT_READ
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: 7eggert@gmx.de
Cc: Arjan van de Ven <arjan@infradead.org>, Ulrich Drepper <drepper@gmail.com>,
       Pavel Machek <pavel@ucw.cz>, Jason Baron <jbaron@redhat.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <E1FwfNo-00012H-Gz@be1.lrz>
References: <6qIEW-1Tx-23@gated-at.bofh.it> <6qIEW-1Tx-21@gated-at.bofh.it>
	 <6qUwd-2Aq-9@gated-at.bofh.it> <6qUwd-2Aq-7@gated-at.bofh.it>
	 <6qUFV-2N8-13@gated-at.bofh.it> <6qUFY-2N8-33@gated-at.bofh.it>
	 <6rlmT-8op-37@gated-at.bofh.it> <6siwJ-3dC-5@gated-at.bofh.it>
	 <6sLoY-4GV-31@gated-at.bofh.it> <6sZUS-V5-19@gated-at.bofh.it>
	 <6tib4-2wA-3@gated-at.bofh.it> <6tmHL-Oq-5@gated-at.bofh.it>
	 <6tpZ7-5Tj-13@gated-at.bofh.it>  <E1FwfNo-00012H-Gz@be1.lrz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 02 Jul 2006 10:56:11 +0100
Message-Id: <1151834171.14346.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sad, 2006-07-01 am 15:19 +0200, ysgrifennodd Bodo Eggert:
> > unpredictably depending on the precise ordering of events on a clean
> > page.
> 
> You asked for a fault, and as long as the hardware supports it, you'll
> get one (and you're supposed to). If the hardware doesn't support read
> faults on mapped pages, you may not get all the read faults you want. The
> proposed patch makes the situation worse by disabeling the _requested_
> failures even in situations where it can be done.

The later patch as posted has no effect on such platforms because it
does not touch anything but the architecture code. Without that its
random what happens because the CPU cannot enforce write only but the
fault handler tries to. That means if you fault reading because the page
is not present you may get a fault while if you access a page which is
present you won't get a fault.

That gets quite random and has bizarre effects.

Alan

