Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261314AbTHSTrF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 15:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbTHSTpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 15:45:05 -0400
Received: from pizda.ninka.net ([216.101.162.242]:398 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261300AbTHSToQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 15:44:16 -0400
Date: Tue, 19 Aug 2003 12:37:11 -0700
From: "David S. Miller" <davem@redhat.com>
To: Valdis.Kletnieks@vt.edu
Cc: dang@fprintf.net, ak@muc.de, lmb@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Message-Id: <20030819123711.2f79fcf8.davem@redhat.com>
In-Reply-To: <200308191938.h7JJcpBC004873@turing-police.cc.vt.edu>
References: <mdtk.Zy.1@gated-at.bofh.it>
	<mgUv.3Wb.39@gated-at.bofh.it>
	<mgUv.3Wb.37@gated-at.bofh.it>
	<miMw.5yo.31@gated-at.bofh.it>
	<m365ktxz3k.fsf@averell.firstfloor.org>
	<1061320620.3744.16.camel@athena.fprintf.net>
	<200308191938.h7JJcpBC004873@turing-police.cc.vt.edu>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Aug 2003 15:38:51 -0400
Valdis.Kletnieks@vt.edu wrote:

> % ip route sho
> 198.82.168.0/24 dev eth1  proto kernel  scope link  src 198.82.168.169 
> 128.173.12.0/22 dev eth3  proto kernel  scope link  src 128.173.14.107 
> 127.0.0.0/8 dev lo  scope link 
> default via 128.173.12.1 dev eth3 

Please set the preferred source for eth1 to $(IP_OF_ETH1)
and the preferred source for eth3 to $(IP_OF_ETH3) then
do this:

bash# echo "1" >/proc/sys/net/ipv4/conf/eth1/arp_filter
bash# echo "1" >/proc/sys/net/ipv4/conf/eth3/arp_filter

This also will make applications connecting using unspecified
source addresses behave more sanely as well.

The thing you claim is the right thing to do is the wrong thing
to do in environments other than your own.
