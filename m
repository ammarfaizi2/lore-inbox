Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965077AbWD1AXK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965077AbWD1AXK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 20:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965073AbWD1AWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 20:22:50 -0400
Received: from ns2.suse.de ([195.135.220.15]:57813 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965069AbWD1AWr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 20:22:47 -0400
Date: Thu, 27 Apr 2006 17:21:14 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org,
       git-commits-head@vger.kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Greg Howard <ghoward@sgi.com>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 16/24] Altix snsc: duplicate kobject fix
Message-ID: <20060428002114.GQ18750@kroah.com>
References: <20060428001226.204293000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="altix-snsc-duplicate-kobject-fix.patch"
In-Reply-To: <20060428001557.GA18750@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------

From: Greg Howard <ghoward@sgi.com>

Fix Altix system controller (snsc) device names to include the slot number
of the blade whose associated system controller is the target of the device
interface.  Including the slot number avoids a problem we're currently
having where slots within the same enclosure are attempting to create
multiple kobjects with identical names.

Signed-off-by: Greg Howard <ghoward@sgi.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/char/snsc.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.16.11.orig/drivers/char/snsc.c
+++ linux-2.6.16.11/drivers/char/snsc.c
@@ -391,7 +391,8 @@ scdrv_init(void)
 			format_module_id(devnamep, geo_module(geoid),
 					 MODULE_FORMAT_BRIEF);
 			devnamep = devname + strlen(devname);
-			sprintf(devnamep, "#%d", geo_slab(geoid));
+			sprintf(devnamep, "^%d#%d", geo_slot(geoid),
+				geo_slab(geoid));
 
 			/* allocate sysctl device data */
 			scd = kmalloc(sizeof (struct sysctl_data_s),

--
