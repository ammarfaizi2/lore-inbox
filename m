Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263802AbUCXSws (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 13:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263807AbUCXSws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 13:52:48 -0500
Received: from ASte-Genev-Bois-101-1-1-195.w193-252.abo.wanadoo.fr ([193.252.54.195]:30226
	"EHLO slartibartfast.qube.net") by vger.kernel.org with ESMTP
	id S263802AbUCXSwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 13:52:46 -0500
Date: Wed, 24 Mar 2004 19:52:43 +0100
From: Ignacy Gawedzki <ig@lri.fr>
To: linux-kernel@vger.kernel.org
Cc: USAGI users <usagi-users@linux-ipv6.org>
Subject: IPv6 multicast in 2.4.25 broken?
Message-ID: <20040324185243.GB27409@zenon.mine.nu>
Mail-Followup-To: Ignacy Gawedzki <ig@lri.fr>, linux-kernel@vger.kernel.org,
	USAGI users <usagi-users@linux-ipv6.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

It seems that simple multicast support in IPv6 has ceased working
starting at kernel version 2.4.25-pre4.  More specifically, receiving
multicast packets (those with destination address ff05::1 or ff02::1) is
broken (read: sending is okay).  The same binary run on kernels 2.4.24
and earlier works with no problem.

I tried as many combinations of USAGI patches and kernel versions as I
could, but cannot figure the exact source of the problem.  I did not
inspect the diffs with enough attention, though.

Another funny thing is that the changelog for version 2.4.25-pre4
doesn't mention any change to IPv6 code.

Did anyone have similar experience and or suggestions?

I have not subscribed to the linux-kernel list, because of its high
traffic, so please CC me the replies.

Thanks,

Ignacy

PS: The detailed way in which I prepare the socket is the following:

  Open a UDP socket in IPv6 protocol family.

  Bind it to network interface using SO_BINDTODEVICE.

  Set the multicast network interface using IPV6_MULTICAST_IF.
  
  Bind it to the network interface's address (which is set manually to
  fec0::1).
  
  Set the multicast hops with IPV6_MULTICAST_HOPS to 1.
  
  Set the multicast membership to ff02::1 (or ff05::1) using
  IPV6_ADD_MEMBERSHIP.
  
  Unset the multicast loop using IPV6_MULTICAST_LOOP.

Note: the same socket is used to send and receive multicast packets.

-- 
To err is human, to moo bovine.
