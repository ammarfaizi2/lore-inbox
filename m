Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264611AbTFAOHH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 10:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264613AbTFAOHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 10:07:07 -0400
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:33229 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S264611AbTFAOHG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 10:07:06 -0400
Message-ID: <3EDA0B4E.504@pacbell.net>
Date: Sun, 01 Jun 2003 07:18:54 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
CC: greg@kroah.com, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [2.5 patch] let USB_GADGET depend on USB
References: <20030531221855.GM29425@fs.tum.de> <3ED93D30.4070704@pacbell.net> <20030601111303.GV29425@fs.tum.de>
Content-Type: multipart/mixed;
 boundary="------------070002040102060503000006"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070002040102060503000006
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Adrian Bunk wrote:
> On Sat, May 31, 2003 at 04:39:28PM -0700, David Brownell wrote:
> 
>>Adrian Bunk wrote:
>>
>>>USB_GADGET is still selectable even with USB disabled. It seems the 
>>>following is intended:
>>
>>This is wrong.
>>
>>CONFIG_USB has always represented the master/host side ... while
>>CONFIG_USB_GADGET represents just the slave/gadget side.
>>
>>The two are completely independent.  Hardware that supports
>>one will typically _not_ support the other.  And systems
>>that support [only] the slave/gadget side will have no use at all
>>for the 100KB+ of "usbcore".
>>...
> 
> 
> Well, CONFIG_USB_GADGET without CONFIG_USB gives me the following link 
> error in 2.5.70-mm3:

As I had already said (in response to your email that reported
that problem), the fix is to revert the recent changeset that
links gadget code twice.  Here's a patch that undoes it.

- Dave


--------------070002040102060503000006
Content-Type: text/plain;
 name="link.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="link.patch"

--- a/drivers/usb/Makefile	Sun Jun  1 07:14:50 2003
+++ b/drivers/usb/Makefile	Sun Jun  1 07:14:50 2003
@@ -59,6 +59,3 @@
 obj-$(CONFIG_USB_TIGL)		+= misc/
 obj-$(CONFIG_USB_USS720)	+= misc/
 
-obj-$(CONFIG_USB_NET2280)	+= gadget/
-obj-$(CONFIG_USB_ZERO)		+= gadget/
-obj-$(CONFIG_USB_ETH)		+= gadget/

--------------070002040102060503000006--

