Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265044AbUIVCQU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265044AbUIVCQU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 22:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267708AbUIVCQU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 22:16:20 -0400
Received: from ozlabs.org ([203.10.76.45]:60093 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S265044AbUIVCQK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 22:16:10 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16720.57400.930844.91232@cargo.ozlabs.ibm.com>
Date: Tue, 21 Sep 2004 21:15:20 -0500
From: Paul Mackerras <paulus@samba.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Roland Dreier <roland@topspin.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: Re: [PATCH] ppc64: Fix __raw_* IO accessors
In-Reply-To: <Pine.LNX.4.58.0409211510150.25656@ppc970.osdl.org>
References: <1095758630.3332.133.camel@gaston>
	<1095761113.30931.13.camel@localhost.localdomain>
	<1095766919.3577.138.camel@gaston>
	<523c1bpghm.fsf@topspin.com>
	<Pine.LNX.4.58.0409211237510.25656@ppc970.osdl.org>
	<52mzzjnuq7.fsf@topspin.com>
	<Pine.LNX.4.58.0409211510150.25656@ppc970.osdl.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:

> I wasn't using pp64 back when, maybe there's some other reason for playing
> games with the tokens? Who's the guity/knowledgeable party? Ben?

I believe this was done so that we could quickly work out the pci
bus/device/function inside read/write[bwl].  We needed that for coping
with the "Enhanced Error Handling" (EEH) stuff on pSeries machines.
I think we used to stuff the pci bus/dev/fn in the high bits and then
change the top 4 bits to make quite clear that it wasn't a valid
pointer.  These days we don't put the pci bus/dev/fn in the high bits
and we could certainly get rid of the IO_TOKEN_TO_ADDR games.

This stuff predates Ben's involvement in ppc64 by a long way, and was
put in before Anton or I had much influence.  We'll clean it up.

Paul.

