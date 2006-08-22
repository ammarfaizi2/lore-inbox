Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751344AbWHVIdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbWHVIdM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 04:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbWHVIdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 04:33:12 -0400
Received: from exprod6og50.obsmtp.com ([64.18.1.181]:40576 "HELO
	exprod6og50.obsmtp.com") by vger.kernel.org with SMTP
	id S1751344AbWHVIdL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 04:33:11 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: 
Date: Tue, 22 Aug 2006 10:33:09 +0200
Message-ID: <DA6197CAE190A847B662079EF7631C0602E1B7D5@OEKAW2EXVS03.hbi.ad.harman.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Index: AcbFxZlGJJAuRKT8RbaPX8qSr6X5xg==
From: "Jurzitza, Dieter" <DJurzitza@harmanbecker.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 22 Aug 2006 08:33:09.0952 (UTC) 
    FILETIME=[9966D400:01C6C5C5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Mr. Miller,
dear listmembers,

I have been gently advised to send this message to the list directly, so here you go. Sorry for the bounces:


the posting below I sent initially in 2004 - quite some time ago. See below. Sorry, maybe I sent to debian sparc instead of sparclinux, and I did not make a CC to sparclinux right now. Here you see two debug - inputs "Size of table: 1843, what is too much to work, because SPARC 64 off stock can only do 1820 for Size of table.

     Dec 13 09:35:10 oekalux09 syslogd 1.4.1#16: restart.
     Dec 13 09:35:10 oekalux09 kernel: klogd 1.4.1#16, log source = /proc/kmsg started.
     Dec 13 09:35:10 oekalux09 kernel: Inspecting /boot/System.map-2.4.26-SMP
     Dec 13 09:35:11 oekalux09 kernel: Loaded 14411 symbols from /boot/System.map-2.4.26-SMP.
     Dec 13 09:35:11 oekalux09 kernel: Symbols match kernel version 2.4.26.
**** Dec 13 09:35:11 oekalux09 kernel: Loading kernel module symbols - Size of table: 1843 Sizeof alloc: >>117952 /* debugging */
**** Dec 13 09:35:11 oekalux09 kernel: We use __GLIBC__ for klogd  /* debugging */
>>>> Dec 13 09:35:11 oekalux09 kernel: Error reading kernel symbols - Cannot allocate memory
     Dec 13 09:35:11 oekalux09 kernel: Errno was: -1 
     Dec 13 09:35:11 oekalux09 kernel: PROMLIB: Sun IEEE Boot Prom 3.23.1 1999/07/16 12:08
     Dec 13 09:35:12 oekalux09 kernel: Linux version 2.4.26-SMP (root@oekalux09) (gcc-Version 3.3.4 (Debian 1:3.3.4-13)) #1 SMP Mo Dez 13 09:01:5

And the root cause is:
> What I found is that the allocation works up to 1820 elements
> of the size 72 Bytes, however, we would need a tiny little 
> more (1843 in my case, please take a look into the attachement).

and the solution is: use an unsigned int rather than an unsigned long for "value" in struct kernel_sym. The reason for this I (I think) explained. And the only possible cause is the fact that sizeof (unsgned long) in kernel space is 8 and not 4, because the array of char in struct kernel_sym cannot cause this.

Using my suggested patch I get (today since then ...) no error, no warning:

Aug 15 06:48:54 oekalux08 syslogd 1.4.1: restart.
Aug 15 06:48:55 oekalux08 in.identd[634]: started
Aug 15 06:48:59 oekalux08 kernel: klogd 1.4.1, log source = /proc/kmsg started. Aug 15 06:48:59 oekalux08 kernel: Inspecting /boot/System.map-2.4.33-SMP Aug 15 06:49:00 oekalux08 kernel: Loaded 14439 symbols from /boot/System.map-2.4.33-SMP. Aug 15 06:49:00 oekalux08 kernel: Symbols match kernel version 2.4.33. Aug 15 06:49:00 oekalux08 kernel: Loaded 241 symbols from 11 modules. Aug 15 06:49:00 oekalux08 kernel: ip_tables: (C) 2000-2002 Netfilter core team Aug 15 06:49:00 oekalux08 kernel: ip_conntrack version 2.1 (4015 buckets, 32120 max) - 416 bytes per conntrack


If you say this cannot work: please be more specific. If you need even debug output showing exactly this, I can provide. As a matter of fact: it works. If the reason why it works differs from my explanation I would highly appreciate to be told why. Just saying: "I cannot see why this should work" is hardly of any help for understanding things.

Take care



Dieter Jurzitza


-- 
________________________________________________

HARMAN BECKER AUTOMOTIVE SYSTEMS

Dr.-Ing. Dieter Jurzitza
Manager Hardware Systems
   System Development

Industriegebiet Ittersbach
Becker-Göring Str. 16
D-76307 Karlsbad / Germany

Phone: +49 (0)7248 71-1577
Fax:   +49 (0)7248 71-1216
eMail: DJurzitza@harmanbecker.com
Internet: http://www.becker.de
 


*******************************************
Diese E-Mail enthaelt vertrauliche und/oder rechtlich geschuetzte Informationen. Wenn Sie nicht der richtige Adressat sind oder diese E-Mail irrtuemlich erhalten haben, informieren Sie bitte sofort den Absender und loeschen Sie diese Mail. Das unerlaubte Kopieren sowie die unbefugte Weitergabe dieser Mail ist nicht gestattet.
 
This e-mail may contain confidential and/or privileged information. If you are not the intended recipient (or have received this e-mail in error) please notify the sender immediately and delete this e-mail. Any unauthorized copying, disclosure or distribution of the contents in this e-mail is strictly forbidden.
*******************************************

