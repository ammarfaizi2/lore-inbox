Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750831AbWCYE1v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbWCYE1v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 23:27:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750853AbWCYE1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 23:27:50 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:55228
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1750847AbWCYE1n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 23:27:43 -0500
Date: Fri, 24 Mar 2006 20:27:23 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, adaplas@pol.net,
       Chris Wright <chrisw@sous-sol.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 12/20] i810fb_cursor(): use GFP_ATOMIC
Message-ID: <20060325042723.GM21260@kroah.com>
References: <20060325041355.180237000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="i810fb_cursor-use-gfp_atomic.patch"
In-Reply-To: <20060325042556.GA21260@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: "Antonino A. Daplas" <adaplas@pol.net>

The console cursor can be called in atomic context.  Change memory
allocation to use the GFP_ATOMIC flag in i810fb_cursor().

Signed-off-by: Antonino Daplas <adaplas@pol.net>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 drivers/video/i810/i810_main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.16.orig/drivers/video/i810/i810_main.c
+++ linux-2.6.16/drivers/video/i810/i810_main.c
@@ -1508,7 +1508,7 @@ static int i810fb_cursor(struct fb_info 
 		int size = ((cursor->image.width + 7) >> 3) *
 			cursor->image.height;
 		int i;
-		u8 *data = kmalloc(64 * 8, GFP_KERNEL);
+		u8 *data = kmalloc(64 * 8, GFP_ATOMIC);
 
 		if (data == NULL)
 			return -ENOMEM;

--
