Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265922AbUFWOb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265922AbUFWOb4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 10:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265270AbUFWO3p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 10:29:45 -0400
Received: from www.nute.net ([66.221.212.1]:12940 "EHLO mail.nute.net")
	by vger.kernel.org with ESMTP id S265249AbUFWO3j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 10:29:39 -0400
Date: Wed, 23 Jun 2004 14:29:36 +0000
From: Mikael Bouillot <xaajimri@corbac.com>
To: linux-kernel@vger.kernel.org
Cc: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
Subject: Forcedeth driver bug
Message-ID: <20040623142936.GA10440@mail.nute.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi all,

  I'm having trouble with the forcedeth driver in kernel version 2.6.7.
>From what I can see, it seems that incoming packets sometime get stuck
on their way in.

  What happens is this: some packet enters the NIC, and for some reason,
it doesn't come out of the driver. As soon as another incoming packet
gets in, both packets are handed down by the driver.

  It is usually invisible during normal TCP operation, as there are
several packets in flight and the stuck packet gets pushed down by the
one following it very soon. But for lockstep protocols like SMB, it very
annoying as it means you get "blanks" of 2 to 5 seconds during the
transfer.

  I can reproduce this very easily with a modified version of ping. I
do a flood ping from another machine to the one with the nvnet NIC, but
I modified ping to send a new packet if one gets "lost" only 10 seconds
later instead of after 10 ms. The result is that after a couple hundred
ping-pong at full speed, one ping gets stuck. After 10 seconds, another
ping is sent and both pong come back.

  This didn't happen with the proprietary nvnet driver on kernel 2.4.24.
My hardware is a nForce 2 mobo (in a shuttle SN45G barebones).

  Is this a know bug? If someone working on it already or should I
investigate the matter further? Please CC any reply to me as I'm not on
the list.


  Mikael Bouillot

-- 
Hi! I'm a .signature virus! Copy me into your ~/.signature to help me spread!
