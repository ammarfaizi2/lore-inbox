Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932174AbVKLGjQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbVKLGjQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 01:39:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932176AbVKLGjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 01:39:16 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:31177 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S932174AbVKLGjP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 01:39:15 -0500
Date: Fri, 11 Nov 2005 23:39:14 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
       parisc-linux@parisc-linux.org
Subject: 2.6.15-rc1 freeing a reserved page from uart_shutdown
Message-ID: <20051112063914.GH1658@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm having some trouble with 2.6.15-rc1:

VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 640k freed
Bad page state at free_hot_cold_page (in process 'init', page 108a24a0)
flags:0x00000400 mapping:00000000 mapcount:0 count:0
Backtrace:
Backtrace:
 [<101481cc>] bad_page+0x70/0xc4
 [<10148920>] free_hot_cold_page+0x74/0x124
 [<10275e68>] uart_shutdown+0xf0/0xf8
 [<102775f8>] uart_close+0xc8/0x214
 [<1025c710>] release_dev+0x72c/0x734
 [<1025cddc>] tty_release+0x10/0x20
 [<101680f0>] __fput+0x15c/0x170
 [<10166520>] filp_close+0x58/0x94
 [<1010d114>] syscall_exit+0x0/0x14

This is on a parisc system, though a very similar tree boots fine on a
different machine.  The machine which produces this message is a K460
which uses the Mux serial driver.  As far as I can tell, the only call
to free_hot_cold_page() in uart_shutdown() is to free info->xmit.buf
which seems to be always filled by a call to get_zeroed_page().

This problem doesn't show with 2.6.14.  I can give access to this
machine to anyone who wants to do some debugging.  It has remote power
capabilities ;-)
