Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266663AbUGQAnQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266663AbUGQAnQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 20:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266664AbUGQAnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 20:43:16 -0400
Received: from pxy5allmi.all.mi.charter.com ([24.247.15.44]:28830 "EHLO
	proxy5-grandhaven.chartermi.net") by vger.kernel.org with ESMTP
	id S266663AbUGQAnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 20:43:12 -0400
Message-ID: <40F87613.9060606@quark.didntduck.org>
Date: Fri, 16 Jul 2004 20:42:59 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040625
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] remove scripts/mkconfigs
Content-Type: multipart/mixed;
 boundary="------------050107030104020108080304"
X-Charter-Information: 
X-Charter-Scan: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050107030104020108080304
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This script is no longer used after the patch to consolidate the stored 
configs.

--
				Brian Gerst

--------------050107030104020108080304
Content-Type: text/plain;
 name="remove-mkconfigs"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="remove-mkconfigs"

diff -urN linux-2.6.8-rc1-bk/scripts/mkconfigs linux/scripts/mkconfigs
--- linux-2.6.8-rc1-bk/scripts/mkconfigs	2004-07-13 10:27:33.000000000 -0400
+++ linux/scripts/mkconfigs	1969-12-31 19:00:00.000000000 -0500
@@ -1,67 +0,0 @@
-#!/bin/sh
-#
-# Copyright (C) 2002 Khalid Aziz <khalid_aziz@hp.com>
-# Copyright (C) 2002 Randy Dunlap <rddunlap@osdl.org>
-# Copyright (C) 2002 Al Stone <ahs3@fc.hp.com>
-# Copyright (C) 2002 Hewlett-Packard Company
-#
-#   This program is free software; you can redistribute it and/or modify
-#   it under the terms of the GNU General Public License as published by
-#   the Free Software Foundation; either version 2 of the License, or
-#   (at your option) any later version.
-#
-#   This program is distributed in the hope that it will be useful,
-#   but WITHOUT ANY WARRANTY; without even the implied warranty of
-#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#   GNU General Public License for more details.
-#
-#   You should have received a copy of the GNU General Public License
-#   along with this program; if not, write to the Free Software
-#   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-#
-# 
-# Rules to generate ikconfig.h from linux/.config:
-#	- Retain lines that begin with "CONFIG_"
-#	- Retain lines that begin with "# CONFIG_"
-#	- lines that use double-quotes must \\-escape-quote them
-
-if [ $# -lt 2 ]
-then
-	echo "Usage: `basename $0` <configuration_file> <Makefile>"
-	exit 1
-fi
-
-config=$1
-makefile=$2
-
-cat << EOF
-#ifndef _IKCONFIG_H
-#define _IKCONFIG_H
-/*
- * 
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or (at
- * your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
- * NON INFRINGEMENT.  See the GNU General Public License for more
- * details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- *
- *
- * 
- * This file is generated automatically by scripts/mkconfigs. Do not edit.
- *
- */
-static char const ikconfig_config[] __attribute__((unused)) =
-"CONFIG_BEGIN=n\\n\\
-$(sed < $config -n 's/"/\\"/g;/^#\? \?CONFIG_/s/.*/&\\n\\/p')
-CONFIG_END=n\\n";
-#endif /* _IKCONFIG_H */
-EOF

--------------050107030104020108080304--
