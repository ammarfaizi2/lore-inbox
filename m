Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264566AbUASLmS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 06:42:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264586AbUASLl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 06:41:27 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:51621 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S264502AbUASLk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 06:40:58 -0500
Subject: Re: Help port swsusp to ppc.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: ncunningham@users.sourceforge.net
Cc: Hugang <hugang@soulinfo.com>, ncunningham@clear.net.nz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       debian-powerpc@lists.debian.org
In-Reply-To: <1074489645.2111.8.camel@laptop-linux>
References: <20040119105237.62a43f65@localhost>
	 <1074483354.10595.5.camel@gaston>  <1074489645.2111.8.camel@laptop-linux>
Content-Type: text/plain
Message-Id: <1074490463.10595.16.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 19 Jan 2004 22:39:27 +1100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> It should contain the .S equivalent to the swsusp2.c file. It would be
> best if swsusp2.c could simply be compiled, but it appears that it can't
> at the moment on x86 (I need to learn x86 assembly so I can understand
> why).

I see no reason why this would be needed on ppc, only the last step,
that is the actual CPU state save, should matter.

> That idea is to have a section that doesn't get replaced when we copy
> the original kernel back. Thus, small amounts of data that suspend uses
> or stores can be given the __nosave attribute. An example is the cpu
> frequency value, which should match the boot kernel, not the value at
> suspend time.

That's very hairy... You basically assume the boot kernel and the
restore kernel are completely identical, which isn't something I would
do. I didn't have time to dive into it, but I do/did intend to implement
swsusp on ppc and I would eventually resume the whole environement
straight from the bootloader without kernel help.

If you want to pass some infos between the "loader" kernel and the "loaded"
one, I strongly suggest you define some well specified interface for doing
so that is immune to kernel versions.

Also, I haven't looked in details, but when switching to the "new" kernel
from the "loader" (boot) one, do you shut down all devices properly ?
This switch could actually be fairly similar to a kexec pass in this
regard.

Ben.


