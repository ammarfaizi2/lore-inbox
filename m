Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266806AbRHFFoR>; Mon, 6 Aug 2001 01:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266808AbRHFFoI>; Mon, 6 Aug 2001 01:44:08 -0400
Received: from pizda.ninka.net ([216.101.162.242]:13440 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S266806AbRHFFny>;
	Mon, 6 Aug 2001 01:43:54 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15214.11918.92118.404546@pizda.ninka.net>
Date: Sun, 5 Aug 2001 22:43:42 -0700 (PDT)
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org, Mirko Lindner <mlindner@syskonnect.de>
Subject: Re: drivers/net/sk98lin/skproc.c undefined root_dev
In-Reply-To: <346.997072381@ocs3.ocs-net>
In-Reply-To: <346.997072381@ocs3.ocs-net>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Keith Owens writes:
 > drivers/net/sk98lin/skproc.c:extern struct net_device *root_dev
 > Defined extern, all other definitions of root_dev are static, except in
 > sparc.  CONFIG_SK98LIN is not limited to sparc.  Either the config is
 > wrong or the code in skproc is wrong.

I think two things are wrong here, nice spotting:

1) root_dev in the sk98lin driver needs another name if it is
   going to be exported to multiple objects within the driver.
   Something like sk98lin_root_dev.

2) It should be non-static in skge.c

I distinctly remember it compiling and working correctly on x86
sometime earlier in the 2.4.x series, so perhaps this brokenness
is recent.

Later,
David S. Miller
davem@redhat.com
