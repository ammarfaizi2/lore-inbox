Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262232AbUKKNLw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262232AbUKKNLw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 08:11:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262233AbUKKNLw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 08:11:52 -0500
Received: from mail.renesas.com ([202.234.163.13]:3207 "EHLO
	mail03.idc.renesas.com") by vger.kernel.org with ESMTP
	id S262232AbUKKNLt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 08:11:49 -0500
Date: Thu, 11 Nov 2004 22:11:36 +0900 (JST)
Message-Id: <20041111.221136.576022723.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org, gniibe@fsij.org
Subject: [PATCH 2.6.10-rc1 0/2] [m32r] Update for a new bootloader
 "m32r-g00ff"
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patchset was originally from NIIBE Yutaka.

These patch update the m32r kernel for a new bootloader "m32r-g00ff".
The "m32r-g00ff" has been written and developed by NIIBE Yutaka,
and released under the GPL from http://www.gniibe.org/.

So far, it supports two types of booting operations,
CF boot and Network boot (HTTP boot).

* CF boot - boot from CompactFlash or Microdrive(TM)
  We can boot a kernel from CF device.
  To make use of m32r-g00ff, we just put a first stage IPL(initial program
  loader) into a flash memory, and a secondary bootloader into CF media device.
  Currently, LILO-21.4.4 can be used to write m32r-g00ff into the boot sector
  of CF device on a cross development environment.

* HTTP boot - boot via network with HTTP protocol
  By using m32r-g00ff, we can download and boot a kernel image from 
  a web-server.  The m32r-g00ff downloads a kernel image from a given URL,
  resolving the webserver's IP address by DNS.
  As a preparation, we just place a secondary bootloader binary and
  a kernel image on the webserver.

Regards,

Signed-off-by: NIIBE Yutaka <gniibe@fsij.org>
Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

[PATCH 2.6.10-rc1 1/2] [m32r] Update for m32r-g00ff
- Position-independent zImage support;
  this aims at removing constraints of zImage(vmlinuz)'s location.

[PATCH 2.6.10-rc1 2/2] [m32r] CF boot support for Mappi2
- Update io_mappi2.c to access a CF device as an IDE disk device
  for Mappi2 eva board.
- Please set CONFIG_M32R_CFC=n, when you use m32r-g00ff for CF boot.

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/

