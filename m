Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265319AbUATBL3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 20:11:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265325AbUATBI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 20:08:59 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:41399 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265314AbUATBIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 20:08:01 -0500
Subject: Re: Help port swsusp to ppc.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: ncunningham@users.sourceforge.net, Hugang <hugang@soulinfo.com>,
       ncunningham@clear.net.nz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       debian-powerpc@lists.debian.org
In-Reply-To: <20040120000435.GB837@elf.ucw.cz>
References: <20040119105237.62a43f65@localhost>
	 <1074483354.10595.5.camel@gaston> <1074489645.2111.8.camel@laptop-linux>
	 <1074490463.10595.16.camel@gaston> <20040119204551.GB380@elf.ucw.cz>
	 <1074555531.10595.89.camel@gaston>  <20040120000435.GB837@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1074558590.11809.98.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 20 Jan 2004 12:06:21 +1100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.6 (++)
X-Spam-Report: SpamAssassin version 2.62 on pentafluge.infradead.org summary:
	Content analysis details:   (2.6 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[203.51.30.182 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[203.51.30.182 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> (1) There's routine during resume that copies pages to their old
> locations. If you (would want to) have different kernel during resume,
> how do you guarantee that that "kernel being resumed" does not use
> memory ocupied by copying routine?

By having the copy routine sit elsewhere. You can have the copy routine
be in a known location of the kernel beeing resumed (that is it uses
its own copy routine) that is aligned on a page boundary and knows how
to copy itself. Fairly trivial.

> (2) Plus number of problems with devices grows with number of versions
> squared. To guarantee it works properly you'd have to test all
> combinations of "suspend kernel" and "resume kernel".

Why ? You aren't passing any device/driver information from the boot
kernel and the resumed one... do you ?

> [(1) Could be solved by reserving 4KB somewhere for copy routine, and
> making sure copy routine is never bigger than 4KB etc. But I'd like to
> keep it simple and really don't want to deal with (2).]

Then you don't wnat to do things properly...

Ben.


