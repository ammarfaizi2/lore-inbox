Return-Path: <linux-kernel-owner+w=401wt.eu-S1754805AbXABLLM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754805AbXABLLM (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 06:11:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754562AbXABLLM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 06:11:12 -0500
Received: from pne-smtpout4-sn1.fre.skanova.net ([81.228.11.168]:33955 "EHLO
	pne-smtpout4-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754805AbXABLLL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 06:11:11 -0500
Message-ID: <459A3DCD.4020701@refactor.fi>
Date: Tue, 02 Jan 2007 13:11:09 +0200
From: Leonard Norrgard <leonard.norrgard@refactor.fi>
User-Agent: Icedove 1.5.0.9 (X11/20061220)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.20-rc3: bt878/bttv: Unknown symbols, despite being defined in
 module depended on
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This seems a bit odd. As the bt878 module loads, I get the following
error messages, despite definitions in the bttv module that bt878
depends on:

# egrep '(bttv_read_gpio|bttv_write_gpio|bttv_gpio_enable)' /var/log/dmesg
bt878: Unknown symbol bttv_read_gpio
bt878: Unknown symbol bttv_write_gpio
bt878: Unknown symbol bttv_gpio_enable

SMP kernel, the cpu is an AMD Athlon(tm) 64 X2 Dual Core Processor 5200+.

Full dmesg output is at
http://bugzilla.kernel.org/attachment.cgi?id=9987&action=view (unrelated
bug, but same box).

Full config is at
http://bugzilla.kernel.org/attachment.cgi?id=9988&action=view (likewise).

Output of lspci -nn -vvx is at:
http://bugzilla.kernel.org/attachment.cgi?id=9989&action=view (likewise).

# modinfo bt878 | grep depends
depends:        bttv

# nm dvb/bt8xx/bt878.ko | egrep
'(bttv_read_gpio|bttv_write_gpio|bttv_gpio_enable)'
                 U bttv_gpio_enable
                 U bttv_read_gpio
                 U bttv_write_gpio

# nm video/bt8xx/bttv.ko | egrep
'(bttv_read_gpio|bttv_write_gpio|bttv_gpio_enable)'
0000000011dc4b6d A __crc_bttv_gpio_enable
00000000bcf2d2fb A __crc_bttv_read_gpio
000000008ecf4acc A __crc_bttv_write_gpio
0000000000000018 r __kcrctab_bttv_gpio_enable
0000000000000020 r __kcrctab_bttv_read_gpio
0000000000000028 r __kcrctab_bttv_write_gpio
0000000000000040 r __kstrtab_bttv_gpio_enable
0000000000000051 r __kstrtab_bttv_read_gpio
0000000000000060 r __kstrtab_bttv_write_gpio
0000000000000030 r __ksymtab_bttv_gpio_enable
0000000000000040 r __ksymtab_bttv_read_gpio
0000000000000050 r __ksymtab_bttv_write_gpio
000000000000898c T bttv_gpio_enable
000000000000894d T bttv_read_gpio
0000000000008909 T bttv_write_gpio

