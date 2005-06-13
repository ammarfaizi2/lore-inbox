Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261408AbVFMHZ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261408AbVFMHZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 03:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261338AbVFMHZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 03:25:28 -0400
Received: from gate.crashing.org ([63.228.1.57]:3278 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261408AbVFMHZZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 03:25:25 -0400
Subject: Re: Add pselect, ppoll system calls.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: jnf <jnf@innocence-lost.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       David Woodhouse <dwmw2@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       drepper@redhat.com
In-Reply-To: <Pine.LNX.4.58.0506122018230.2286@ppc970.osdl.org>
References: <1118444314.4823.81.camel@localhost.localdomain>
	 <1118616499.9949.103.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0506121725250.2286@ppc970.osdl.org>
	 <Pine.LNX.4.62.0506121815070.24789@fhozvffvba.vaabprapr-ybfg.arg>
	 <Pine.LNX.4.58.0506122018230.2286@ppc970.osdl.org>
Content-Type: text/plain
Date: Mon, 13 Jun 2005 17:23:21 +1000
Message-Id: <1118647401.5986.91.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> One pretty simple alternative is to just make the timeout be a global, and 
> have the signal handler clear it, guaranteeing that if we're just about to 
> hit the select(), we'll exit immediately.

That is still racy ... if the signal hits between loading that global to
to pass it to select and the actual syscall entry ... pretty narrow but
still there.


