Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264530AbUEUWxi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264530AbUEUWxi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 18:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264561AbUEUWwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 18:52:49 -0400
Received: from sun1000.pwr.wroc.pl ([156.17.250.2]:41109 "EHLO
	sun1000.pwr.wroc.pl") by vger.kernel.org with ESMTP id S264530AbUEUWpl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 18:45:41 -0400
Date: Sat, 22 May 2004 00:45:31 +0200
From: Pawel Dziekonski <pawel.dziekonski@pwr.wroc.pl>
To: linux-kernel@vger.kernel.org
Subject: [2.6.6] [usb] bad: scheduling while atomic!
Message-ID: <20040521224531.GA15538@sun1000.pwr.wroc.pl>
Reply-To: Pawel Dziekonski <pawel.dziekonski@pwr.wroc.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Useless-Header: Vim powered ;^)
X-00-Privacy-Policy: S/MIME encrypted e-mail is welcome.
X-04-Privacy-Policy-My_SSL_Certificate: http://www.europki.pl/cgi-bin/dn-cert.pl?serial=000001D2&certdir=/usr/local/cafe/data/polish_ca/certs/user&type=email
X-05-Privacy-Policy-CA_SSL_Certificate: http://www.europki.pl/polish_ca/ca_cert/en_index.html
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

vanilla 2.6.6, i'm trying to rmmod my adsl usb modem module.
rmmod hangs. I can Control-C it, but is does not end - it takes 
100% of cpu.

logs:

kernel: usbcore: deregistering driver eagle-usb
kernel: bad: scheduling while atomic!
kernel: Call Trace:
kernel:  [schedule+1423/1440] <6>[eagle-usb] eu_irq : URB canceled by user.
kernel: schedule+0x58f/0x5a0
kernel:  [__pagevec_free+28/48] __pagevec_free+0x1c/0x30
kernel:  [release_pages+119/368] release_pages+0x77/0x170
kernel:  [wait_for_completion+120/208] wait_for_completion+0x78/0xd0
kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
kernel:  [pg0+541813763/1070043136] ed_deschedule+0x33/0xf0 [ohci_hcd]
kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
kernel:  [pg0+541943833/1070043136] hcd_unlink_urb+0x199/0x280 [usbcore]
kernel:  [pg0+541812484/1070043136] ed_free+0x24/0x30 [ohci_hcd]
kernel:  [pg0+542588608/1070043136] eu_irq+0x0/0x200 [eagle_usb]
kernel:  [pg0+541945986/1070043136] usb_unlink_urb+0x32/0x70 [usbcore]
kernel:  [pg0+542588542/1070043136] eu_disconnect_postfirm+0x29e/0x2e0 [eagle_usb]
kernel:  [pg0+541949572/1070043136] usb_disable_endpoint+0x74/0x80 [usbcore]
kernel:  [pg0+542587707/1070043136] eu_disconnect+0x10b/0x1b0 [eagle_usb]
kernel:  [pg0+541925626/1070043136] usb_unbind_interface+0x7a/0x80 [usbcore]
kernel:  [device_release_driver+100/112] device_release_driver+0x64/0x70
kernel:  [driver_detach+32/48] driver_detach+0x20/0x30
kernel:  [bus_remove_driver+61/128] bus_remove_driver+0x3d/0x80
kernel:  [driver_unregister+19/40] driver_unregister+0x13/0x28
kernel:  [pg0+541925842/1070043136] usb_deregister+0x32/0x40 [usbcore]
kernel:  [pg0+542624920/1070043136] eu_exit+0x18/0x71 [eagle_usb]
kernel:  [sys_delete_module+321/384] sys_delete_module+0x141/0x180
kernel:  [generic_file_direct_IO+18/160] generic_file_direct_IO+0x12/0xa0
kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
kernel: 
kernel: [eagle-usb] ADSL device remove

any idea?

thanks in advance, Pawel
-- 
Pawel Dziekonski <pawel.dziekonski|@|pwr.wroc.pl>, KDM WCSS avatar:0:0:
Wroclaw Networking & Supercomputing Center, HPC Department
-> See message headers for privacy policy and S/MIME info.
