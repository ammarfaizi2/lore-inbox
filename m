Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264229AbTKZP1j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 10:27:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264231AbTKZP1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 10:27:39 -0500
Received: from clem.clem-digital.net ([68.16.168.10]:2052 "EHLO
	clem.clem-digital.net") by vger.kernel.org with ESMTP
	id S264229AbTKZP1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 10:27:37 -0500
From: Pete Clements <clem@clem.clem-digital.net>
Message-Id: <200311261527.KAA00655@clem.clem-digital.net>
Subject: Re: 2.6.0-test10: Badness in local_bh_enable at kernel/softirq.c:121
In-Reply-To: <20031126055258.7526a09d.akpm@osdl.org> from Andrew Morton at "Nov 26, 2003  5:52:58 am"
To: akpm@osdl.org (Andrew Morton)
Date: Wed, 26 Nov 2003 10:27:22 -0500 (EST)
Cc: corwin@amber.kn-bremen.de, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
X-Mailer: ELM [version 2.4ME+ PL48 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andrew Morton
  > Christian Schlittchen <corwin@amber.kn-bremen.de> wrote:
  > >
  > > 
  > > When trying to establish a ppp/pppoe connection I get the following
  > > and the connection fails:
  > > 
  > > Badness in local_bh_enable at kernel/softirq.c:121
  > > Call Trace:
  > > [<c011feac>] local_bh_enable+0x8c/0x90
  > > [<e096ccae>] ppp_sync_push+0x6e/0x1a0 [ppp_synctty]
  > > [<c015cdc0>] __lookup_hash+0x70/0xd0
  > > [<e096c651>] ppp_sync_wakeup+0x31/0x70 [ppp_synctty]
  > > [<c0207b79>] pty_unthrottle+0x59/0x60
  > > [<c02043ba>] check_unthrottle+0x3a/0x40
  > > [<c0204463>] n_tty_flush_buffer+0x13/0x60
  > > [<c0207f6d>] pty_flush_buffer+0x6d/0x70
  > > [<c0200c0e>] do_tty_hangup+0x3fe/0x460
  > 
  > The warning is a pest, and is due to do_tty_hangup() bogusly disabling
  > interrupts in the hope that it does something useful.  It needs to be fixed
  > up.
  > 
  > But it is unrelated to the PPP failure.  I'm afraid it is so long since I
  > used PPP and pppd that I cannot suggest how you should set about gathering
  > extra info on that.
  > 
What network card? Multi-cards? Is the card detected?

Around 2.5.71 the 3c509 init/detect changed such that the
second card is not detected.  Will get the badness when attempting
to bring up ppp/ppoe on a non-existent card.  

The 3c509 multi card breakage still exists at test10. I replace the
driver with 2.5.7x version to get my pppoe.
-- 
Pete Clements 
