Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261617AbULBNNh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261617AbULBNNh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 08:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261610AbULBNNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 08:13:15 -0500
Received: from anor.ics.muni.cz ([147.251.4.35]:50386 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id S261608AbULBNMi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 08:12:38 -0500
Date: Thu, 2 Dec 2004 14:12:25 +0100
From: Jan Kasprzak <kas@fi.muni.cz>
To: Arnd Bergmann <arnd@arndb.de>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cosa.h ioctl numbers
Message-ID: <20041202131224.GI11992@fi.muni.cz>
References: <20041202124456.GF11992@fi.muni.cz> <200412021358.00844.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412021358.00844.arnd@arndb.de>
User-Agent: Mutt/1.4.2i
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann wrote:
: >  /* Write the block to the device memory (i.e. download the microcode) */
: > -#define COSAIODOWNLD	_IOW('C',0xf2, struct cosa_download)
: > +#define COSAIODOWNLD	_IOW('C',0xf2, struct cosa_download *)
: 
: Isn't that rather misleading? I suppose the real argument is 
: 'struct cosa_download', so you should have some kind of comment there, 
: e.g.
: 
: #define COSAIODOWNLD _IOW('C',0xf2, long) /* actually struct cosa_download */

	Well, the third argument of ioctl(2) is of type
struct cosa_download *.

	OK, second try with comments added.

Signed-off-by: Jan "Yenya" Kasprzak <kas@fi.muni.cz>

--- linux-2.6.10-rc2/drivers/net/wan/cosa.h.orig	2004-12-02 13:34:24.142501564 +0100
+++ linux-2.6.10-rc2/drivers/net/wan/cosa.h	2004-12-02 14:09:23.000860524 +0100
@@ -76,10 +76,16 @@
 #define COSAIOSTRT	_IOW('C',0xf1, int)
 
 /* Read the block from the device memory */
-#define COSAIORMEM	_IOWR('C',0xf2, struct cosa_download)
+#define COSAIORMEM	_IOWR('C',0xf2, struct cosa_download *)
+	/* actually the struct cosa_download itself; this is to keep
+	 * the ioctl number same as in 2.4 in order to keep the user-space
+	 * utils compatible. */
 
 /* Write the block to the device memory (i.e. download the microcode) */
-#define COSAIODOWNLD	_IOW('C',0xf2, struct cosa_download)
+#define COSAIODOWNLD	_IOW('C',0xf2, struct cosa_download *)
+	/* actually the struct cosa_download itself; this is to keep
+	 * the ioctl number same as in 2.4 in order to keep the user-space
+	 * utils compatible. */
 
 /* Read the device type (one of "srp", "cosa", and "cosa8" for now) */
 #define COSAIORTYPE	_IOR('C',0xf3, char *)


-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
> Whatever the Java applications and desktop dances may lead to, Unix will <
> still be pushing the packets around for a quite a while.      --Rob Pike <
