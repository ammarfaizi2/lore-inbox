Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289769AbSBJVao>; Sun, 10 Feb 2002 16:30:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289768AbSBJVa3>; Sun, 10 Feb 2002 16:30:29 -0500
Received: from smtp1.vol.cz ([195.250.128.73]:15370 "EHLO smtp1.vol.cz")
	by vger.kernel.org with ESMTP id <S289761AbSBJVaO>;
	Sun, 10 Feb 2002 16:30:14 -0500
Date: Sat, 9 Feb 2002 23:39:25 +0100
From: Pavel Machek <pavel@suse.cz>
To: Patrick Mochel <mochel@osdl.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Undead code in include/linux/device.h
Message-ID: <20020209223925.GA13837@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I think you meant this code to be killed...
								Pavel

--- clean-pre3/include/linux/device.h	Sat Feb  9 23:00:08 2002
+++ linux-dm-pre3/include/linux/device.h	Sat Feb  9 23:20:46 2002
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
