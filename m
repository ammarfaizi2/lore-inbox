Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262048AbVAJCLS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262048AbVAJCLS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 21:11:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262049AbVAJCLS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 21:11:18 -0500
Received: from rain.plan9.de ([193.108.181.162]:60317 "EHLO rain.plan9.de")
	by vger.kernel.org with ESMTP id S262048AbVAJCLP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 21:11:15 -0500
Date: Mon, 10 Jan 2005 03:11:09 +0100
From: Marc Lehmann <linux-kernel@plan9.de>
To: linux-kernel@vger.kernel.org
Subject: sockets stuck in FIN_WAIT2 and CLOSE_WAIT state in 2.6.10
Message-ID: <20050110021108.GA9758@schmorp.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-PGP: "1024D/DA743396 1999-01-26 Marc Alexander Lehmann <schmorp@schmorp.de>
       Key fingerprint = 475A FE9B D1D4 039E 01AC  C217 A1E8 0270 DA74 3396"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After upgrading to linux-2.6.10 (on 2004-12-26), my rsh processes start to
hang despite the server side having closed the connection.

Inspection showed that one of the two rsh processes exited:

   16011 ?        SN     0:00      0     6  1717   600  0.0 rsh ruth cd xmltv && ./upd
   16012 ?        ZN     0:00      0     0     0     0  0.0 [rsh] <defunct>

lsof shows both sockets:

   rsh     16011 root    3u  IPv4 6454542          TCP doom:1014->ruth:shell (FIN_WAIT2)
   rsh     16011 root    5u  IPv4 6454545          TCP doom:1013->ruth:1023 (CLOSE_WAIT)

and the remaining rsh process hangs in select on the FIN_WAIT2 socket:

   select(6, [3], NULL, NULL, NULL

Some of the hung processes are stuck for 14 days now.

I did not have the same problem with 2.6.10-rc1, or 2.6.8.1, which I used
before.

This is on a x86 SMP kernel using Debian GNU/Linux. If this problem is
already known, my apologies, I couldn't access a kernel list archive. If
you want more info, feel free to contact me.

-- 
                The choice of a
      -----==-     _GNU_
      ----==-- _       generation     Marc Lehmann
      ---==---(_)__  __ ____  __      pcg@goof.com
      --==---/ / _ \/ // /\ \/ /      http://schmorp.de/
      -=====/_/_//_/\_,_/ /_/\_\      XX11-RIPE
