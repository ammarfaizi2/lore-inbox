Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267312AbUH3F4X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267312AbUH3F4X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 01:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267330AbUH3F4X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 01:56:23 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:28118 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S267312AbUH3F4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 01:56:20 -0400
From: jmerkey@comcast.net
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: alan@lxorguk.ukuu.org.uk, wli@holomorphy.com, roland@topspin.com,
       linux-kernel@vger.kernel.org, jmerkey@drdos.com
Subject: Re: 1GB/2GB/3GB User Space Splitting Patch 2.6.8.1 (PSEUDO SPAM)
Date: Mon, 30 Aug 2004 05:56:17 +0000
Message-Id: <083020040556.26446.4132C1810009E19F0000674E2200751150970A059D0A0306@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Jul 16 2004)
X-Authenticated-Sender: am1lcmtleUBjb21jYXN0Lm5ldA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





> What kernel version?  I can't even find usb_read_device() in 2.6.9-rc1.
> 
> BTW, as someone else requested, please teach your mail client to wrap
> lines around column 70-72.  Thanks.
> 
> ~Randy

linux-2.6.8.1.tar.gz

static ssize_t usb_device_read(struct file *file, 
                                                         char __user *buf, 
                                                         size_t nbytes, 
                                                         loff_t *ppos)
{
        struct list_head *buslist;
        struct usb_bus *bus;
        ssize_t ret, total_written = 0;
        loff_t skip_bytes = *ppos;
                                                                                
        if (*ppos < 0)
                return -EINVAL;
        if (nbytes <= 0)
                return 0;
        if (!access_ok(VERIFY_WRITE, buf, nbytes))
                return -EFAULT;
                                                                                
        /* enumerate busses */
        down (&usb_bus_list_lock);
        for (buslist = usb_bus_list.next; 
               buslist != &usb_bus_list; 
               buslist = buslist->next) {
                /* print devices for this bus */
                bus = list_entry(buslist, struct usb_bus, 
                                             bus_list);
                /* print devices for this bus */
                bus = list_entry(buslist, struct usb_bus, 
                                             bus_list);
                                                                                
                /* recurse through all children of the root hub */
                if (!bus->root_hub)
                        continue;

// IT BARFS RIGHT HERE -->
                down(&bus->root_hub->serialize);

Jeff

P.S.  I am using my comcast account which
is not as good as MUTT -- line wrap settings
since it is web based.  
drdos.com gets rejected
so I am typing less characters/line. :-)
