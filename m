Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268308AbTGNQCW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 12:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270111AbTGNQCW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 12:02:22 -0400
Received: from netmail02.services.quay.plus.net ([212.159.14.221]:27074 "HELO
	netmail02.services.quay.plus.net") by vger.kernel.org with SMTP
	id S268308AbTGNQCL (ORCPT <rfc822;Linux-Kernel@Vger.kernel.org>);
	Mon, 14 Jul 2003 12:02:11 -0400
From: "Riley Williams" <Riley@Williams.Name>
To: <koala.gnu@tiscalinet.it>
Cc: <Linux-Kernel@Vger.kernel.org>
Subject: RE: Linux boot code
Date: Mon, 14 Jul 2003 17:15:08 +0100
Message-ID: <BKEGKPICNAKILKJKMHCACEAKEOAA.Riley@Williams.Name>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <3F12AC57.2080609@tiscalinet.it>
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

 > I am looking at the boot code in bootsect.S and I have some doubt.
 > I tried to search the answers to my questions on
 > marc.theaimsgroup.com and on Google but I haven't found them.

I know nothing about the former site, so can't comment thereon.

 > Probably these are newbie question but I'll appreciate if someone
 > of you help me.

I'll do what I can.

 > 1) In the bootsect code the first thing that is done is to copy
 >    the boot sector to 0x90000 and move the program count to
 >    0x9000, go. Why it is necessary move the code there? Is it not
 >    possible continue the process from 0x7C00?

Following moving the boot code there, the next step is to load the
kernel image, either from 0x10000 (64k) or from 1M upwards, this
being dependent on various factors. However, the boot sector holds
several flags whose values are important AFTER the kernel image has
been loaded, so is moved out the way first.

 > 2) Another step is to move the parameters table from 0x78:0 to
 >    0x9000:0x4000-12. What are the info contained in this table?
 >    Can you send me a link to a site that specify these info?
 >    Without these info I am not able to understand these three
 >    line of code
 >
 >        movb    $36, 0x4(%di)           # patch sector count
 >        movw    %di, %fs:(%bx)
 >        movw    %es, %fs:2(%bx)

That area of memory contains parameters configured by the BIOS of
the machine in question. I would suspect it's the parameters for
the floppy drives, and the code that follows is presumably that
used to determine how many sectors per track the floppy in /dev/fd0
actually has.

 > Thanks in advance for your help

No problem.

Best wishes from Riley.
---
 * Nothing as pretty as a smile, nothing as ugly as a frown.

---
Outgoing mail is certified Virus Free.
Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.500 / Virus Database: 298 - Release Date: 10-Jul-2003

