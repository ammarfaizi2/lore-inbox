Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161101AbVLWWyy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161101AbVLWWyy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 17:54:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161113AbVLWWyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 17:54:10 -0500
Received: from mail.kroah.org ([69.55.234.183]:49103 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161102AbVLWWtZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 17:49:25 -0500
Date: Fri, 23 Dec 2005 14:47:54 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       luming.yu@gmail.com, len.brown@intel.com, trenn@suse.de,
       nacc@us.ibm.com
Subject: [patch 05/19] apci: fix NULL deref in video/lcd/brightness
Message-ID: <20051223224754.GE19057@kroah.com>
References: <20051223221200.342826000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="acpi-fix-null-deref-in-video-lcd-brightness.patch"
In-Reply-To: <20051223224712.GA18975@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Yu Luming <luming.yu@gmail.com>

Fix Null pointer deref in video/lcd/brightness
http://bugzilla.kernel.org/show_bug.cgi?id=5571

Signed-off-by: Yu Luming <luming.yu@gmail.com>
Cc: "Brown, Len" <len.brown@intel.com>
Signed-off-by: Thomas Renninger <trenn@suse.de>
Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Chris Wright <chrisw@redhat.com>
---
 drivers/acpi/video.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.14.4.orig/drivers/acpi/video.c
+++ linux-2.6.14.4/drivers/acpi/video.c
@@ -813,7 +813,7 @@ acpi_video_device_write_brightness(struc
 
 	ACPI_FUNCTION_TRACE("acpi_video_device_write_brightness");
 
-	if (!dev || count + 1 > sizeof str)
+	if (!dev || !dev->brightness || count + 1 > sizeof str)
 		return_VALUE(-EINVAL);
 
 	if (copy_from_user(str, buffer, count))

--
