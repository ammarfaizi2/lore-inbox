Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261654AbULFVLG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261654AbULFVLG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 16:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261650AbULFVLF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 16:11:05 -0500
Received: from smtpq2.home.nl ([213.51.128.197]:57020 "EHLO smtpq2.home.nl")
	by vger.kernel.org with ESMTP id S261656AbULFVEj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 16:04:39 -0500
Message-ID: <41B4C95D.7030507@keyaccess.nl>
Date: Mon, 06 Dec 2004 22:04:29 +0100
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Mozilla Thunderbird 1.0RC1 (X11/20041201)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adam Belay <ambx1@neo.rr.com>
CC: Matthieu Castet <castet.matthieu@free.fr>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.9+] PnPBIOS: Missing SMALL_TAG_ENDDEP tag
References: <41B3A963.4090003@keyaccess.nl> <20041206024218.GD3103@neo.rr.com> <41B3CCA6.1060507@keyaccess.nl> <20041206165929.GE3103@neo.rr.com>
In-Reply-To: <20041206165929.GE3103@neo.rr.com>
Content-Type: multipart/mixed;
 boundary="------------070906050703070709000707"
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070906050703070709000707
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Adam Belay wrote:

> I appreciate the additional information.  I looked through the binary files
> manually and confirmed that they are missing an end-dep tag.  It should be
> harmless however.  I think the error message needs to be debug or it could 
> be removed.

As far as I'm concerned, making it debug is not too useful. I normally 
have pnp debug enabled but not to debug my BIOS.

Hence attachment. Could you push it on yourself if you agree? Thanks...

Rene.



--------------070906050703070709000707
Content-Type: text/x-patch;
 name="linux-2.6.10-rc3_rsparser2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.10-rc3_rsparser2.diff"

--- linux-2.6.10-rc3.orig/drivers/pnp/pnpbios/rsparser.c	2004-12-04 03:10:03.000000000 +0100
+++ linux-2.6.10-rc3/drivers/pnp/pnpbios/rsparser.c	2004-12-06 01:59:44.000000000 +0100
@@ -439,11 +439,7 @@
 			break;
 
 		case SMALL_TAG_END:
-			if (option_independent != option)
-				printk(KERN_WARNING "PnPBIOS: Missing SMALL_TAG_ENDDEP tag\n");
-			p = p + 2;
-        		return (unsigned char *)p;
-			break;
+        		return p + 2;
 
 		default: /* an unkown tag */
 			len_err:

--------------070906050703070709000707--
