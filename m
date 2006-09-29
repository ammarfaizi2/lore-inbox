Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932248AbWI2Lp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248AbWI2Lp7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 07:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbWI2Lp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 07:45:59 -0400
Received: from mailin.qosmotec.com ([212.144.14.27]:30549 "EHLO
	mailin.qosmotec.com") by vger.kernel.org with ESMTP id S932248AbWI2Lp5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 07:45:57 -0400
Subject: Problems with hard irq? (inconsistent lock state)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Date: Fri, 29 Sep 2006 13:45:53 +0200
Content-Class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
Message-ID: <46E81D405FFAC240826E54028B3B02953B13@aixlac.qosmotec.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Problems with hard irq? (inconsistent lock state)
thread-index: AcbjvAvf6bgDV+TrQ2mJGzSV7SclUAAADXzw
From: "Axel C. Voigt" <Axel.Voigt@qosmotec.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Hello all,

today I received the following stack backtrace using debian-2.6.18 with our communications driver accessing a ACM device. This happened when removing (powering off and/or on) the mobile phone (nokia 6630) at /dev/ttyACMx

Are someone able to get a hint for me?

--schnipp--
Sep 29 13:29:53 mcs70 kernel:
Sep 29 13:29:53 mcs70 kernel: =================================
Sep 29 13:29:53 mcs70 kernel: [ INFO: inconsistent lock state ]
Sep 29 13:29:53 mcs70 kernel: ---------------------------------
Sep 29 13:29:53 mcs70 kernel: inconsistent {hardirq-on-W} -> {in-hardirq-W} usage.
Sep 29 13:29:53 mcs70 kernel: startDV24/3864 [HC1[1]:SC0[0]:HE0:SE1] takes:
Sep 29 13:29:53 mcs70 kernel: (&acm->read_lock){++..}, at: [<e08952d8>] acm_read_bulk+0x60/0xde [cdc_acm]
Sep 29 13:29:53 mcs70 kernel: {hardirq-on-W} state was registered at:
Sep 29 13:29:53 mcs70 kernel: [<c01321f3>] lock_acquire+0x56/0x73
Sep 29 13:29:53 mcs70 kernel: [<c02ce42a>] _spin_lock+0x1a/0x25
Sep 29 13:29:53 mcs70 kernel: [<e08953a8>] acm_rx_tasklet+0x52/0x2be [cdc_acm]
Sep 29 13:29:53 mcs70 kernel: [<c011f868>] tasklet_action+0x6d/0xd7
Sep 29 13:29:53 mcs70 kernel: [<c011f526>] __do_softirq+0x79/0xf2
Sep 29 13:29:53 mcs70 kernel: [<c011f5dc>] do_softirq+0x3d/0x5c
Sep 29 13:29:53 mcs70 kernel: [<c011faa7>] ksoftirqd+0x77/0xc7
Sep 29 13:29:53 mcs70 kernel: [<c012bee6>] kthread+0x84/0xad
Sep 29 13:29:53 mcs70 kernel: [<c0100e95>] kernel_thread_helper+0x5/0xb
Sep 29 13:29:53 mcs70 kernel: irq event stamp: 38544
Sep 29 13:29:53 mcs70 kernel: hardirqs last  enabled at (38543): [<c02ce51e>] _spin_unlock_irqrestore+0x3a/0x43
Sep 29 13:29:53 mcs70 kernel: hardirqs last disabled at (38544): [<c010332f>] common_interrupt+0x1b/0x2c
Sep 29 13:29:53 mcs70 kernel: softirqs last  enabled at (38488): [<e08c43ee>] unix_release_sock+0x61/0x1e3 [unix]
Sep 29 13:29:53 mcs70 kernel: softirqs last disabled at (38486): [<c02ce3f1>] _write_lock_bh+0xb/0x2a
Sep 29 13:29:53 mcs70 kernel:
Sep 29 13:29:53 mcs70 kernel: other info that might help us debug this:
Sep 29 13:29:53 mcs70 kernel: no locks held by startDV24/3864.
Sep 29 13:29:53 mcs70 kernel:
Sep 29 13:29:53 mcs70 kernel: stack backtrace:
Sep 29 13:29:53 mcs70 kernel: [<c010376e>] show_trace+0x16/0x18
Sep 29 13:29:53 mcs70 kernel: [<c010383c>] dump_stack+0x19/0x1b
Sep 29 13:29:53 mcs70 kernel: [<c0130ad8>] print_usage_bug+0x1e1/0x1eb
Sep 29 13:29:53 mcs70 kernel: [<c0130b86>] mark_lock+0xa4/0x4d9
Sep 29 13:29:53 mcs70 kernel: [<c0131823>] __lock_acquire+0x41a/0x841
Sep 29 13:29:53 mcs70 kernel: [<c01321f3>] lock_acquire+0x56/0x73
Sep 29 13:29:53 mcs70 kernel: [<c02ce42a>] _spin_lock+0x1a/0x25
Sep 29 13:29:53 mcs70 kernel: [<e08952d8>] acm_read_bulk+0x60/0xde [cdc_acm]
Sep 29 13:29:53 mcs70 kernel: [<e0831e6a>] usb_hcd_giveback_urb+0x2b/0x5b [usbcore]
Sep 29 13:29:53 mcs70 kernel: [<e08ab055>] ehci_urb_done+0x7c/0x8b [ehci_hcd]
Sep 29 13:29:53 mcs70 kernel: [<e08ab0ed>] qh_completions+0x89/0x29b [ehci_hcd]
Sep 29 13:29:53 mcs70 kernel: [<e08abd9c>] scan_async+0x7f/0x11f [ehci_hcd]
Sep 29 13:29:53 mcs70 kernel: [<e08adf88>] ehci_work+0x38/0xa0 [ehci_hcd]
Sep 29 13:29:53 mcs70 kernel: [<e08ae441>] ehci_irq+0x145/0x15c [ehci_hcd]
Sep 29 13:29:53 mcs70 kernel: [<e0831ec5>] usb_hcd_irq+0x2b/0x58 [usbcore]
Sep 29 13:29:53 mcs70 kernel: [<c013c08e>] handle_IRQ_event+0x18/0x4a
Sep 29 13:29:53 mcs70 kernel: [<c013c152>] __do_IRQ+0x92/0xf0
Sep 29 13:29:53 mcs70 kernel: [<c0104b26>] do_IRQ+0x4e/0x5f
Sep 29 13:29:53 mcs70 kernel: [<c0103339>] common_interrupt+0x25/0x2c
Sep 29 13:29:53 mcs70 DV24[3925]: DV24: close: dev->openCnt--
Sep 29 13:29:53 mcs70 kernel: [<c012c144>] add_wait_queue+0x30/0x35
Sep 29 13:29:53 mcs70 kernel: [<c01694fc>] __pollwait+0x47/0x4e
Sep 29 13:29:53 mcs70 kernel: [<c0164260>] pipe_poll+0x26/0x91
Sep 29 13:29:53 mcs70 kernel: [<c0169794>] do_select+0x1bf/0x385
Sep 29 13:29:53 mcs70 kernel: [<c0169b6c>] core_sys_select+0x212/0x307
Sep 29 13:29:53 mcs70 kernel: [<c0169cf1>] sys_select+0x90/0x13f
Sep 29 13:29:53 mcs70 kernel: [<c0102897>] syscall_call+0x7/0xb
Sep 29 13:29:53 mcs70 DV24[3925]: DV24: close: /dev/mobile1: openCnt: 0
Sep 29 13:29:53 mcs70 DV24[3925]: DV24: executing tcsetattr(dev->fd: 6, TCSADRAIN, &dev->oldtio)
Sep 29 13:29:53 mcs70 DV24[3925]: DV24: executing close(dev->fd): 6
Sep 29 13:29:53 mcs70 DV24[3925]: DV24: close: write(gControl.toAdm, &cmd, sizeof(cmd)
Sep 29 13:29:53 mcs70 DV24[3925]: DV24: close: gControl.openCnt--
Sep 29 13:29:53 mcs70 DV24[3925]: DV24: close: OPEN_CNT_ALL_CLOSE == gControl.openCnt
Sep 29 13:29:53 mcs70 DV24[3925]: DV24: close: returning CMS_OK
--schnapp--

Mit freundlichen Grüssen/ with kind regards,
 
Axel C. Voigt
 
--
Qosmotec Software Solutions GmbH     QQQQ       tel:  +49.241.879 75 13
Schloss-Rahe-Strasse 15             Q _\ Q      mob:  +49.163.879 75 13
52072 Aachen                        Q \ \Q      fax:  +49.241.879 75 15
Germany                              QQ\_\      http://www.qosmotec.com
 
 

