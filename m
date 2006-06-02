Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751043AbWFBBC3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751043AbWFBBC3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 21:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751047AbWFBBC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 21:02:29 -0400
Received: from p50827977.dip.t-dialin.net ([80.130.121.119]:57072 "EHLO
	stiffy.osknowledge.org") by vger.kernel.org with ESMTP
	id S1751036AbWFBBC3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 21:02:29 -0400
Date: Fri, 2 Jun 2006 03:02:24 +0200
From: Marc Koschewski <marc@osknowledge.org>
To: linux-kernel@vger.kernel.org
Subject: BUG: soft lockup detected on CPU#0!
Message-ID: <20060602010223.GA9460@stiffy.osknowledge.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-PGP-Fingerprint: D514 7DC1 B5F5 8989 083E  38C9 5ECF E5BD 3430 ABF5
X-PGP-Key: http://www.osknowledge.org/~marc/pubkey.asc
X-Operating-System: Linux stiffy 2.6.17-rc5-marc-g705af309
User-Agent: mutt-ng/devel-r802 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

here what I got when I connected my mobile phone via gnome-phone-manager and a
bluetooth PCMCIA adapter. The machine freezes when I connect and attached is
what dmesg says after I ejected the card. The card had /dev/ttyS3 assigned and I
used it as my setting in gnome-phone-manager.

[4296372.670000] BUG: soft lockup detected on CPU#0!
[4296372.670000]  [<b0138e29>] softlockup_tick+0x7e/0xbb
[4296372.670000]  [<b0120cdc>] update_process_times+0x2a/0x60
[4296372.670000]  [<b01063ec>] timer_interrupt+0x3a/0xce
[4296372.670000]  [<b0138efd>] handle_IRQ_event+0x2e/0x5a
[4296372.670000]  [<b0138fb2>] __do_IRQ+0x89/0x127
[4296372.670000]  [<b0105099>] do_IRQ+0x6f/0x8b
[4296372.670000]  [<b0103816>] common_interrupt+0x1a/0x20
[4296372.670000]  [<f8e74986>] yenta_interrupt+0x11/0xb7 [yenta_socket]
[4296372.670000]  [<b0138efd>] handle_IRQ_event+0x2e/0x5a
[4296372.670000]  [<b0138fb2>] __do_IRQ+0x89/0x127
[4296372.670000]  [<b010507d>] do_IRQ+0x53/0x8b
[4296372.670000]  =======================
[4296372.670000]  [<f9434c29>] rm_isr_bh+0x61/0x68 [nvidia]
[4296372.670000]  [<b0103816>] common_interrupt+0x1a/0x20
[4296372.670000]  [<b011cfa3>] __do_softirq+0x37/0x92
[4296372.670000]  [<b0105104>] do_softirq+0x4f/0x5b
[4296372.670000]  =======================
[4296372.670000]  [<b011d0e2>] irq_exit+0x38/0x3a
[4296372.670000]  [<b0105084>] do_IRQ+0x5a/0x8b
[4296372.670000]  [<b0103816>] common_interrupt+0x1a/0x20
[4296372.670000]  [<b023ac57>] serial_out+0x29/0x5f
[4296372.670000]  [<b023cd08>] serial8250_startup+0x18e/0x4e8
[4296372.670000]  [<b0238b9e>] uart_startup+0x3c/0x177
[4296372.670000]  [<b0238dad>] uart_open+0xd4/0x4af
[4296372.670000]  [<b0225b42>] check_tty_count+0x45/0xbb
[4296372.670000]  [<b02c28a2>] __mutex_unlock_slowpath+0xd0/0x218
[4296372.670000]  [<b022865d>] tty_open+0x163/0x328
[4296372.670000]  [<b02284fa>] tty_open+0x0/0x328
[4296372.670000]  [<b0161b32>] chrdev_open+0xed/0x1eb
[4296372.670000]  [<b01577d7>] __dentry_open+0xe4/0x252
[4296372.670000]  [<b01579d2>] nameidata_to_filp+0x31/0x3a
[4296372.670000]  [<b0161a45>] chrdev_open+0x0/0x1eb
[4296372.670000]  [<b0157a14>] do_filp_open+0x39/0x40
[4296372.670000]  [<b01576cd>] get_unused_fd+0xa7/0xcd
[4296372.670000]  [<b0157a59>] do_sys_open+0x3e/0xba
[4296372.670000]  [<b0157b10>] sys_open+0x1c/0x20
[4296372.670000]  [<b0102d87>] sysenter_past_esp+0x54/0x75
[4296382.595000] pccard: card ejected from slot 0

stiffy ~ # pccardctl info
PRODID_1="3Com"
PRODID_2="3CRWB6096B Bluetooth PC Card"
PRODID_3=""
PRODID_4=""
MANFID=0101,0041
FUNCID=2
PRODID_1=""
PRODID_2=""
PRODID_3=""
PRODID_4=""
MANFID=0000,0000
FUNCID=255
stiffy ~ # pccardctl ident
Socket 0:
  product info: "3Com", "3CRWB6096B Bluetooth PC Card", "", ""
  manfid: 0x0101, 0x0041
  function: 2 (serial)
Socket 1:
  no product info available






Regards,
	Marc

