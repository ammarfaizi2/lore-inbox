Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262011AbTEMQFG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 12:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262015AbTEMQFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 12:05:05 -0400
Received: from netmail02.services.quay.plus.net ([212.159.14.221]:32394 "HELO
	netmail02.services.quay.plus.net") by vger.kernel.org with SMTP
	id S262011AbTEMQDg (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Tue, 13 May 2003 12:03:36 -0400
From: "Riley Williams" <Riley@Williams.Name>
To: "Linux Kernel List" <Linux-Kernel@vger.kernel.org>
Subject: Pristine 2.5.69 warnings for make defconfig
Date: Tue, 13 May 2003 17:16:20 +0100
Message-ID: <BKEGKPICNAKILKJKMHCAOEGPCPAA.Riley@Williams.Name>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

Using the pristine 2.5.69 source tree, there are several warnings generated
for `make defconfig ; make` which I am curious about. These are as follows:

 Q> kernel/ksyms.c:453: warning: `__check_region' is deprecated
 Q>				(declared at include/linux/ioport.h:113)

This corresponds to the line:

 453>	EXPORT_SYMBOL(__check_region);

Next, there is:

 Q> drivers/ide/ide-probe.c: In function `hwif_check_region':
 Q> drivers/ide/ide-probe.c:642: warning: `__check_region' is deprecated
 Q> 				(declared at include/linux/ioport.h:113)
 Q> drivers/ide/ide-probe.c:644: warning: `__check_region' is deprecated
 Q>				(declared at include/linux/ioport.h:113)

These correspond to the lines:

641>	if(hwif->mmio)
642>		err = check_mem_region(addr, num);
643>	else
644>		err = check_region(addr, num);

Next, there is:

 Q> drivers/pnp/resource.c: In function `pnp_check_port':
 Q> drivers/pnp/resource.c:298: warning: `__check_region' is deprecated
 Q>				(declared at include/linux/ioport.h:113)
 Q> drivers/pnp/resource.c: In function `pnp_check_mem':
 Q> drivers/pnp/resource.c:369: warning: `__check_region' is deprecated
 Q>				(declared at include/linux/ioport.h:113)

These correspond respectively to the lines:

298>	if (check_region(*port, length(port,end)))
 :
369>	if (__check_region(&iomem_resource, *addr, length(addr,end)))

I will also add that this "depreciated" function is found in the kernel
tree (after `make defconfig ; make` completes) as follows:

 Q> Binary file drivers/ide/ide-probe.o matches
 Q> Binary file drivers/ide/built-in.o matches
 Q> drivers/pnp/resource.c:369:
 Q> Binary file drivers/pnp/resource.o matches
 Q> Binary file drivers/pnp/built-in.o matches
 Q> Binary file drivers/built-in.o matches
 Q> include/linux/ioport.h:108:
 Q> include/linux/ioport.h:110:
 Q> include/linux/ioport.h:113:
 Q> Binary file arch/i386/boot/compressed/vmlinux.bin matches
 Q> kernel/ksyms.c:453:
 Q> kernel/resource.c:304:
 Q> Binary file kernel/resource.o matches
 Q> Binary file kernel/ksyms.o matches
 Q> Binary file kernel/built-in.o matches
 Q> Binary file .tmp_vmlinux1 matches
 Q> Binary file .tmp_vmlinux2 matches
 Q> Binary file vmlinux matches
 Q> System.map:716:c0122a5f T __check_region
 Q> System.map:13232:c0436524 r __ksymtab___check_region
 Q> System.map:15618:c043bd52 r __kstrtab___check_region

Next, there is:

 Q> include/asm/string.h:145: warning: `strchr' defined but not used

This corresponds to the lines:

144>	static inline char * strchr(const char * s, int c)
145>	{
146>	int d0;
147>	register char * __res;
148>	__asm__ __volatile__(
149>		"movb %%al,%%ah\n"
150>		"1:\tlodsb\n\t"
151>		"cmpb %%ah,%%al\n\t"
152>		"je 2f\n\t"
153>		"testb %%al,%%al\n\t"
154>		"jne 1b\n\t"
155>		"movl $1,%1\n"
156>		"2:\tmovl %1,%0\n\t"
157>		"decl %0"
158>		:"=a" (__res), "=&S" (d0) : "1" (s),"0" (c));
159>		return __res;
160>	}

Finally, there is:

 Q> drivers/scsi/qla1280.c:5948: warning:
 Q>		initialization from incompatible pointer type
 Q> drivers/scsi/qla1280.c:5948: warning:
 Q>		initialization from incompatible pointer type

These correspond to the line:

5948>	static Scsi_Host_Template driver_template = QLA1280_LINUX_TEMPLATE;	

Somebody will probably tell me that all of these are false positives,
but that doesn't worry me.

Best wishes from Riley.
---
 * Nothing as pretty as a smile, nothing as ugly as a frown.

---
Outgoing mail is certified Virus Free.
Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.478 / Virus Database: 275 - Release Date: 6-May-2003

