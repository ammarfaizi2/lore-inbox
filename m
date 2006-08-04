Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030331AbWHDFvq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030331AbWHDFvq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 01:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030339AbWHDFvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 01:51:41 -0400
Received: from ns.suse.de ([195.135.220.2]:56804 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030323AbWHDFng (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 01:43:36 -0400
Date: Thu, 3 Aug 2006 22:38:59 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       "Mark M. Hoffman" <mhoffman@lightlink.com>,
       Jean Delvare <khali@linux-fr.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 06/23] i2c: Fix ignore module parameter handling in i2c-core
Message-ID: <20060804053859.GG769@kroah.com>
References: <20060804053258.391158155@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="i2c-03-fix-ignore-module-parameter-handling.patch"
In-Reply-To: <20060804053807.GA769@kroah.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: "Mark M. Hoffman" <mhoffman@lightlink.com>

This patch fixes a bug in the handling of 'ignore' module parameters of I2C
client drivers.

Signed-off-by: Mark M. Hoffman <mhoffman@lightlink.com>
Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/i2c/i2c-core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.17.7.orig/drivers/i2c/i2c-core.c
+++ linux-2.6.17.7/drivers/i2c/i2c-core.c
@@ -756,9 +756,9 @@ int i2c_probe(struct i2c_adapter *adapte
 					"parameter for adapter %d, "
 					"addr 0x%02x\n", adap_id,
 					address_data->ignore[j + 1]);
+				ignore = 1;
+				break;
 			}
-			ignore = 1;
-			break;
 		}
 		if (ignore)
 			continue;

--
