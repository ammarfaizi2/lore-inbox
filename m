Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964919AbVJGXzy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964919AbVJGXzy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 19:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964933AbVJGXzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 19:55:47 -0400
Received: from mail.kroah.org ([69.55.234.183]:25558 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964919AbVJGXzY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 19:55:24 -0400
Date: Fri, 7 Oct 2005 16:54:50 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, davej@redhat.com,
       airlied@gmail.com
Subject: [patch 4/7] sysfs: Signedness problem
Message-ID: <20051007235450.GE23111@kroah.com>
References: <20051007234348.631583000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="drm-module_param-permissions-fix.patch"
In-Reply-To: <20051007235353.GA23111@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Jones <davej@redhat.com>

Please consider for next 2.6.13, it is a minor security issue allowing
users to turn on drm debugging when they shouldn't...

This fell through the cracks. Until Josh pointed me at
http://bugs.gentoo.org/show_bug.cgi?id=107893

Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/char/drm/drm_stub.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.13.y.orig/drivers/char/drm/drm_stub.c
+++ linux-2.6.13.y/drivers/char/drm/drm_stub.c
@@ -47,7 +47,7 @@ MODULE_PARM_DESC(cards_limit, "Maximum n
 MODULE_PARM_DESC(debug, "Enable debug output");
 
 module_param_named(cards_limit, drm_cards_limit, int, 0444);
-module_param_named(debug, drm_debug, int, 0666);
+module_param_named(debug, drm_debug, int, 0600);
 
 drm_head_t **drm_heads;
 struct drm_sysfs_class *drm_class;

--
