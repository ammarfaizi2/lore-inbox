Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275193AbTHMOuw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 10:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275201AbTHMOuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 10:50:52 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:48290 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S275193AbTHMOun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 10:50:43 -0400
Date: Wed, 13 Aug 2003 07:49:52 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: solt@dns.toxicfilms.tv
Subject: [Bug 1094] New: Unplugging USB MP3 player from causes these printouts. May be related to scsi subsytem. 
Message-ID: <5630000.1060786192@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1094

           Summary: Unplugging USB MP3 player from causes these printouts.
                    May be related to scsi subsytem.
    Kernel Version: 2.6.0-test3 and all the previous too
            Status: NEW
          Severity: normal
             Owner: greg@kroah.com
         Submitter: solt@dns.toxicfilms.tv


Distribution: Debian SID
Hardware Environment: UHCI Intel Corp. 82801BA/BAM USB (Hub #2) (rev 12)
Software Environment: mount-2.11z, gcc-3.3.1, (on gcc-3.2.2 too)
Problem Description: After unplugging an USB MP3 player that uses scsi_mod, 
sd_mod and usb-storage, the kernel prints out these:

I reported this as early as 2.5.69.

Steps to reproduce:
compile the kernel with scsi_mod, sd_mod, usb-storage (all needed to transfer 
files to the usb device).

Plug in the device.
You can mount it, copy files, whatever.
Here's what you get about:
class_dev_release at drivers/base/class.c:201
and
kobject_cleanup at lib/kobject.c:402

### 

hub 1-0:0: port 2, status 100, change 3, 12 Mb/s
usb 1-2: USB disconnect, address 3
drivers/usb/core/message.c: nuking URBs for device 1-2
usb 1-2: unregistering interfaces
usb-storage: storage_disconnect() called
usb-storage: usb_stor_stop_transport called
usb-storage: -- dissociate_dev

Device class '1:0:0:0' does not have a release() function, it is broken and must 
be fixed.
Badness in class_dev_release at drivers/base/class.c:201
Call Trace:
 [kobject_cleanup+131/133] kobject_cleanup+0x83/0x85
 [class_device_unregister+19/35] class_device_unregister+0x13/0x23
 [scsi_device_unregister+31/47] scsi_device_unregister+0x1f/0x2f  
 [scsi_remove_device+15/21] scsi_remove_device+0xf/0x15
 [scsi_forget_host+25/39] scsi_forget_host+0x19/0x27   
 [scsi_remove_host+55/70] scsi_remove_host+0x37/0x46  
 [storage_disconnect+138/187] storage_disconnect+0x8a/0xbb
 [usb_unbind_interface+117/119] usb_unbind_interface+0x75/0x77
 [device_release_driver+98/100] device_release_driver+0x62/0x64
 [bus_remove_device+94/165] bus_remove_device+0x5e/0xa5
 [device_del+93/147] device_del+0x5d/0x93
 [device_unregister+19/35] device_unregister+0x13/0x23
 [usb_disconnect+293/367] usb_disconnect+0x125/0x16f  
 [hub_port_connect_change+914/919] hub_port_connect_change+0x392/0x397
 [hub_events+948/1148] hub_events+0x3b4/0x47c
 [hub_thread+42/214] hub_thread+0x2a/0xd6
 [default_wake_function+0/46] default_wake_function+0x0/0x2e
 [hub_thread+0/214] hub_thread+0x0/0xd6
 [kernel_thread_helper+5/11] kernel_thread_helper+0x5/0xb

kobject 'sda1' does not have a release() function, it is broken and must be 
fixed.
Badness in kobject_cleanup at lib/kobject.c:402
Call Trace:
 [kobject_cleanup+95/133] kobject_cleanup+0x5f/0x85
 [delete_partition+109/144] delete_partition+0x6d/0x90
 [del_gendisk+47/200] del_gendisk+0x2f/0xc8
 [sd_remove+32/112] sd_remove+0x20/0x70
 [device_release_driver+98/100] device_release_driver+0x62/0x64
 [bus_remove_device+94/165] bus_remove_device+0x5e/0xa5
 [device_del+93/147] device_del+0x5d/0x93
 [device_unregister+19/35] device_unregister+0x13/0x23
 [scsi_remove_device+15/21] scsi_remove_device+0xf/0x15
 [scsi_forget_host+25/39] scsi_forget_host+0x19/0x27   
 [scsi_remove_host+55/70] scsi_remove_host+0x37/0x46   
 [storage_disconnect+138/187] storage_disconnect+0x8a/0xbb
 [usb_unbind_interface+117/119] usb_unbind_interface+0x75/0x77
 [device_release_driver+98/100] device_release_driver+0x62/0x64
 [bus_remove_device+94/165] bus_remove_device+0x5e/0xa5
 [device_del+93/147] device_del+0x5d/0x93
 [device_unregister+19/35] device_unregister+0x13/0x23
 [usb_disconnect+293/367] usb_disconnect+0x125/0x16f  
 [hub_port_connect_change+914/919] hub_port_connect_change+0x392/0x397
 [hub_events+948/1148] hub_events+0x3b4/0x47c
 [hub_thread+42/214] hub_thread+0x2a/0xd6
 [default_wake_function+0/46] default_wake_function+0x0/0x2e
 [hub_thread+0/214] hub_thread+0x0/0xd6
 [kernel_thread_helper+5/11] kernel_thread_helper+0x5/0xb

kobject 'iosched' does not have a release() function, it is broken and must be 
fixed.
Badness in kobject_cleanup at lib/kobject.c:402  
Call Trace:
 [kobject_cleanup+95/133] kobject_cleanup+0x5f/0x85
 [elv_unregister_queue+26/56] elv_unregister_queue+0x1a/0x38   
 [blk_unregister_queue+30/79] blk_unregister_queue+0x1e/0x4f
 [unlink_gendisk+33/136] unlink_gendisk+0x21/0x88
 [del_gendisk+92/200] del_gendisk+0x5c/0xc8
 [sd_remove+32/112] sd_remove+0x20/0x70
 [device_release_driver+98/100] device_release_driver+0x62/0x64
 [bus_remove_device+94/165] bus_remove_device+0x5e/0xa5
 [device_del+93/147] device_del+0x5d/0x93
 [device_unregister+19/35] device_unregister+0x13/0x23
 [scsi_remove_device+15/21] scsi_remove_device+0xf/0x15
 [scsi_forget_host+25/39] scsi_forget_host+0x19/0x27   
 [scsi_remove_host+55/70] scsi_remove_host+0x37/0x46
 [storage_disconnect+138/187] storage_disconnect+0x8a/0xbb
 [usb_unbind_interface+117/119] usb_unbind_interface+0x75/0x77
 [device_release_driver+98/100] device_release_driver+0x62/0x64
 [bus_remove_device+94/165] bus_remove_device+0x5e/0xa5
 [device_del+93/147] device_del+0x5d/0x93
 [device_unregister+19/35] device_unregister+0x13/0x23
 [usb_disconnect+293/367] usb_disconnect+0x125/0x16f
 [hub_port_connect_change+914/919] hub_port_connect_change+0x392/0x397
 [hub_events+948/1148] hub_events+0x3b4/0x47c
 [hub_thread+42/214] hub_thread+0x2a/0xd6
 [default_wake_function+0/46] default_wake_function+0x0/0x2e
 [hub_thread+0/214] hub_thread+0x0/0xd6
 [kernel_thread_helper+5/11] kernel_thread_helper+0x5/0xb

kobject 'queue' does not have a release() function, it is broken and must be 
fixed.
Badness in kobject_cleanup at lib/kobject.c:402
Call Trace:
 [kobject_cleanup+95/133] kobject_cleanup+0x5f/0x85
 [blk_unregister_queue+44/79] blk_unregister_queue+0x2c/0x4f
 [unlink_gendisk+33/136] unlink_gendisk+0x21/0x88
 [del_gendisk+92/200] del_gendisk+0x5c/0xc8
 [sd_remove+32/112] sd_remove+0x20/0x70
 [device_release_driver+98/100] device_release_driver+0x62/0x64
 [bus_remove_device+94/165] bus_remove_device+0x5e/0xa5
 [device_del+93/147] device_del+0x5d/0x93
 [device_unregister+19/35] device_unregister+0x13/0x23
 [scsi_remove_device+15/21] scsi_remove_device+0xf/0x15
 [scsi_forget_host+25/39] scsi_forget_host+0x19/0x27   
 [scsi_remove_host+55/70] scsi_remove_host+0x37/0x46   
 [storage_disconnect+138/187] storage_disconnect+0x8a/0xbb
 [usb_unbind_interface+117/119] usb_unbind_interface+0x75/0x77
 [device_release_driver+98/100] device_release_driver+0x62/0x64
 [bus_remove_device+94/165] bus_remove_device+0x5e/0xa5
 [device_del+93/147] device_del+0x5d/0x93
 [device_unregister+19/35] device_unregister+0x13/0x23
 [usb_disconnect+293/367] usb_disconnect+0x125/0x16f  
 [hub_port_connect_change+914/919] hub_port_connect_change+0x392/0x397
 [hub_events+948/1148] hub_events+0x3b4/0x47c
 [hub_thread+42/214] hub_thread+0x2a/0xd6
 [default_wake_function+0/46] default_wake_function+0x0/0x2e
 [hub_thread+0/214] hub_thread+0x0/0xd6
 [kernel_thread_helper+5/11] kernel_thread_helper+0x5/0xb

Device class 'host1' does not have a release() function, it is broken and must 
be fixed.
Badness in class_dev_release at drivers/base/class.c:201
Call Trace:
 [kobject_cleanup+131/133] kobject_cleanup+0x83/0x85
 [device_del+104/147] device_del+0x68/0x93
 [scsi_host_put+31/47] scsi_host_put+0x1f/0x2f
 [usb_stor_release_resources+249/254] usb_stor_release_resources+0xf9/0xfe
 [usb_unbind_interface+117/119] usb_unbind_interface+0x75/0x77
 [device_release_driver+98/100] device_release_driver+0x62/0x64
 [bus_remove_device+94/165] bus_remove_device+0x5e/0xa5
 [device_del+93/147] device_del+0x5d/0x93
 [device_unregister+19/35] device_unregister+0x13/0x23
 [usb_disconnect+293/367] usb_disconnect+0x125/0x16f  
 [hub_port_connect_change+914/919] hub_port_connect_change+0x392/0x397
 [hub_events+948/1148] hub_events+0x3b4/0x47c
 [hub_thread+42/214] hub_thread+0x2a/0xd6
 [default_wake_function+0/46] default_wake_function+0x0/0x2e
 [hub_thread+0/214] hub_thread+0x0/0xd6
 [kernel_thread_helper+5/11] kernel_thread_helper+0x5/0xb


