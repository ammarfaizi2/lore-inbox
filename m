Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932796AbVHTTEa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932796AbVHTTEa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 15:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932795AbVHTTE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 15:04:29 -0400
Received: from mta10.adelphia.net ([68.168.78.202]:1757 "EHLO
	mta10.adelphia.net") by vger.kernel.org with ESMTP id S932793AbVHTTE2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 15:04:28 -0400
Message-ID: <43077EBB.5060705@adelphia.net>
Date: Sat, 20 Aug 2005 15:04:27 -0400
From: mikep <mikpolniak@adelphia.net>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050808)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: SCSI- unexpected disconnect with kernel-2.6.13-r6
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am using a LSIU160/Symbios 53c1010 Ultra3 scsi adapter and it works at 
full speed (75 MB/sec) with kernel-2.6.12. And dmesg shows:

kernel:  target0:0:0: Beginning Domain Validation
kernel:  target0:0:0: asynchronous.
kernel: WIDTH IS 1
kernel:  target0:0:0: wide asynchronous.
kernel:  target0:0:0: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 62)
kernel:  target0:0:0: Ending Domain Validation
kernel: sym1: <1010-33> rev 0x1 at pci 0000:01:07.1 irq 11
kernel: sym1: Symbios NVRAM, ID 7, Fast-80, SE, parity checking
kernel: sym1: open drain IRQ line driver
kernel: sym1: using LOAD/STORE-based firmware.
kernel: sym1: handling phase mismatch from SCRIPTS.
kernel: sym1: SCSI BUS has been reset.
kernel: scsi1 : sym-2.2.0
kernel: libata version 1.11 loaded.

With kernel-2.6.13-r6 the speed drops back to 2.70 MB/sec because of
validation failure and dmesg shows:

kernel:  target0:0:0: Beginning Domain Validation
kernel:  target0:0:0: asynchronous.
kernel:  target0:0:0: wide asynchronous.
kernel:  target0:0:0: FAST-80 WIDE SCSI 160.0 MB/s DT IU QAS (
kernel: sym0: unexpected disconnect
kernel:  target0:0:0: Write Buffer failure 700ff
kernel:  target0:0:0: Domain Validation Disabing Information units
kernel:  0:0:0:0: phase change 6-7 11@3fb3c3a8 resid=10.
kernel:  target0:0:0: asynchronous.
kernel: sym0: unexpected disconnect
target0:0:0: Write Buffer failure 700ff
target0:0:0: Domain Validation detected failure, dropping back
kernel:  target0:0:0: asynchronous.
target0:0:0: Ending Domain Validation
kernel: sym1: <1010-33> rev 0x1 at pci 0000:01:07.1 irq 11
kernel: sym1: Symbios NVRAM, ID 7, Fast-80, SE, parity checkingkernel: 
sym1:
 open drain IRQ line driver, using on-chip SRAM
kernel: sym1: using LOAD/STORE-based firmware.
kernel: sym1: handling phase mismatch from SCRIPTS.
kernel: sym1: SCSI BUS has been reset.
kernel: scsi1 : sym-2.2.1
kernel: libata version 1.11 loaded.

The kernel config has:

CONFIG_SCSI_SYM53C8XX_2=y
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
# CONFIG_SCSI_SYM53C8XX_IOMAPPED is not set

