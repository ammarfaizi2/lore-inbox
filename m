Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274124AbSITAwe>; Thu, 19 Sep 2002 20:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274209AbSITAv0>; Thu, 19 Sep 2002 20:51:26 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:41738 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S274205AbSITAvL>;
	Thu, 19 Sep 2002 20:51:11 -0400
Date: Thu, 19 Sep 2002 17:55:55 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: Re: [BK PATCH] PCI hotplug changes for 2.5.36
Message-ID: <20020920005555.GF18583@kroah.com>
References: <20020920005408.GA18583@kroah.com> <20020920005428.GB18583@kroah.com> <20020920005444.GC18583@kroah.com> <20020920005500.GD18583@kroah.com> <20020920005517.GE18583@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020920005517.GE18583@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.561   -> 1.562  
#	drivers/hotplug/ibmphp_core.c	1.11    -> 1.12   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/19	greg@kroah.com	1.562
# PCI Hotplug: added speed status to the IBM driver.
# --------------------------------------------
#
diff -Nru a/drivers/hotplug/ibmphp_core.c b/drivers/hotplug/ibmphp_core.c
--- a/drivers/hotplug/ibmphp_core.c	Thu Sep 19 17:50:40 2002
+++ b/drivers/hotplug/ibmphp_core.c	Thu Sep 19 17:50:40 2002
@@ -384,14 +384,15 @@
 	debug ("get_adapter_present - Exit rc[%d] hpcrc[%x] value[%x]\n", rc, hpcrc, *value);
 	return rc;
 }
-/*
-static int get_max_bus_speed (struct hotplug_slot *hotplug_slot, u8 * value)
+
+static int get_max_bus_speed (struct hotplug_slot *hotplug_slot, enum pci_bus_speed *value)
 {
 	int rc = -ENODEV;
 	struct slot *pslot;
 	u8 mode = 0;
 
-	debug ("get_max_bus_speed - Entry hotplug_slot[%lx] pvalue[%lx]\n", (ulong)hotplug_slot, (ulong) value);
+	debug ("%s - Entry hotplug_slot[%p] pvalue[%p]\n", __FUNCTION__,
+		hotplug_slot, value);
 
 	ibmphp_lock_operations ();
 
@@ -413,25 +414,26 @@
 				*value = pslot->supported_speed + 0x01;
 				break;
 			default:
-*/				/* Note (will need to change): there would be soon 256, 512 also */
-/*				rc = -ENODEV;
+				/* Note (will need to change): there would be soon 256, 512 also */
+				rc = -ENODEV;
 			}
 		}
 	} else
 		rc = -ENODEV;
 
 	ibmphp_unlock_operations ();
-	debug ("get_max_bus_speed - Exit rc[%d] value[%x]\n", rc, *value);
+	debug ("%s - Exit rc[%d] value[%x]\n", __FUNCTION__, rc, *value);
 	return rc;
 }
 
-static int get_cur_bus_speed (struct hotplug_slot *hotplug_slot, u8 * value)
+static int get_cur_bus_speed (struct hotplug_slot *hotplug_slot, enum pci_bus_speed *value)
 {
 	int rc = -ENODEV;
 	struct slot *pslot;
 	u8 mode = 0;
 
-	debug ("get_cur_bus_speed - Entry hotplug_slot[%lx] pvalue[%lx]\n", (ulong)hotplug_slot, (ulong) value);
+	debug ("%s - Entry hotplug_slot[%p] pvalue[%p]\n", __FUNCTION__,
+		hotplug_slot, value);
 
 	ibmphp_lock_operations ();
 
@@ -458,8 +460,8 @@
 					*value += 0x01;
 					break;
 				default:
-*/					/* Note of change: there would also be 256, 512 soon */
-/*					rc = -ENODEV;
+					/* Note of change: there would also be 256, 512 soon */
+					rc = -ENODEV;
 				}
 			}
 		}
@@ -467,10 +469,10 @@
 		rc = -ENODEV;
 
 	ibmphp_unlock_operations ();
-	debug ("get_cur_bus_speed - Exit rc[%d] value[%x]\n", rc, *value);
+	debug ("%s - Exit rc[%d] value[%x]\n", __FUNCTION__, rc, *value);
 	return rc;
 }
-
+/*
 static int get_max_adapter_speed_1 (struct hotplug_slot *hotplug_slot, u8 * value, u8 flag)
 {
 	int rc = -ENODEV;
@@ -1584,9 +1586,9 @@
 	.get_attention_status =		get_attention_status,
 	.get_latch_status =		get_latch_status,
 	.get_adapter_status =		get_adapter_present,
-/*	.get_max_bus_speed_status =	get_max_bus_speed,
-	.get_max_adapter_speed_status =	get_max_adapter_speed,
-	.get_cur_bus_speed_status =	get_cur_bus_speed,
+	.get_max_bus_speed =		get_max_bus_speed,
+	.get_cur_bus_speed =		get_cur_bus_speed,
+/*	.get_max_adapter_speed =	get_max_adapter_speed,
 	.get_bus_name_status =		get_bus_name,
 */
 };
