Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262051AbTICND3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 09:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262073AbTICND3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 09:03:29 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:42187 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S262051AbTICND1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 09:03:27 -0400
Subject: Re: Fix up power managment in 2.6
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Russell King <rmk@arm.linux.org.uk>, Pavel Machek <pavel@suse.cz>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
In-Reply-To: <1062498096.757.45.camel@gaston>
References: <20030831232812.GA129@elf.ucw.cz>
	 <Pine.LNX.4.44.0309010925230.7908-100000@home.osdl.org>
	 <20030901211220.GD342@elf.ucw.cz>
	 <20030901225243.D22682@flint.arm.linux.org.uk>
	 <20030901221920.GE342@elf.ucw.cz>
	 <20030901233023.F22682@flint.arm.linux.org.uk>
	 <1062498096.757.45.camel@gaston>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1062594137.19058.23.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Wed, 03 Sep 2003 14:02:18 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-09-02 at 11:21, Benjamin Herrenschmidt wrote:
> The whole point was to get rid of the old 2 step save_state, then
> suspend model which didn't make sense. A saved state is only meaningful
> as long as that state doesn't get modified afterward, so saving state
> and suspending are an atomic operation.

Very old myth. In fact just about every scheduler on the planet exploits
the fact this is untrue.

		save state
		continue running doing scheduler stuff
		restore other state losing the state in the middle we dont need

Ditto with a lot of I/O devices. My audio save state and suspend can be
seperated - I might play a little bit of a song twice but is that a bug
?


