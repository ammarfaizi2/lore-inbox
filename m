Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264777AbUEPScS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264777AbUEPScS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 14:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264779AbUEPScS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 14:32:18 -0400
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:4856 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S264777AbUEPScP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 14:32:15 -0400
Message-ID: <40A7B2CE.2050409@pacbell.net>
Date: Sun, 16 May 2004 11:28:30 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Greg KH <greg@kroah.com>, akpm@osdl.org,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] [BK PATCH] USB changes for 2.6.6
References: <20040514224516.GA16814@kroah.com> <20040515113251.GA27011@suse.de> <Pine.LNX.4.58.0405151034500.10718@ppc970.osdl.org> <40A7AA0B.5000200@pacbell.net> <Pine.LNX.4.58.0405161101160.25502@ppc970.osdl.org> <40A7AF6D.6060304@pacbell.net> <Pine.LNX.4.58.0405161120420.25502@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0405161120420.25502@ppc970.osdl.org>
Content-Type: multipart/mixed;
 boundary="------------020302090507000404010106"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020302090507000404010106
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Linus Torvalds wrote:
> 
> On Sun, 16 May 2004, David Brownell wrote:
> 
>>More like this then?  I'm not sure whether you'd prefer
>>to apply that logic to the "struct pm_info" innards too.
>>That file has multiple CONFIG_PM sections, too.
> 
> 
> I was thinking just putting it in the existing wrapper sections.

Wouldn't quite work without moving "struct pm_info" up higher
in the file.  Seems like that stuff still isn't fully sorted
out yet, this may not be the best time to start.


> The alternative is to just always have "power_state" in the "dev_pm_info", 
> especially as some versions of gcc have had bugs with empty structures 
> anyway.

That sounds like a much simpler fix.

- Dave




--------------020302090507000404010106
Content-Type: text/plain;
 name="Diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Diff"

--- 1.13/include/linux/pm.h	Thu Aug 21 11:47:27 2003
+++ edited/include/linux/pm.h	Sun May 16 11:24:38 2004
@@ -229,8 +229,8 @@
 struct device;
 
 struct dev_pm_info {
-#ifdef	CONFIG_PM
 	u32			power_state;
+#ifdef	CONFIG_PM
 	u8			* saved_state;
 	atomic_t		pm_users;
 	struct device		* pm_parent;

--------------020302090507000404010106--


