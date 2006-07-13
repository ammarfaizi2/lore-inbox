Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030433AbWGMWPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030433AbWGMWPU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 18:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030431AbWGMWPT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 18:15:19 -0400
Received: from cantor2.suse.de ([195.135.220.15]:20124 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030429AbWGMWOx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 18:14:53 -0400
Date: Thu, 13 Jul 2006 15:10:38 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>,
       David S Miller <davem@davemloft.net>,
       Chris Wright <chrisw@sous-sol.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 2/3] IPV6 ADDRCONF: Fix default source address selection without CONFIG_IPV6_PRIVACY
Message-ID: <20060713221038.GC13275@kroah.com>
References: <20060713220455.715461301@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="ipv6-addrconf-fix-default-source-address-selection-without-config_ipv6_privacy.patch"
In-Reply-To: <20060713221008.GA13275@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------

From: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>

We need to update hiscore.rule even if we don't enable CONFIG_IPV6_PRIVACY,
because we have more less significant rule; longest match.

Signed-off-by: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
Signed-off-by: David S Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 net/ipv6/addrconf.c |    3 +++
 1 file changed, 3 insertions(+)

--- linux-2.6.16.22.orig/net/ipv6/addrconf.c
+++ linux-2.6.16.22/net/ipv6/addrconf.c
@@ -1065,6 +1065,9 @@ int ipv6_dev_get_saddr(struct net_device
 				if (hiscore.attrs & IPV6_SADDR_SCORE_PRIVACY)
 					continue;
 			}
+#else
+			if (hiscore.rule < 7)
+				hiscore.rule++;
 #endif
 			/* Rule 8: Use longest matching prefix */
 			if (hiscore.rule < 8) {

--
