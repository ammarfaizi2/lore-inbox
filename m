Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264739AbSLWAjS>; Sun, 22 Dec 2002 19:39:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264743AbSLWAjR>; Sun, 22 Dec 2002 19:39:17 -0500
Received: from air-2.osdl.org ([65.172.181.6]:60093 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S264739AbSLWAjQ>;
	Sun, 22 Dec 2002 19:39:16 -0500
Date: Sun, 22 Dec 2002 16:46:00 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dev_printk macro
In-Reply-To: <200212222104.gBML4vI15305@hera.kernel.org>
Message-ID: <Pine.LNX.4.33L2.0212221634210.16753-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi LKML,

I'm glad to see this patch available, as Greg was.
Now I have some questions about it.

a.  Is it only for drivers?  If so, why?
    Filesystems and other subsystems that are not drivers could use
    something like this also.

b.  Is it only for drivers that have a device?
    What does a driver use for dev_printk() if it doesn't have a <dev>?
    However, these do cover the large majority of cases, so that's good.

c.  Maybe I'm too cautious (I don't like panics or oopsen :), but I would
    have checked <dev> for NULL in those macros.

d.  and I know that <sev> is severity, but spelling it as severity
    or level would have been better.  :)

IOW, this is a good start, no doubt.  However, it appears to be limited
in scope to drivers.  That's still a good start, but there's more to do.

-- 
~Randy

PS:  Yes, I know Greg's 2 favorite words:  Patches accepted.
Maybe early next year.  ;)


On Sun, 22 Dec 2002, Linux Kernel Mailing List wrote:

| ChangeSet 1.865.28.18, 2002/12/21 23:54:35-08:00, jkenisto@us.ibm.com
|
| 	[PATCH] dev_printk macro
|
| #	include/linux/device.h	1.69    -> 1.70
|
| diff -Nru a/include/linux/device.h b/include/linux/device.h
| --- a/include/linux/device.h	Sun Dec 22 13:04:59 2002
| +++ b/include/linux/device.h	Sun Dec 22 13:04:59 2002
| @@ -396,22 +396,21 @@
|  extern void firmware_unregister(struct subsystem *);
|
|  /* debugging and troubleshooting/diagnostic helpers. */
| +#define dev_printk(sev, dev, format, arg...)	\
| +	printk(sev "%s %s: " format , (dev).driver->name , (dev).bus_id , ## arg)
| +
|  #ifdef DEBUG
|  #define dev_dbg(dev, format, arg...)		\
| -	printk (KERN_DEBUG "%s %s: " format ,	\
| -		(dev).driver->name , (dev).bus_id , ## arg)
| +	dev_printk(KERN_DEBUG , (dev) , format , ## arg)
|  #else
|  #define dev_dbg(dev, format, arg...) do {} while (0)
|  #endif
|
|  #define dev_err(dev, format, arg...)		\
| -	printk (KERN_ERR "%s %s: " format ,	\
| -		(dev).driver->name , (dev).bus_id , ## arg)
| +	dev_printk(KERN_ERR , (dev) , format , ## arg)
|  #define dev_info(dev, format, arg...)		\
| -	printk (KERN_INFO "%s %s: " format ,	\
| -		(dev).driver->name , (dev).bus_id , ## arg)
| +	dev_printk(KERN_INFO , (dev) , format , ## arg)
|  #define dev_warn(dev, format, arg...)		\
| -	printk (KERN_WARNING "%s %s: " format ,	\
| -		(dev).driver->name , (dev).bus_id , ## arg)
| +	dev_printk(KERN_WARNING , (dev) , format , ## arg)
|
|  #endif /* _DEVICE_H_ */

