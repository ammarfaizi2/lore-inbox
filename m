Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261619AbVEYX7N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261619AbVEYX7N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 19:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261620AbVEYX7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 19:59:13 -0400
Received: from pilet.ens-lyon.fr ([140.77.167.16]:29348 "EHLO
	relaissmtp.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S261619AbVEYX6x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 19:58:53 -0400
Message-ID: <42951138.1090404@ens-lyon.fr>
Date: Thu, 26 May 2005 01:58:48 +0200
From: Brice Goglin <Brice.Goglin@ens-lyon.fr>
Reply-To: Brice.Goglin@ens-lyon.org
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Alexandre Buisse <alexandre.buisse@ens-lyon.fr>,
       linux-kernel@vger.kernel.org, pcaulfie@redhat.com, teigland@redhat.com
Subject: Re: dlm-lockspaces-callbacks-directory-fix.patch added to -mm tree
References: <200505252249.j4PMnN4q021004@shell0.pdx.osdl.net>	<4294F718.8040107@ens-lyon.fr> <20050525162318.511cdc9b.akpm@osdl.org>
In-Reply-To: <20050525162318.511cdc9b.akpm@osdl.org>
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/mixed;
 boundary="------------080202070708010107070603"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080202070708010107070603
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Andrew Morton a écrit :
> Alexandre Buisse <alexandre.buisse@ens-lyon.fr> wrote:
> 
>>I just noticed that the line 'extern const int
>>dlm_lvb_operations[8][8];' had been removed in the inline patch you just
>>mailed.
> 
> 
> ?  I see not such removal.

Looks like Alexandre's patch was damaged by mistake.
An 'extern' appeared in the removed part of lvb_table.h
I guess the patch didn't actually apply to your tree.
This would explain why the lvb_table.h part of the version
you commited to -mm is different.

The attached patch should be good.

Note that dlm_lvb_operations is kept exported in lvb_table.h
so that drivers/dlm/device.c uses it. That was the point of
Alexandre's initial bug report: dlm_lvm_operations was defined
twice when both DLM and DLM_DEVICE are set.

Brice

--------------080202070708010107070603
Content-Type: text/x-patch;
 name="fix-dlm-extern-lvb_table.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-dlm-extern-lvb_table.patch"

--- linux-2.6.12-rc5-mm1/drivers/dlm/lvb_table.h.old	2005-05-25 23:30:34.000000000 +0200
+++ linux-2.6.12-rc5-mm1/drivers/dlm/lvb_table.h	2005-05-25 23:32:35.000000000 +0200
@@ -13,26 +13,7 @@
 #ifndef __LVB_TABLE_DOT_H__
 #define __LVB_TABLE_DOT_H__
 
-/*
- * This defines the direction of transfer of LVB data.
- * Granted mode is the row; requested mode is the column.
- * Usage: matrix[grmode+1][rqmode+1]
- * 1 = LVB is returned to the caller
- * 0 = LVB is written to the resource
- * -1 = nothing happens to the LVB
- */
-
-const int dlm_lvb_operations[8][8] = {
-        /* UN   NL  CR  CW  PR  PW  EX  PD*/
-        {  -1,  1,  1,  1,  1,  1,  1, -1 }, /* UN */
-        {  -1,  1,  1,  1,  1,  1,  1,  0 }, /* NL */
-        {  -1, -1,  1,  1,  1,  1,  1,  0 }, /* CR */
-        {  -1, -1, -1,  1,  1,  1,  1,  0 }, /* CW */
-        {  -1, -1, -1, -1,  1,  1,  1,  0 }, /* PR */
-        {  -1,  0,  0,  0,  0,  0,  1,  0 }, /* PW */
-        {  -1,  0,  0,  0,  0,  0,  0,  0 }, /* EX */
-        {  -1,  0,  0,  0,  0,  0,  0,  0 }  /* PD */
-};
+extern const int dlm_lvb_operations[8][8];
 
 #endif
 

--------------080202070708010107070603--
