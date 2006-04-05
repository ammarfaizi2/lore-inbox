Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750965AbWDEAHF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965AbWDEAHF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 20:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750966AbWDEABO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 20:01:14 -0400
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:18576
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1750959AbWDEABC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 20:01:02 -0400
Date: Tue, 4 Apr 2006 17:00:15 -0700
From: gregkh@suse.de
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       linux-pcmcia@lists.infradead.org, Janos Farkas <chexum@gmail.com>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 09/26] pcmcia: permit single-character-identifiers
Message-ID: <20060405000015.GJ27049@kroah.com>
References: <20060404235634.696852000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="pcmcia-permit-single-character-identifiers.patch"
In-Reply-To: <20060404235927.GA27049@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Janos Farkas <chexum@gmail.com>

For some time, the core pcmcia drivers seem not to think single
character prod_ids are valid, thus preventing the "cleverly" named

  "D" "Link DWL-650 11Mbps WLAN Card"

Before (as in 2.6.16):
PRODID_1=""
PRODID_2="Link DWL-650 11Mbps WLAN Card"
PRODID_3="Version 01.02"
PRODID_4=""
MANFID=0156,0002
FUNCID=6

After (with the patch)
PRODID_1="D"
PRODID_2="Link DWL-650 11Mbps WLAN Card"
PRODID_3="Version 01.02"
PRODID_4=""
MANFID=0156,0002
FUNCID=6

Signed-off-by: Janos Farkas <chexum@gmail.com>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/pcmcia/ds.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.16.1.orig/drivers/pcmcia/ds.c
+++ linux-2.6.16.1/drivers/pcmcia/ds.c
@@ -546,7 +546,7 @@ static int pcmcia_device_query(struct pc
 			tmp = vers1->str + vers1->ofs[i];
 
 			length = strlen(tmp) + 1;
-			if ((length < 3) || (length > 255))
+			if ((length < 2) || (length > 255))
 				continue;
 
 			p_dev->prod_id[i] = kmalloc(sizeof(char) * length,

--
