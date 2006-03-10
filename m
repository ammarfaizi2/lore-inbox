Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932233AbWCJUvo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbWCJUvo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 15:51:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932239AbWCJUvo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 15:51:44 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:25739
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S932233AbWCJUvo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 15:51:44 -0500
Date: Fri, 10 Mar 2006 12:51:21 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: bluesmoke-devel@lists.sourceforge.net, Doug Thompson <dthompson@lnxi.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] disable a few edac sysfs files to avoid them becoming an ABI
Message-ID: <20060310205121.GA32170@kroah.com>
References: <1142013041.2876.86.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1142013041.2876.86.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arjan van de Ven <arjan@linux.intel.com>

the patch below disables (via ugly #if 0's) the 3 sysfs files that I
think by now we all agree are very much wrong. These files shouldn't
become part of the ABI by the 2.6.16 release, so I rather have this
minimal patch merged to disable them for now, the real fix can then come
during the 2.6.17 devel window.


Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/edac/edac_mc.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

--- gregkh-2.6.orig/drivers/edac/edac_mc.c
+++ gregkh-2.6/drivers/edac/edac_mc.c
@@ -132,11 +132,13 @@ static struct kobject edac_pci_kobj;
  * /sys/devices/system/edac/mc;
  * 	data structures and methods
  */
+#if 0
 static ssize_t memctrl_string_show(void *ptr, char *buffer)
 {
 	char *value = (char*) ptr;
 	return sprintf(buffer, "%s\n", value);
 }
+#endif
 
 static ssize_t memctrl_int_show(void *ptr, char *buffer)
 {
@@ -207,7 +209,9 @@ struct memctrl_dev_attribute attr_##_nam
 };
 
 /* cwrow<id> attribute f*/
+#if 0
 MEMCTRL_STRING_ATTR(mc_version,EDAC_MC_VERSION,S_IRUGO,memctrl_string_show,NULL);
+#endif
 
 /* csrow<id> control files */
 MEMCTRL_ATTR(panic_on_ue,S_IRUGO|S_IWUSR,memctrl_int_show,memctrl_int_store);
@@ -222,7 +226,6 @@ static struct memctrl_dev_attribute *mem
 	&attr_log_ue,
 	&attr_log_ce,
 	&attr_poll_msec,
-	&attr_mc_version,
 	NULL,
 };
 
@@ -309,6 +312,8 @@ struct list_control {
 	int *count;
 };
 
+
+#if 0
 /* Output the list as:  vendor_id:device:id<,vendor_id:device_id> */
 static ssize_t edac_pci_list_string_show(void *ptr, char *buffer)
 {
@@ -430,6 +435,7 @@ static ssize_t edac_pci_list_string_stor
 	return count;
 }
 
+#endif
 static ssize_t edac_pci_int_show(void *ptr, char *buffer)
 {
 	int *value = ptr;
@@ -498,6 +504,7 @@ struct edac_pci_dev_attribute edac_pci_a
 	.store  = _store,					\
 };
 
+#if 0
 static struct list_control pci_whitelist_control = {
 	.list = pci_whitelist,
 	.count = &pci_whitelist_count
@@ -520,6 +527,7 @@ EDAC_PCI_STRING_ATTR(pci_parity_blacklis
 	S_IRUGO|S_IWUSR,
 	edac_pci_list_string_show,
 	edac_pci_list_string_store);
+#endif
 
 /* PCI Parity control files */
 EDAC_PCI_ATTR(check_pci_parity,S_IRUGO|S_IWUSR,edac_pci_int_show,edac_pci_int_store);
@@ -531,8 +539,6 @@ static struct edac_pci_dev_attribute *ed
 	&edac_pci_attr_check_pci_parity,
 	&edac_pci_attr_panic_on_pci_parity,
 	&edac_pci_attr_pci_parity_count,
-	&edac_pci_attr_pci_parity_whitelist,
-	&edac_pci_attr_pci_parity_blacklist,
 	NULL,
 };
 
