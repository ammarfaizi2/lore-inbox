Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266666AbUBLXSH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 18:18:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266675AbUBLXSH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 18:18:07 -0500
Received: from smtp08.auna.com ([62.81.186.18]:37354 "EHLO smtp08.retemail.es")
	by vger.kernel.org with ESMTP id S266666AbUBLXSE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 18:18:04 -0500
Date: Fri, 13 Feb 2004 00:18:02 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Strange problem with emu10k1 and gcc-3.4
Message-ID: <20040212231802.GG4092@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.16
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi al...

I have tried to build 2.6.3-rc2-mm1 with gcc-3.4, and it works apart from this:

werewolf:/boot# modprobe emu10k1
FATAL: Error inserting emu10k1 (/lib/modules/2.6.3-rc1-jam1-gcc34/kernel/sound/oss/emu10k1/emu10k1.ko): Unknown symbol in module, or unknown parameter (see dmesg)

dmesg:
...
emu10k1: Unknown symbol strcpy

I think this solves the problem:

--- linux-2.6.3-rc2-jam1/sound/oss/emu10k1/efxmgr.h.orig	2004-02-12 23:55:14.210762109 +0100
+++ linux-2.6.3-rc2-jam1/sound/oss/emu10k1/efxmgr.h	2004-02-12 23:56:02.771954542 +0100
@@ -32,6 +32,8 @@
 #ifndef _EFXMGR_H
 #define _EFXMGR_H
 
+#include <linux/string.h>
+
 struct emu_efx_info_t{
 	int opcode_shift;
 	int high_operand_shift;

The strange thing is: why depmod -ae does not show any problem ?

TIA

-- 
J.A. Magallon <jamagallon()able!es>     \                 Software is like sex:
werewolf!able!es                         \           It's better when it's free
Mandrake Linux release 10.0 (Cooker) for i586
Linux 2.6.3-rc1-jam1-gcc34 (gcc 3.4.0 (Mandrake Linux 10.0 3.4.0-0.1mdk))
