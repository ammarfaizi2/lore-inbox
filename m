Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271051AbTHQVrU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 17:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271073AbTHQVrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 17:47:20 -0400
Received: from janus.zeusinc.com ([205.242.242.161]:25364 "EHLO
	zso-proxy.zeusinc.com") by vger.kernel.org with ESMTP
	id S271051AbTHQVrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 17:47:18 -0400
Subject: Re: [PATCH] O16.2int
From: Tom Sightler <ttsig@tuxyturvy.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1061152667.5526.26.camel@athxp.bwlinux.de>
References: <1061152667.5526.26.camel@athxp.bwlinux.de>
Content-Type: text/plain
Message-Id: <1061156820.1775.32.camel@iso-8590-lx.zeusinc.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 17 Aug 2003 17:47:00 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Con,

I've been unable to test many of your patches lately, but I recently
upgraded to 2.6.0-test3-mm2 and included the O16.2 patches and I'm
having some very bad behaviour.  I'll try to describe it the best way I
can.

The worst case scenario involves wine applications (a program that seems
to be causing a significant amount of trouble) but I think I've seen the
issue in several other applications as well.

1. -- Wine running Windows Media Player 6.4 works great when running in
a window but if you make the program open to full screen it gets so much
attention that it almost completely starves the entire system, you can't
even manage to get switched back to the standard screen.  If you get
very lucky you can switch the system to a VT and manage, painfully
slowly to kill the wine process off, then the system will turn to
normal.  This issue actually seems to affect almost any wine
applications that's doing a lot of screen updates, for example small
flash animations work OK, but complex animations can cause many seconds
of starvation to the rest of the system.  Renicing the X server and wine
server to much lower numbers seems to make this issue go away.

2. -- Adobe Acrobat 5.07 for Linux seems to have a very similar issue, a
large complex document seems to starve out the whole system making the
system feel locked up for several seconds.

3. -- It seems I can trigger the same kind of starvation by simply doing
large selects in a Konsole window.  Selecting a large section of text
which causes the window to scroll can sometime make the system almost
totally non-responsive in every other window.

The wine issue is the easiest to trigger, the others seem to require
that some other things are also using CPU.  In other words, if the
system is otherwise totally idle I have been unable to trigger the
Konsole issue, however, if another application is using a reasonable
amount of CPU, say a video playing in Wine using ~50% CPU, then it seems
easy to make this happen.  Once it happens it's very hard to recover,
the systems almost completely fails to respond to mouse button clicks
and keyboard functions (although the mouse usually continues to move
smoothly) if I get lucky I can get to a VT and eventually login and kill
something off, but this sometimes takes minutes (it took 90 seconds
earlier today just to get the password prompt after type in my username
at the VT prompt and another minute to get to a shell).

Later,
Tom



