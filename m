Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932231AbWDUEoC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbWDUEoC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 00:44:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbWDUEoB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 00:44:01 -0400
Received: from mail.kroah.org ([69.55.234.183]:39553 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932231AbWDUEoA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 00:44:00 -0400
Date: Thu, 20 Apr 2006 21:40:05 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Samuel Thibault <samuel.thibault@ens-lyon.org>,
       Jordan Crouse <jordan.crouse@amd.com>, Zachary Amsden <zach@vmware.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 20/22] apm: fix Armada laptops again
Message-ID: <20060421044005.GV12846@kroah.com>
References: <20060421043353.602539000@blue.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="apm-fix-armada-laptops-again.patch"
In-Reply-To: <20060421043706.GA12846@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Samuel Thibault <samuel.thibault@ens-lyon.org>

[PATCH] apm: fix Armada laptops again

Fix the "apm: set display: Interface not engaged" error on Armada laptops
again.

Jordan said:

  I think this is fine.  It seems to me that this may be the fault of one or
  both of the APM solutions handling this situation in a non-standard way, but
  since APM is used very little on the Geode, and I have direct access to our
  BIOS folks, if this problem comes up with a customer again, we'll solve it
  from the firmware.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: "Jordan Crouse" <jordan.crouse@amd.com>
Cc: Zachary Amsden <zach@vmware.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 arch/i386/kernel/apm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.16.9.orig/arch/i386/kernel/apm.c
+++ linux-2.6.16.9/arch/i386/kernel/apm.c
@@ -1081,7 +1081,7 @@ static int apm_console_blank(int blank)
 			break;
 	}
 
-	if (error == APM_NOT_ENGAGED && state != APM_STATE_READY) {
+	if (error == APM_NOT_ENGAGED) {
 		static int tried;
 		int eng_error;
 		if (tried++ == 0) {

--
