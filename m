Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267565AbUIULIM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267565AbUIULIM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 07:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267566AbUIULIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 07:08:12 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:62426 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267565AbUIULIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 07:08:07 -0400
Subject: Re: [PATCH] ppc64: Fix __raw_* IO accessors
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>
In-Reply-To: <1095758630.3332.133.camel@gaston>
References: <1095758630.3332.133.camel@gaston>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1095761113.30931.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 21 Sep 2004 11:05:32 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-09-21 at 10:23, Benjamin Herrenschmidt wrote:
> Hi !
> 
> Linus, I don't know if you did that on purpose, but you removed the
> "volatile" statement from the definition of the __raw_* IO accessors
> on ppc64, which cause some real bad optisations to happen in some
> fbdev's like matroxfb to happen (just imagine that matroxfb loops
> reading an IO register waiting for a bit to change).

Why is it using __raw if it cares about ordering and not using barriers
? Way back when the original definition was that __raw didnt do
barriers. Thats why I2O for example uses __raw_ so that messages can be
generated as efficiently as possible.


