Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262272AbUDXLtj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262272AbUDXLtj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Apr 2004 07:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262279AbUDXLtj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Apr 2004 07:49:39 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:20171 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S262272AbUDXLte
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Apr 2004 07:49:34 -0400
Date: Sat, 24 Apr 2004 12:44:53 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Andy Lutomirski <luto@myrealbox.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, jgarzik@pobox.com,
       Jon D Mason <jonmason@us.ibm.com>
Subject: Re: [PATCH r8169] ethtool support and sane speed selection/detection
Message-ID: <20040424124453.A25284@electric-eye.fr.zoreil.com>
References: <20040424050931.14C341D4F@luto.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040424050931.14C341D4F@luto.stanford.edu>; from luto@myrealbox.com on Fri, Apr 23, 2004 at 10:08:25PM -0700
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Jeff Garzik added to the loop]
[If nobody disagrees, I'll remove l-k from the Cc: during the next round]

Andy Lutomirski <luto@myrealbox.com> :
> This adds ethtool support to r8169.

Cool.

> Some notes:  I stole the RxUnderrun interrupt status bit because (1) I
> don't know what a recieve underrun is, (2) the specs say that bit is
> actually "link status changed" and (3) simple tests seem to confirm that.

Ok, this bit is named 'LinkChg' in drivers/net/8139cp.c as well.

> Speed selection doesn't actually set a forced mode but just sets
> autonegotiation to advertise only one speed.  (This way there is no ugly
> special case for 1000Mbps.)
> 
> The link status is no longer checked on startup because it is slow and, with
> ethtool support, unnecessary.

Just to clarify, it is still done in rtl8169_open() instead of rtl8169_init_one().
Even if it is a change of behavior in a supposedly stable serie, I guess it is ok
as it moves the driver in the direction of the 8139cp driver.

> As an added benefit, my 8001S often fails to negotiate 1000Mbps when the
> driver loads but will successfully negotiate it after a while.  Running
> 'ethtool -s ethx autoneg on' fixes it, but that's absurd.  This patch
> will, ten seconds after the driver starts, check if 1000Mbps is advertised
> but not selected, and, if so, force a renegotiation.

So you can not reliably remove the phy timer and simply use the LinkChg status
change, right ?

Is everybody fine if I cook up a serie of patches for -netdev/-mm inclusion
which includes:
- your link related changes
- start of a 8139cp.c genetic mutation on top of those
- reworked Jon D Mason's NAPI changes

ETA: this week end, start of incoming week.

--
Ueimor
