Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750922AbWCYE2j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750922AbWCYE2j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 23:28:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750968AbWCYE2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 23:28:35 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:13501
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1750862AbWCYE2Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 23:28:25 -0500
Date: Fri, 24 Mar 2006 20:28:04 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org, pazke@donpac.ru,
       minyard@acm.org, mm-commits@vger.kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 20/20] DMI: fix DMI onboard device discovery
Message-ID: <20060325042804.GU21260@kroah.com>
References: <20060325041355.180237000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="dmi-fix-dmi-onboard-device-discovery.patch"
In-Reply-To: <20060325042556.GA21260@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Andrey Panin <pazke@donpac.ru>

Attached patch fixes invalid pointer arithmetic in DMI code to make onboard
device discovery working again.

akpm: bug has been present since dmi_find_device() was added in 2.6.14. 
Affects ipmi only (I think) - the symptoms weren't described.

akpm: changed to use pointer arithmetic rather than open-coded sizeof.

Signed-off-by: Andrey Panin <pazke@donpac.ru>
Cc: Corey Minyard <minyard@acm.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 arch/i386/kernel/dmi_scan.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.16.orig/arch/i386/kernel/dmi_scan.c
+++ linux-2.6.16/arch/i386/kernel/dmi_scan.c
@@ -106,7 +106,7 @@ static void __init dmi_save_devices(stru
 	struct dmi_device *dev;
 
 	for (i = 0; i < count; i++) {
-		char *d = ((char *) dm) + (i * 2);
+		char *d = (char *)(dm + 1) + (i * 2);
 
 		/* Skip disabled device */
 		if ((*d & 0x80) == 0)

--
