Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273693AbRIQU2P>; Mon, 17 Sep 2001 16:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273692AbRIQU2F>; Mon, 17 Sep 2001 16:28:05 -0400
Received: from smtp6.us.dell.com ([143.166.83.101]:49673 "EHLO
	smtp6.us.dell.com") by vger.kernel.org with ESMTP
	id <S273693AbRIQU17>; Mon, 17 Sep 2001 16:27:59 -0400
Date: Mon, 17 Sep 2001 15:28:19 -0500 (CDT)
From: Robert Macaulay <robert_macaulay@dell.com>
X-X-Sender: <robert@ping.us.dell.com>
Reply-To: Robert Macaulay <robert_macaulay@dell.com>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.9-ac10 scsi_scan broke with SPARSELUN devices(/proc/partitions
 loops)
Message-ID: <Pine.LNX.4.33.0109171504590.23583-100000@ping.us.dell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On a clean 2.4.9ac10 kernel, with no SPARSELUN devices loaded, 
/proc/partitions lists the devices as it should. The machine is a HIMEM64 
box with 8GB of RAM, and a qlogic 2200 connected to the fibre channel 
disks.

Once the qlogicfc driver is loaded with Dell PV650f(a SPARSELUN device), 
the /proc/partitions lists the correct devices, but does so over and over.  
For example, a /proc/partitions after the load, somewhat abbreviated

   8     0   17547264 sda
   8     1      56196 sda1
   8    16   17342660 sdb
   8    17     103408 sdb1
   8     0   17547264 sda
   8     1      56196 sda1
   8    16   17342660 sdb
   8    17     103408 sdb1
   .
   . 
   .

The same results happen if we use qlogic's qla2x00 driver on this 
kernel. The driver's messages in dmesg are correct, however the block 
devices are still usable, but anything that grabs all devices(mount -a) 
will cause it to spin forever.

Thanks
Robert Macaulay

