Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265215AbTFMHPG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 03:15:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265218AbTFMHPG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 03:15:06 -0400
Received: from netmail02.services.quay.plus.net ([212.159.14.221]:29929 "HELO
	netmail02.services.quay.plus.net") by vger.kernel.org with SMTP
	id S265215AbTFMHPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 03:15:00 -0400
From: "Riley Williams" <Riley@Williams.Name>
To: "Linus Torvalds" <torvalds@transmeta.com>, <davidm@hpl.hp.com>
Cc: <roland@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] FIXMAP-related change to mm/memory.c
Date: Fri, 13 Jun 2003 08:28:47 +0100
Message-ID: <BKEGKPICNAKILKJKMHCAIEALEFAA.Riley@Williams.Name>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <Pine.LNX.4.44.0306122219580.2989-100000@home.transmeta.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, all.

 >> Is it possible to constrain the FIXADDR range on x86/x86-64
 >> (FIXADDR_START-FIXADDR_TOP) such that the entire range is
 >> read-only by user-level?  If so, we could simplify the
 >> permission test like this:

 > Well, you could replace the uses of FIXADDR_START/FIXADDR_TOP
 > with something like FIXADDR_USER_START/FIXADDR_USER_TOP, and
 > then force those to cover only the _one_ user-accessible page.
 >
 > Something like
 >
 >	#define FIXADDR_USER_START (fix_to_virt(FIX_VSYSCALL))
 >	#define FIXADDR_USER_END (FIXADDR_USER_START + PAGE_SIZE)
 >
 > should work. In that case you can drop the page table testing,
 > since we "know" it is safe.

Should FIXADDR_USER_END point to the last byte of the relevant page,
or to the first byte of the following page as per Linus's suggestion?
The above looks like an off-by-one bug to me?

Best wishes from Riley.
---
 * Nothing as pretty as a smile, nothing as ugly as a frown.

---
Outgoing mail is certified Virus Free.
Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.488 / Virus Database: 287 - Release Date: 5-Jun-2003

