Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262443AbVESBwM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262443AbVESBwM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 21:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262445AbVESBwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 21:52:12 -0400
Received: from mail2.dolby.com ([204.156.147.24]:3079 "EHLO dolby.com")
	by vger.kernel.org with ESMTP id S262442AbVESBv6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 21:51:58 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Subject: RE: Illegal use of reserved word in system.h
Date: Wed, 18 May 2005 18:51:20 -0700
Message-ID: <2692A548B75777458914AC89297DD7DA05EC7245@bronze.dolby.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Illegal use of reserved word in system.h
Thread-Index: AcVb41YbQOXVwtuASGeXaaVClNHiWQALba4A
From: "Gilbert, John" <JGG@dolby.com>
To: <linux-kernel@vger.kernel.org>
Content-Type: text/plain;
	charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk writes:

that's not a check whether the system supports SMP.

Looking at the source code of MySQL, it seems MySQL does some dirty
tricks for using the inlines from asm/atomic.h in userspace.

It's _really_ wrong to do this.

#JG
So the really, really stupid, idiotic, yet quick and effective hack to
get MySQL to build under a later 2.6 kernel is as follows. In
mysql-4.1.12/include/my_global.h, right after the three #ifndef
CONFIG_SMP lines, add these lines...
#ifndef CONFIG_NR_CPUS
#define CONFIG_NR_CPUS
#endif /* CONFIG_NR_CPUS */

This way, MySQL can continue depending on the SMP atomic macros in
asm-i386 from the Linux kernel, without going into kernel space. I
strongly doubt this is truly multithreaded (or SMP) safe, but that's how
MySQL has been running since 4.0 at least. Someone in the know should
fix this, and end this silliness.

John Gilbert
Thanks for ignoring the sig.

-----------------------------------------
This message (including any attachments) may contain confidential
information intended for a specific individual and purpose.  If you are not
the intended recipient, delete this message.  If you are not the intended
recipient, disclosing, copying, distributing, or taking any action based on
this message is strictly prohibited.

