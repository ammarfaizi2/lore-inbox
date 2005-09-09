Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030728AbVIIWOA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030728AbVIIWOA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 18:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030726AbVIIWN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 18:13:59 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:35209 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030734AbVIIWN6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 18:13:58 -0400
Message-ID: <43220609.7090305@us.ibm.com>
Date: Fri, 09 Sep 2005 17:00:41 -0500
From: Linda Xie <lxiep@us.ibm.com>
Reply-To: lxiep@us.ibm.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; zh-CN; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, zh-cn, zh
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>, John Rose <johnrose@austin.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH]: Fix buffer overrun in rpadlpar_sysfs.c
Content-Type: multipart/mixed;
 boundary="------------060103090002030808070308"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060103090002030808070308
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Greg,

The attached patch was created against 2.6.13-git9.

Please consider it for inclusion.


Thanks,

Linda


Signed-off-by: Linda Xie <lxie@us.ibm.com>



--------------060103090002030808070308
Content-Type: text/plain;
 name="rpadlpar_sysfs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rpadlpar_sysfs.patch"

--- linux-2.6.13-git9/drivers/pci/hotplug/rpadlpar_sysfs.c	2005-08-28 18:41:01.000000000 -0500
+++ linux-2.6.13-git9-linda/drivers/pci/hotplug/rpadlpar_sysfs.c	2005-09-09 16:28:56.000000000 -0500
@@ -62,7 +62,7 @@ static ssize_t add_slot_store(struct dlp
 	char drc_name[MAX_DRC_NAME_LEN];
 	char *end;
 
-	if (nbytes > MAX_DRC_NAME_LEN)
+	if (nbytes >= MAX_DRC_NAME_LEN)
 		return 0;
 
 	memcpy(drc_name, buf, nbytes);
@@ -83,7 +83,7 @@ static ssize_t remove_slot_store(struct 
 	char drc_name[MAX_DRC_NAME_LEN];
 	char *end;
 
-	if (nbytes > MAX_DRC_NAME_LEN)
+	if (nbytes >= MAX_DRC_NAME_LEN)
 		return 0;
 
 	memcpy(drc_name, buf, nbytes);

--------------060103090002030808070308--

