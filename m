Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262460AbUKQT1n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262460AbUKQT1n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 14:27:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262510AbUKQTZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 14:25:51 -0500
Received: from fire.osdl.org ([65.172.181.4]:19634 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S262460AbUKQTYd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 14:24:33 -0500
Message-ID: <419BA1C0.3040601@osdl.org>
Date: Wed, 17 Nov 2004 11:08:48 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
CC: linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com
Subject: [PATCH] oops on boot when initializing CDROM
References: <Pine.LNX.4.58.0411162336510.24144@artax.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.58.0411162336510.24144@artax.karlin.mff.cuni.cz>
Content-Type: multipart/mixed;
 boundary="------------070904000103010908070504"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070904000103010908070504
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Mikulas Patocka wrote:
> When booting kernel 2.4.27 on notebook with cd-rw dvd-ro drive, I get oops
> on cdrom_sysctl_register+2a trying to dereference address 20.
> Call stack: register_cdrom+235
> 
> gcc-3.2.3

Thanks for the .config file.

with: CONFIG_SYSCTL=y, CONFIG_PROC_FS=n

Am I confused here, or is the 2.4 (and 2.6) source code confused?


diffstat:=
  drivers/cdrom/cdrom.c |    2 --
  1 files changed, 2 deletions(-)

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>
-- 

--------------070904000103010908070504
Content-Type: text/x-patch;
 name="cdrom_sysctl_24.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cdrom_sysctl_24.patch"

diff -Naurp ./drivers/cdrom/cdrom.c~cdrom_sysctl ./drivers/cdrom/cdrom.c
--- ./drivers/cdrom/cdrom.c~cdrom_sysctl	2003-11-28 10:26:20.000000000 -0800
+++ ./drivers/cdrom/cdrom.c	2004-11-17 10:45:45.666804288 -0800
@@ -2598,9 +2598,7 @@ ctl_table cdrom_cdrom_table[] = {
 
 /* Make sure that /proc/sys/dev is there */
 ctl_table cdrom_root_table[] = {
-#ifdef CONFIG_PROC_FS
 	{CTL_DEV, "dev", NULL, 0, 0555, cdrom_cdrom_table},
-#endif /* CONFIG_PROC_FS */
 	{0}
 	};
 static struct ctl_table_header *cdrom_sysctl_header;

--------------070904000103010908070504--
