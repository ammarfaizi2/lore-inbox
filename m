Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262255AbVFSPMg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262255AbVFSPMg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Jun 2005 11:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbVFSPMd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Jun 2005 11:12:33 -0400
Received: from smtp3.mail.be.easynet.net ([212.100.160.66]:65242 "EHLO
	smtp3.mail.be.easynet.net") by vger.kernel.org with ESMTP
	id S262255AbVFSPMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Jun 2005 11:12:31 -0400
Message-ID: <42B58C12.6020503@looxix.net>
Date: Sun, 19 Jun 2005 17:15:30 +0200
From: Luc Van Oostenryck <lkml@looxix.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, roms@lpg.ticalc.org
Subject: [PATCH] drivers/char/tipar.c: off by one array access
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the setupt function, the delay variable is initialized with ints[2],
but ints is declared as:
	int ints[2];

Since the module parameter should correspond to:
	tipar=timeout,delay

I suppose that the following patch fix the problem.


Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@looxix.net>

diff --git a/drivers/char/tipar.c b/drivers/char/tipar.c
--- a/drivers/char/tipar.c
+++ b/drivers/char/tipar.c
@@ -407,7 +407,7 @@ tipar_setup(char *str)
                          printk(KERN_WARNING "tipar: bad timeout value (0), "
  				"using default value instead");
  		if (ints[0] > 1) {
-			delay = ints[2];
+			delay = ints[1];
  		}
  	}



