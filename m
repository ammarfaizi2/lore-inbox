Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161406AbWJKV0b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161406AbWJKV0b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161415AbWJKVGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:06:33 -0400
Received: from mail.kroah.org ([69.55.234.183]:61343 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161414AbWJKVGV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:06:21 -0400
Date: Wed, 11 Oct 2006 14:05:20 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Stephen Hemminger <shemminger@osdl.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 21/67] sky2: tx pause bug fix
Message-ID: <20061011210520.GV16627@kroah.com>
References: <20061011204756.642936754@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="sky2-tx-pause-bug-fix.patch"
In-Reply-To: <20061011210310.GA16627@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Stephen Hemminger <shemminger@osdl.org>

The sky2 driver will hang if transmit flow control is enabled
and it receives a pause frame. The pause frame gets partially
processed by hardware but never makes it through to the correct
logic. This patch made it into 2.6.17 stable, but never got
accepted for 2.6.18, so it will have to go into 2.6.18.1

See also: http://bugzilla.kernel.org/show_bug.cgi?id=6839

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/net/sky2.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.18.orig/drivers/net/sky2.h
+++ linux-2.6.18/drivers/net/sky2.h
@@ -1566,7 +1566,7 @@ enum {
 
 	GMR_FS_ANY_ERR	= GMR_FS_RX_FF_OV | GMR_FS_CRC_ERR |
 			  GMR_FS_FRAGMENT | GMR_FS_LONG_ERR |
-		  	  GMR_FS_MII_ERR | GMR_FS_BAD_FC | GMR_FS_GOOD_FC |
+		  	  GMR_FS_MII_ERR | GMR_FS_BAD_FC |
 			  GMR_FS_UN_SIZE | GMR_FS_JABBER,
 };
 

--
