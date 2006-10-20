Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946835AbWJTCa4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946835AbWJTCa4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 22:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946838AbWJTCa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 22:30:56 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:54304 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1946835AbWJTCa4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 22:30:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id:from;
        b=JPS4iI8rY2E9dXgamr+lA8yZx1N9DITBi+LwHiJfeP14+JuimMoWf+kkSs011G3+FnfoURJSmRzzWqRgprf8Tf27xA1V4RMWR1glVGgv5sdYjuDoDnCrYKAERCteVmrgeQ7OvhNkdjw0UgTZc/0vdxmmHZe8Jxdyz0VDhmo9d40=
To: kernel-janitors@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Fixed iSeries code to use time_after instead of jiffy
Date: Thu, 19 Oct 2006 19:30:26 -0700
User-Agent: KMail/1.9.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200610191930.27092.karhudever@gmial.com>
From: David KOENIG <karhudever@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From 3bfab05309e8f5420e7897da214ad165f5566055 Mon Sep 17 00:00:00 2001
From: David KOENIG <karhudever@gmail.com>
Date: Thu, 19 Oct 2006 19:28:18 -0700
Subject: [PATCH] Fixed iSeries code to use time_after instead of jiffy 
comparisons
---
 arch/powerpc/platforms/iseries/pci.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/iseries/pci.c 
b/arch/powerpc/platforms/iseries/pci.c
index 4aa165e..b17fd12 100644
--- a/arch/powerpc/platforms/iseries/pci.c
+++ b/arch/powerpc/platforms/iseries/pci.c
@@ -19,6 +19,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  */
+#include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/string.h>
@@ -457,7 +458,7 @@ static u8 iSeries_Read_Byte(const volati
 		static unsigned long last_jiffies;
 		static int num_printed;
 
-		if ((jiffies - last_jiffies) > 60 * HZ) {
+		if (time_after(jiffies, last_jiffies + 60 * HZ)) {
 			last_jiffies = jiffies;
 			num_printed = 0;
 		}
@@ -485,7 +486,7 @@ static u16 iSeries_Read_Word(const volat
 		static unsigned long last_jiffies;
 		static int num_printed;
 
-		if ((jiffies - last_jiffies) > 60 * HZ) {
+		if (time_after(jiffies, last_jiffies + 60 * HZ)) {
 			last_jiffies = jiffies;
 			num_printed = 0;
 		}
@@ -514,7 +515,7 @@ static u32 iSeries_Read_Long(const volat
 		static unsigned long last_jiffies;
 		static int num_printed;
 
-		if ((jiffies - last_jiffies) > 60 * HZ) {
+		if (time_after(jiffies, last_jiffies + 60 * HZ)) {
 			last_jiffies = jiffies;
 			num_printed = 0;
 		}
@@ -550,7 +551,7 @@ static void iSeries_Write_Byte(u8 data, 
 		static unsigned long last_jiffies;
 		static int num_printed;
 
-		if ((jiffies - last_jiffies) > 60 * HZ) {
+		if (time_after(jiffies, last_jiffies + 60 * HZ)) {
 			last_jiffies = jiffies;
 			num_printed = 0;
 		}
@@ -576,7 +577,7 @@ static void iSeries_Write_Word(u16 data,
 		static unsigned long last_jiffies;
 		static int num_printed;
 
-		if ((jiffies - last_jiffies) > 60 * HZ) {
+		if (time_after(jiffies, last_jiffies + 60 * HZ)) {
 			last_jiffies = jiffies;
 			num_printed = 0;
 		}
@@ -602,7 +603,7 @@ static void iSeries_Write_Long(u32 data,
 		static unsigned long last_jiffies;
 		static int num_printed;
 
-		if ((jiffies - last_jiffies) > 60 * HZ) {
+		if (time_after(jiffies, last_jiffies + 60 * HZ)) {
 			last_jiffies = jiffies;
 			num_printed = 0;
 		}
-- 
1.4.1


-- 
<>< karhudever@gmail.com
