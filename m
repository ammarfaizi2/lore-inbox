Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932234AbWFGOB2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbWFGOB2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 10:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932232AbWFGOB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 10:01:28 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:63158 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932221AbWFGOB1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 10:01:27 -0400
Date: Wed, 7 Jun 2006 16:00:45 +0200
From: Pavel Machek <pavel@suse.cz>
To: linville@tuxdriver.com, kernel list <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org, Jirka Lenost Benc <jbenc@suse.cz>
Subject: [patch] workaround zd1201 interference problem
Message-ID: <20060607140045.GB1936@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

zd1201 likes to start up shouting, interfering with all wifis in
range. It is capable of stopping ipw2200 up-to few meters away, and
stops other cards at smaller distances, too.

This works around it. Only forcing ZD1201_CMDCODE_DISABLE is not
enough to prevent interference.

From: Jirka Benc <jbenc@suse.cz>
Signed-off-by: Pavel Machek <pavel@suse.cz>


--- linux-good/drivers/net/wireless/zd1201.c	2006-03-30 13:51:58.000000000 +0200
+++ linux/drivers/net/wireless/zd1201.c	2006-06-07 15:55:01.000000000 +0200
@@ -1835,6 +1835,8 @@
 	    zd->dev->name);
 	
 	usb_set_intfdata(interface, zd);
+	zd1201_enable(zd);	/* zd1201 likes to startup shouting, interfering */
+	zd1201_disable(zd); 	/* with all the wifis in range */
 	return 0;
 
 err_net:

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
