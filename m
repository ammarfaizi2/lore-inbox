Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269039AbUIXXA0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269039AbUIXXA0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 19:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269042AbUIXXAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 19:00:25 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:7141 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S269039AbUIXW7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 18:59:09 -0400
Date: Sat, 25 Sep 2004 00:59:00 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Chris Wright <chrisw@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: mlock(1)
Message-ID: <20040924225900.GY3309@dualathlon.random>
References: <41547C16.4070301@pobox.com> <20040924132247.W1973@build.pdx.osdl.net> <1096060045.10800.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1096060045.10800.4.camel@localhost.localdomain>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2004 at 10:07:25PM +0100, Alan Cox wrote:
> Keys are a different case anyway. We can swap them if we have encrypted
> swap (hardware or software) and we could use the crypto lib just to
> crypt some pages in swap although that might be complex. As such a
> MAP_CRYPT seems better than mlock. If we don't have cryptable swap then
> fine its mlock.

I really like encrypted swap, it should already work fine, I think we
should make it the default. The cpu cost during swapping should be
really not significant. It's needed anyways for running suspend on a
laptop (currently suspend dumps into the swap the cleartext key of any
cryptoloop device, making cryptoloop pretty much useless).  And the good
thing is that it won't even need to ask for a password.
