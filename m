Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263389AbUDEWW7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 18:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262932AbUDEWUo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 18:20:44 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:14775
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263519AbUDEWQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 18:16:43 -0400
Date: Tue, 6 Apr 2004 00:16:41 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Eric Whiting <ewhiting@amis.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: -mmX 4G patches feedback
Message-ID: <20040405221641.GN2234@dualathlon.random>
References: <40718B2A.967D9467@amis.com> <20040405174616.GH2234@dualathlon.random> <4071D11B.1FEFD20A@amis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4071D11B.1FEFD20A@amis.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2004 at 03:35:23PM -0600, Eric Whiting wrote:
> 4G of virtual address is what we need. Virtual address space is why the -mmX
> 4G/4G patches are useful. In this application it is single processes (usually

Indeed.

> 3.5:1.5 appears to be a 2.4.x kernel patch only right?

Martin has a port for 2.6 in the -mjb patchset (though it only works
with PAE disabled but there are patches floating around to make it work
at not noticeable cost with PAE enabled too).

Note if you never run sysscalls you're probably fine with 4:4, I'd
recommend to lower the timer irq back to 100 HZ though (2000 mm switch
per second is way too much for number crunching with 4:4, it's way too much
even with 3:1, with 3:1 is something like 1% slowdown just due the more
frequent irqs [on a mean 1-2Ghz box], with 4:4 should be a lot lot worse
than that).
