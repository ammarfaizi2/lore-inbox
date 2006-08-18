Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030193AbWHRMqk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030193AbWHRMqk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 08:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030194AbWHRMqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 08:46:40 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:3752 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S1030193AbWHRMqj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 08:46:39 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: [TTY] Remove bogus call to cdev_del()
Date: Fri, 18 Aug 2006 14:46:51 +0200
User-Agent: KMail/1.9.4
Cc: "Jonathan Corbet" <corbet@lwn.net>,
       "Alexey Dobriyan" <adobriyan@gmail.com>,
       "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060817212248.19853.qmail@lwn.net> <200608180915.28763.eike-kernel@sf-tec.de> <d120d5000608180532j453bf0f3l2ee88b0502c20cfd@mail.gmail.com>
In-Reply-To: <d120d5000608180532j453bf0f3l2ee88b0502c20cfd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608181446.52076.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When cdev_add() failed there is no reason to call cdev_del().

Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>

---
commit d31aa8d2f27346fe0663bd9675185c649d5d9801
tree 67f30f1547f19eb2bc0961abf5b4e2f35834ed41
parent f6272846a16df0c7acb5c1701c0acdee0b472047
author Rolf Eike Beer <eike-kernel@sf-tec.de> Fri, 18 Aug 2006 14:45:01 +0200
committer Rolf Eike Beer <beer@siso-eb-i34d.silicon-software.de> Fri, 18 Aug 2006 14:45:01 +0200

 drivers/char/tty_io.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/char/tty_io.c b/drivers/char/tty_io.c
index bfdb902..d6e4eaa 100644
--- a/drivers/char/tty_io.c
+++ b/drivers/char/tty_io.c
@@ -3094,7 +3094,6 @@ int tty_register_driver(struct tty_drive
 	driver->cdev.owner = driver->owner;
 	error = cdev_add(&driver->cdev, dev, driver->num);
 	if (error) {
-		cdev_del(&driver->cdev);
 		unregister_chrdev_region(dev, driver->num);
 		driver->ttys = NULL;
 		driver->termios = driver->termios_locked = NULL;
