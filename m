Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274462AbSITAzx>; Thu, 19 Sep 2002 20:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274559AbSITAzZ>; Thu, 19 Sep 2002 20:55:25 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:46858 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S274205AbSITAxt>;
	Thu, 19 Sep 2002 20:53:49 -0400
Date: Thu, 19 Sep 2002 17:58:40 -0700
From: Greg KH <greg@kroah.com>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: Re: [BK PATCH] More PCI Hotplug changes for 2.4.20-pre7
Message-ID: <20020920005840.GL18583@kroah.com>
References: <20020920005749.GI18583@kroah.com> <20020920005806.GJ18583@kroah.com> <20020920005823.GK18583@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020920005823.GK18583@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.685   -> 1.686  
#	drivers/hotplug/ibmphp_core.c	1.6     -> 1.7    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/18	greg@kroah.com	1.686
# PCI Hotplug: added speed status to the IBM driver.
# --------------------------------------------
#
diff -Nru a/drivers/hotplug/ibmphp_core.c b/drivers/hotplug/ibmphp_core.c
--- a/drivers/hotplug/ibmphp_core.c	Thu Sep 19 17:19:03 2002
+++ b/drivers/hotplug/ibmphp_core.c	Thu Sep 19 17:19:03 2002
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
@@ -1579,9 +1581,9 @@
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
