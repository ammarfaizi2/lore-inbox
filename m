Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266753AbUGLIKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266753AbUGLIKl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 04:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266752AbUGLIKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 04:10:41 -0400
Received: from mail3.bluewin.ch ([195.186.1.75]:32390 "EHLO mail3.bluewin.ch")
	by vger.kernel.org with ESMTP id S266753AbUGLIJs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 04:09:48 -0400
Date: Mon, 12 Jul 2004 10:09:33 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: via-rhine breaks with recent Linus kernels : probe of 0000:00:09.0 failed with error -5
Message-ID: <20040712080933.GA9221@k3.hellgate.ch>
Mail-Followup-To: Jesper Juhl <juhl-lkml@dif.dk>,
	lkml <linux-kernel@vger.kernel.org>
References: <8A43C34093B3D5119F7D0004AC56F4BC082C7F9E@difpst1a.dif.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8A43C34093B3D5119F7D0004AC56F4BC082C7F9E@difpst1a.dif.dk>
X-Operating-System: Linux 2.6.7-bk20 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ removed Donald Becker from Cc: -- I doubt he has much interest in
the mainline via-rhine ]

On Mon, 12 Jul 2004 03:49:35 +0200, Jesper Juhl wrote:
> I've noticed that with recent kernels from Linus' tree the via-rhine
> driver that I use for my NIC seems to have broken.
> 
> I don't recall any problems with kernels prior to 2.6.7
> 2.6.7 vanilla - works.
> 2.6.7-BK20    - breaks
> 2.6.8-rc1     - breaks
> 2.6.7-mm1,-mm2,-mm3,-mm6,-mm7 all work
> I haven't tested earlier BK snapshots, but I'm willing to do so if wanted.
> 
> I get the following from the kernels that break:
> Invalid MAC address for card #0
> via-rhine: probe of 0000:00:09.0 failed with error -5

I had this happen recently when I moved from rc3-bk6 to bk20. When I
started to look into it, the problem went away and never came back.

There are some subtle timing issues with chip resets and reloading the
EEPROM. So far, it was the Rhine-I which has been more sensitive, but
when I hit this problem Rhine-I was fine while Rhine-II and Rhine-III
were not.

You can try adding an msleep(5) before and after reload_eeprom (make
sure you get the right one, mainline still has two ifdef'ed calls),
or you can try switching drivers between mainline and -mm.

I'd be happy to tell people to just go with the latest driver which
is the one in -mm, but I'm afraid mainline might be exposing a problem
that still lingers in -mm.

Roger
