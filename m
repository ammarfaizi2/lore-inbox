Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267445AbUI1BFt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267445AbUI1BFt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 21:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267446AbUI1BFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 21:05:49 -0400
Received: from peabody.ximian.com ([130.57.169.10]:15273 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S267445AbUI1BFr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 21:05:47 -0400
Subject: [patch] inotify: silly fix
From: Robert Love <rml@novell.com>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: linux-kernel@vger.kernel.org, gamin-list@gnome.org,
       viro@parcelfarce.linux.theplanet.co.uk, akpm@osdl.org, iggy@gentoo.org
In-Reply-To: <1096250524.18505.2.camel@vertex>
References: <1096250524.18505.2.camel@vertex>
Content-Type: multipart/mixed; boundary="=-TZw8L753wrVfDYIQsCAj"
Date: Mon, 27 Sep 2004 21:05:51 -0400
Message-Id: <1096333551.5103.133.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-TZw8L753wrVfDYIQsCAj
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2004-09-26 at 22:02 -0400, John McCutchan wrote:

John,

> Announcing the release of inotify 0.10.0. 
> Attached is a patch to 2.6.8.1.

John, as Andrew pointed out, we are missing some braces in an
inopportune location.  I think we need to refactor this code entirely,
to remove the access_ok() checks and use copy_{to,from}_user(), but we
can take this in the meantime since the patch is dead without it.

I'll take paper, please.  One brown paper bag right over my head.

	Robert Love


--=-TZw8L753wrVfDYIQsCAj
Content-Disposition: attachment; filename=inotify-rml-typo-1.patch
Content-Type: text/x-patch; name=inotify-rml-typo-1.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

ARE WE SERIOUS?

Signed-Off-By: Robert Love <rml@novell.com>

 drivers/char/inotify.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -urN linux-inotify/drivers/char/inotify.c linux/drivers/char/inotify.c
--- linux-inotify/drivers/char/inotify.c	2004-09-25 15:23:10.000000000 -0400
+++ linux/drivers/char/inotify.c	2004-09-27 21:00:48.455011760 -0400
@@ -970,9 +970,10 @@
 	if (_IOC_DIR(cmd) & _IOC_READ)
 		err = !access_ok(VERIFY_READ, (void *) arg, _IOC_SIZE(cmd));
 
-	if (err)
+	if (err) {
 		err = -EFAULT;
 		goto out;
+	}
 
 	if (_IOC_DIR(cmd) & _IOC_WRITE)
 		err = !access_ok(VERIFY_WRITE, (void *)arg, _IOC_SIZE(cmd));

--=-TZw8L753wrVfDYIQsCAj--

