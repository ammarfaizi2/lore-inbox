Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750991AbWDEACQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbWDEACQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 20:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750989AbWDEACN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 20:02:13 -0400
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:48066
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1750977AbWDEABu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 20:01:50 -0400
Date: Tue, 4 Apr 2006 17:01:03 -0700
From: gregkh@suse.de
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       jketreno@linux.intel.com, yi.zhu@intel.com,
       Adrian Bunk <bunk@stusta.de>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 20/26] drivers/net/wireless/ipw2200.c: fix an array overun
Message-ID: <20060405000103.GU27049@kroah.com>
References: <20060404235634.696852000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="drivers-net-wireless-ipw2200.c-fix-an.patch"
In-Reply-To: <20060404235927.GA27049@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a big array overun found by the Coverity checker.

This was already fixed in Linus' tree.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/net/wireless/ipw2200.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- linux-2.6.16.1.orig/drivers/net/wireless/ipw2200.c
+++ linux-2.6.16.1/drivers/net/wireless/ipw2200.c
@@ -9956,9 +9956,8 @@ static int ipw_ethtool_set_eeprom(struct
 		return -EINVAL;
 	down(&p->sem);
 	memcpy(&p->eeprom[eeprom->offset], bytes, eeprom->len);
-	for (i = IPW_EEPROM_DATA;
-	     i < IPW_EEPROM_DATA + IPW_EEPROM_IMAGE_SIZE; i++)
-		ipw_write8(p, i, p->eeprom[i]);
+	for (i = 0; i < IPW_EEPROM_IMAGE_SIZE; i++)
+		ipw_write8(p, i + IPW_EEPROM_DATA, p->eeprom[i]);
 	up(&p->sem);
 	return 0;
 }

--
