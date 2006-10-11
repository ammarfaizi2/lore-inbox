Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161458AbWJKVKO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161458AbWJKVKO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161448AbWJKVKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:10:10 -0400
Received: from mail.kroah.org ([69.55.234.183]:22435 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161440AbWJKVJJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:09:09 -0400
Date: Wed, 11 Oct 2006 14:08:40 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, geert@linux-m68k.org, adaplas@pol.net,
       jurij@wooyd.org, Willy Tarreau <w@1wt.eu>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 59/67] fbdev: correct buffer size limit in fbmem_read_proc()
Message-ID: <20061011210840.GH16627@kroah.com>
References: <20061011204756.642936754@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="fbdev-correct-buffer-size-limit-in-fbmem_read_proc.patch"
In-Reply-To: <20061011210310.GA16627@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Geert Uytterhoeven <geert@linux-m68k.org>

Address http://bugzilla.kernel.org/show_bug.cgi?id=7189

It should check `clen', not `len'.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: <jurij@wooyd.org>
Cc: "Antonino A. Daplas" <adaplas@pol.net>
Cc: Willy Tarreau <w@1wt.eu>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


---
 drivers/video/fbmem.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.18.orig/drivers/video/fbmem.c
+++ linux-2.6.18/drivers/video/fbmem.c
@@ -554,7 +554,8 @@ static int fbmem_read_proc(char *buf, ch
 	int clen;
 
 	clen = 0;
-	for (fi = registered_fb; fi < &registered_fb[FB_MAX] && len < 4000; fi++)
+	for (fi = registered_fb; fi < &registered_fb[FB_MAX] && clen < 4000;
+	     fi++)
 		if (*fi)
 			clen += sprintf(buf + clen, "%d %s\n",
 				        (*fi)->node,

--
