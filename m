Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261527AbVAaImk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261527AbVAaImk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 03:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261566AbVAaImk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 03:42:40 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:53208 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261527AbVAaImj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 03:42:39 -0500
Subject: Re: Deadlock in serial driver 2.6.x
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Andrew Morton <akpm@osdl.org>,
       Martin =?ISO-8859-1?Q?K=F6gler?= <e9925248@student.tuwien.ac.at>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050130164840.D25000@flint.arm.linux.org.uk>
References: <20050126132047.GA2713@stud4.tuwien.ac.at>
	 <20050126231329.440fbcd8.akpm@osdl.org>
	 <1106844084.14782.45.camel@localhost.localdomain>
	 <20050130164840.D25000@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1107157019.14847.64.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 31 Jan 2005 07:37:00 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2005-01-30 at 16:48, Russell King wrote:
> Unsolvable as the tty layer currently stands.  tty needs to not call back
> into serial drivers when they supply read characters from their interrupt
> functions.

The tty layer cannot fix this for now, and I don't intend to fix it. Fix
the serial driver: the fix is quite simple since you can keep a field in
the driver for now to detect recursive calling into the echo case and
don't relock.

Alan

