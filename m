Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290864AbSBLJJQ>; Tue, 12 Feb 2002 04:09:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290845AbSBLJIU>; Tue, 12 Feb 2002 04:08:20 -0500
Received: from smtp1.vol.cz ([195.250.128.73]:58633 "EHLO smtp1.vol.cz")
	by vger.kernel.org with ESMTP id <S290839AbSBLJIM>;
	Tue, 12 Feb 2002 04:08:12 -0500
Date: Tue, 12 Feb 2002 10:01:28 +0100
From: Pavel Machek <pavel@suse.cz>
To: Patrick Mochel <mochel@osdl.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Kill unused pieces of linux/device.h
Message-ID: <20020212090128.GA627@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This kills dead code, please apply,
								Pavel

--- linux/include/linux/device.h	Mon Feb 11 21:10:52 2002
+++ linux-dm/include/linux/device.h	Mon Feb 11 21:57:56 2002
@@ -54,7 +54,6 @@
 };
 
 struct device;
-struct iobus;
 
 struct device_driver {
 	int	(*probe)	(struct device * dev);
@@ -94,23 +93,6 @@
 	unsigned char *saved_state;	/* saved device state */
 };
 
-/*
- * struct bus_type - descriptor for a type of bus
- * There are some instances when you need to know what type of bus a
- * device is on. Instead of having some sort of enumerated integer type,
- * each struct iobus will have a pointer to a struct bus_type that gives
- * actually meaningful data.
- * There should be one struct bus_type for each type of bus (one for PCI,
- * one for USB, etc).
- */
-struct iobus_driver {
-	char	name[16];	/* ascii descriptor of type of bus */
-	struct	list_head node; /* node in global list of bus drivers */
-
-	int	(*scan)		(struct iobus*);
-	int	(*add_device)	(struct iobus*, char*);
-};
-
 static inline struct device *
 list_to_dev(struct list_head *node)
 {
@@ -122,8 +104,6 @@
  */
 extern int device_register(struct device * dev);
 
-extern int iobus_register(struct iobus * iobus);
-
 extern int device_create_file(struct device *device, struct driver_file_entry * entry);
 extern void device_remove_file(struct device * dev, const char * name);
 

-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
