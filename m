Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264668AbTFLCDj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 22:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264671AbTFLCDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 22:03:39 -0400
Received: from netmail01.services.quay.plus.net ([212.159.14.219]:54156 "HELO
	netmail01.services.quay.plus.net") by vger.kernel.org with SMTP
	id S264668AbTFLCDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 22:03:38 -0400
From: "Riley Williams" <Riley@Williams.Name>
To: "Andrew Morton" <akpm@digeo.com>, "Steve French" <smfrench@austin.rr.com>
Cc: <ak@suse.de>, <linux-kernel@vger.kernel.org>
Subject: RE: Compiling kernel with SuSE 8.2/gcc 3.3
Date: Thu, 12 Jun 2003 03:17:22 +0100
Message-ID: <BKEGKPICNAKILKJKMHCAAEMEEEAA.Riley@Williams.Name>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
In-Reply-To: <20030611184045.21f1fc83.akpm@digeo.com>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew.

 >> Although it fixes it for building on 32 bit architectures, 
 >> won't changing
 >>
 >>	__u64 uid = 0xFFFFFFFFFFFFFFFF;
 >>
 >> to
 >>
 >>	__u64 uid = 0xFFFFFFFFFFFFFFFFULL;
 >>
 >> generate a type mismatch warning on ppc64 and similar 64
 >> bit architectures since __u64 is not a unsigned long long
 >> on ppc64 (it is unsigned long)?

 >	u64 uid = -1;
 >
 > will work just nicely.

Won't that generate a warning about assigning a signed quantity
to an unsigned variable?

What's really needed is a set of definitions along the lines of

	#define MAX_U32	((__u32) 0xFFFFFFFFUL)
	#define MAX_U64	((__u64) 0xFFFFFFFFFFFFFFFFULL)

but as an intermediate measure, how about...

	__u64 uid = ((__u64) 0xFFFFFFFFFFFFFFFFULL);

Best wishes from Riley.
---
 * Nothing as pretty as a smile, nothing as ugly as a frown.

---
Outgoing mail is certified Virus Free.
Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.488 / Virus Database: 287 - Release Date: 5-Jun-2003

