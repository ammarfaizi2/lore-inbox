Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965169AbWD1AYu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965169AbWD1AYu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 20:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965037AbWD1AYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 20:24:10 -0400
Received: from ns2.suse.de ([195.135.220.15]:8406 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965068AbWD1AYD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 20:24:03 -0400
Date: Thu, 27 Apr 2006 17:22:23 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org, jgarzik@pobox.com
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       netdev@vger.kernel.org, jesse.brandeburg@intel.com,
       john.ronciak@intel.com, Jeffrey.t.kirsher@intel.com,
       auke@foo-projects.org, davem@davemloft.net,
       Auke Kok <auke-jan.h.kok@intel.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 20/24] NET: e1000: Update truesize with the length of the packet for packet split
Message-ID: <20060428002223.GU18750@kroah.com>
References: <20060428001226.204293000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="net-e1000-update-truesize-with-the-length-of-the-packet-for-packet-split.patch"
In-Reply-To: <20060428001557.GA18750@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------

Update skb with the real packet size.


Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Signed-off-by: Auke Kok <auke-jan.h.kok@intel.com>
Signed-off-by: John Ronciak <john.ronciak@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/net/e1000/e1000_main.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.16.11.orig/drivers/net/e1000/e1000_main.c
+++ linux-2.6.16.11/drivers/net/e1000/e1000_main.c
@@ -3851,6 +3851,7 @@ e1000_clean_rx_irq_ps(struct e1000_adapt
 			skb_shinfo(skb)->nr_frags++;
 			skb->len += length;
 			skb->data_len += length;
+			skb->truesize += length;
 		}
 
 		e1000_rx_checksum(adapter, staterr,

--
