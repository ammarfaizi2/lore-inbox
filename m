Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751714AbWD1ATw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751714AbWD1ATw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 20:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751818AbWD1ATw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 20:19:52 -0400
Received: from mx1.suse.de ([195.135.220.2]:24537 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751823AbWD1ATs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 20:19:48 -0400
Date: Thu, 27 Apr 2006 17:18:16 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org, dsd@gentoo.org,
       mm-commits@vger.kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 07/24] tipar oops fix
Message-ID: <20060428001816.GH18750@kroah.com>
References: <20060428001226.204293000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="tipar-oops-fix.patch"
In-Reply-To: <20060428001557.GA18750@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Daniel Drake <dsd@gentoo.org>

If compiled into the kernel, parport_register_driver() is called before the
parport driver has been initalised.

This means that it is expected that tp_count is 0 after the
parport_register_driver() call() - tipar's attach function will not be
called until later during bootup.

Signed-off-by: Daniel Drake <dsd@gentoo.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/char/tipar.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.16.11.orig/drivers/char/tipar.c
+++ linux-2.6.16.11/drivers/char/tipar.c
@@ -515,7 +515,7 @@ tipar_init_module(void)
 		err = PTR_ERR(tipar_class);
 		goto out_chrdev;
 	}
-	if (parport_register_driver(&tipar_driver) || tp_count == 0) {
+	if (parport_register_driver(&tipar_driver)) {
 		printk(KERN_ERR "tipar: unable to register with parport\n");
 		err = -EIO;
 		goto out_class;

--
