Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261440AbULFBEf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261440AbULFBEf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 20:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261445AbULFBEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 20:04:35 -0500
Received: from smtpq3.home.nl ([213.51.128.198]:50835 "EHLO smtpq3.home.nl")
	by vger.kernel.org with ESMTP id S261440AbULFBE3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 20:04:29 -0500
Message-ID: <41B3B016.4010906@keyaccess.nl>
Date: Mon, 06 Dec 2004 02:04:22 +0100
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Mozilla Thunderbird 1.0RC1 (X11/20041201)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: matthieu castet <castet.matthieu@free.fr>
CC: Adam Belay <ambx1@neo.rr.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.9+] PnPBIOS: Missing SMALL_TAG_ENDDEP tag
References: <41B3A963.4090003@keyaccess.nl> <41B3ABFE.5090105@free.fr>
In-Reply-To: <41B3ABFE.5090105@free.fr>
Content-Type: multipart/mixed;
 boundary="------------020005090901020301050006"
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020005090901020301050006
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

matthieu castet wrote:

>> -            if (option_independent == option)
>> -                printk(KERN_WARNING "PnPBIOS: Missing 
>> SMALL_TAG_STARTDEP tag\n");
> 
> this one shouldn't be removed
> 
>>              option = option_independent;
>>              break;
>>  
>>          case SMALL_TAG_END:
>> -            if (option_independent != option)
>> -                printk(KERN_WARNING "PnPBIOS: Missing 
>> SMALL_TAG_ENDDEP tag\n");
> 
> ok for this one, may be change it to pnp_dbg(...)

Works for me to. Updated patch attached that only removes the missing 
ENDDEP warning.

Rene.

--------------020005090901020301050006
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

--------------020005090901020301050006--
