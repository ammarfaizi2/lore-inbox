Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266206AbUFUMRd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266206AbUFUMRd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 08:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266208AbUFUMRd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 08:17:33 -0400
Received: from mx1.redhat.com ([66.187.233.31]:27335 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266206AbUFUMRb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 08:17:31 -0400
Date: Mon, 21 Jun 2004 08:16:47 -0400
From: Alan Cox <alan@redhat.com>
To: perex@suse.cz, akpm@osdl.org, linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au
Subject: PATCH: Dell laptop lockup fix for ALSA
Message-ID: <20040621121647.GA16714@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OSS avoids the Dell lockup by not hitting the problem register (which 
apparently breaks resume on a Sony laptop). ALSA keeps a flag and uses
pci subvendor info to clear it for problem Dell laptops. Unfortunately
there is at least one other Dell laptop which is affected. This adds
its sub id's

[Patch from Dan Williams @ Red Hat slightly reformatted by me]


--- sound/pci/nm256/nm256.c	2004-06-14 14:11:34.000000000 +0100
+++ /tmp/nm256.c	2004-06-21 12:08:49.099484448 +0100
@@ -1509,6 +1509,10 @@
 		/* this workaround will cause lock-up after suspend/resume on Sony PCG-F305 */
 		chip->latitude_workaround = 0;
 	}
+	if (subsystem_vendor == 0x1028 && subsystem_device == 0x0080) {
+		/* this workaround will cause lock-up after suspend/resume on Sony PCG-F305 */
+		chip->latitude_workaround = 0;
+	}
 
 	snd_nm256_init_chip(chip);
 



      Developer's Certificate of Origin 1.0
 
        By making a contribution to this project, I certify that:
 
        (a) The contribution was created in whole or in part by me and I
            have the right to submit it under the open source license
            indicated in the file; or
 
        (b) The contribution is based upon previous work that, to the best
            of my knowledge, is covered under an appropriate open source
            license and I have the right under that license to submit that
            work with modifications, whether created in whole or in part
            by me, under the same open source license (unless I am
            permitted to submit under a different license), as indicated
            in the file; or
 
        (c) The contribution was provided directly to me by some other
            person who certified (a), (b) or (c) and I have not modified
            it.


Signed-off-by: Alan Cox <alan@redhat.com>

