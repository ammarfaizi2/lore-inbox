Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275024AbTHFXjt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 19:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275025AbTHFXjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 19:39:49 -0400
Received: from main.gmane.org ([80.91.224.249]:23695 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S275024AbTHFXjp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 19:39:45 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: ilmari@ilmari.org (=?utf-8?b?RGFnZmlubiBJbG1hcmkg?=
	=?utf-8?b?TWFubnPDpWtlcg==?=)
Subject: Badness in local_bh_enable at kernel/softirq.c:113 (2.6.0-test2,
 bluetooth)
Date: Thu, 07 Aug 2003 01:39:35 +0200
Organization: Program-, Informasjons- og Nettverksteknologisk Gruppe, UiO
Message-ID: <d8ju18u2w5k.fsf@wirth.ping.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@main.gmane.org
Mail-Copies-To: ilmari@ilmari.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.2 (gnu/linux)
Cancel-Lock: sha1:VVQ9mxzjX0e21l0PAuzVSY8XxsM=
Cc: bluez-devel@lists.sourceforge.net, linux-usb-devel@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When unplugging my MSI USB Bluetooth adapter on 2.6.0-test2 I got two
instances of the following backtrace:

Badness in local_bh_enable at kernel/softirq.c:113
Call Trace:
 [<c011f6c6>] local_bh_enable+0x86/0x90
 [<d090482a>] hci_dev_do_close+0xba/0x410 [bluetooth]
 [<c011f6c6>] local_bh_enable+0x86/0x90
 [<d09056cf>] hci_unregister_dev+0x4f/0xa0 [bluetooth]
 [<d0976d8a>] hci_usb_disconnect+0x3a/0x80 [hci_usb]
 [<d08ae237>] usb_device_remove+0x77/0x80 [usbcore]
 [<c01df116>] device_release_driver+0x66/0x70
 [<c01df26e>] bus_remove_device+0x5e/0xb0
 [<c01dd99d>] device_del+0x5d/0xa0
 [<c01dd9f3>] device_unregister+0x13/0x30
 [<d08aee77>] usb_disconnect+0xd7/0x180 [usbcore]
 [<d08b1f9f>] hub_port_connect_change+0x37f/0x390 [usbcore]
 [<d08b2360>] hub_events+0x3b0/0x480 [usbcore]
 [<d08b2465>] hub_thread+0x35/0x110 [usbcore]
 [<c0109192>] ret_from_fork+0x6/0x14
 [<c0118670>] default_wake_function+0x0/0x30
 [<d08b2430>] hub_thread+0x0/0x110 [usbcore]
 [<c01071e5>] kernel_thread_helper+0x5/0x10

-- 
ilmari

