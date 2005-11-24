Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751382AbVKXSsg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382AbVKXSsg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 13:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbVKXSsf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 13:48:35 -0500
Received: from pilet.ens-lyon.fr ([140.77.167.16]:660 "EHLO pilet.ens-lyon.fr")
	by vger.kernel.org with ESMTP id S1751382AbVKXSse (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 13:48:34 -0500
Message-ID: <43860AEC.10200@ens-lyon.fr>
Date: Thu, 24 Nov 2005 19:48:12 +0100
From: Alexandre Buisse <alexandre.buisse@ens-lyon.fr>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051106)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc2-mm1
References: <20051123033550.00d6a6e8.akpm@osdl.org>
In-Reply-To: <20051123033550.00d6a6e8.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------000003040703000303000400"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000003040703000303000400
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:

>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc2/2.6.15-rc2-mm1/
>
>
>  
>
Hi Andrew,

I had this compilation error :


  LD      .tmp_vmlinux1
drivers/built-in.o: In function `do_uevent':
lockspace.c:(.text+0x148ae7): undefined reference to `kobject_hotplug'
lockspace.c:(.text+0x148b9e): undefined reference to `kobject_hotplug'

DLM was still using kobject_hotplug, which seems to have been removed in
-mm. Brice kindly indicated me how to fix this, in exchange for half a
signed-off, so please see the attached patch. I grep'd the whole source
and did not find any other reference to kobject_hotplug.

Regards,
Alexandre

Signed-off-by: Alexandre Buisse <alexandre.buisse@ens-lyon.fr>
Signed-off-by: Brice Goglin <brice.goglin@ens-lyon.org>

--------------000003040703000303000400
Content-Type: text/x-patch;
 name="dlm-kobject_hotplug.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dlm-kobject_hotplug.patch"

--- drivers/dlm/lockspace.c.old	2005-11-24 19:32:11.000000000 +0100
+++ drivers/dlm/lockspace.c	2005-11-24 19:39:59.000000000 +0100
@@ -157,9 +157,9 @@
 	int error;
 
 	if (in)
-		kobject_hotplug(&ls->ls_kobj, KOBJ_ONLINE);
+		kobject_uevent(&ls->ls_kobj, KOBJ_ONLINE);
 	else
-		kobject_hotplug(&ls->ls_kobj, KOBJ_OFFLINE);
+		kobject_uevent(&ls->ls_kobj, KOBJ_OFFLINE);
 
 	error = wait_event_interruptible(ls->ls_uevent_wait,
 			test_and_clear_bit(LSFL_UEVENT_WAIT, &ls->ls_flags));

--------------000003040703000303000400--
