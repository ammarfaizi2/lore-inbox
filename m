Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932411AbWGLEQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932411AbWGLEQt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 00:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932412AbWGLEQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 00:16:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:41888 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932411AbWGLEQs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 00:16:48 -0400
Date: Wed, 12 Jul 2006 00:16:43 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: fedora@adslpipe.co.uk
Subject: strange kobject messages in .18rc1git3
Message-ID: <20060712041642.GG32707@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>, fedora@adslpipe.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's an odd suspend/resume regression reported by a Fedora user. (Andy Cc'd)

hub 4-0:1.0: resuming
ac97 1-1:unknown codec: resuming
usb 2-2: resuming
hci_usb 2-2:1.0: resuming
hci_usb 2-2:1.1: resuming
platform bluetooth: resuming
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object [c1deb4a4]
[20060623]
Restarting tasks...<6>usb 2-2: USB disconnect, address 2
PM: Removing info for No Bus:usbdev2.2_ep81
PM: Removing info for No Bus:usbdev2.2_ep02
PM: Removing info for No Bus:usbdev2.2_ep82
PM: Removing info for No Bus:hci0
 done
Thawing cpus ...


kobject_add failed for vcs63 with -EEXIST, don't try to register things with the
same name in the same directory.
 [<c0405167>] show_trace_log_lvl+0x54/0xfd
 [<c040571e>] show_trace+0xd/0x10
 [<c040583d>] dump_stack+0x19/0x1b
 [<c04e3ab6>] kobject_add+0x174/0x19a
 [<c05505ff>] class_device_add+0x99/0x3e6
 [<c055095e>] class_device_register+0x12/0x15
 [<c05509e3>] class_device_create+0x82/0xa5
 [<c0534e91>] vcs_make_devfs+0x25/0x53
 [<c0539d46>] con_open+0x72/0x80
 [<c05304af>] tty_open+0x186/0x308
 [<c04799a9>] chrdev_open+0x16f/0x1c7
 [<c047028a>] __dentry_open+0xc8/0x1ab
 [<c04703db>] nameidata_to_filp+0x1c/0x2e
 [<c047041b>] do_filp_open+0x2e/0x35
 [<c0470462>] do_sys_open+0x40/0xb5
 [<c0470503>] sys_open+0x16/0x18
 [<c0403f2f>] syscall_call+0x7/0xb

kobject_add failed for vcsa63 with -EEXIST, don't try to register things with
the same name in the same directory.
 [<c0405167>] show_trace_log_lvl+0x54/0xfd
 [<c040571e>] show_trace+0xd/0x10
 [<c040583d>] dump_stack+0x19/0x1b
 [<c04e3ab6>] kobject_add+0x174/0x19a
 [<c05505ff>] class_device_add+0x99/0x3e6
 [<c055095e>] class_device_register+0x12/0x15
 [<c05509e3>] class_device_create+0x82/0xa5
 [<c0534eb7>] vcs_make_devfs+0x4b/0x53
 [<c0539d46>] con_open+0x72/0x80
 [<c05304af>] tty_open+0x186/0x308
 [<c04799a9>] chrdev_open+0x16f/0x1c7
 [<c047028a>] __dentry_open+0xc8/0x1ab
 [<c04703db>] nameidata_to_filp+0x1c/0x2e
 [<c047041b>] do_filp_open+0x2e/0x35
 [<c0470462>] do_sys_open+0x40/0xb5
 [<c0470503>] sys_open+0x16/0x18
 [<c0403f2f>] syscall_call+0x7/0xb

-- 
http://www.codemonkey.org.uk
