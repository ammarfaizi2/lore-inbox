Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264837AbTFQV5o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 17:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264928AbTFQV5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 17:57:44 -0400
Received: from netmail01.services.quay.plus.net ([212.159.14.219]:55274 "HELO
	netmail01.services.quay.plus.net") by vger.kernel.org with SMTP
	id S264837AbTFQV5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 17:57:41 -0400
From: "Riley Williams" <Riley@Williams.Name>
To: <davidm@hpl.hp.com>
Cc: "Vojtech Pavlik" <vojtech@suse.cz>, <linux-kernel@vger.kernel.org>
Subject: RE: [patch] input: Fix CLOCK_TICK_RATE usage ...  [8/13]
Date: Tue, 17 Jun 2003 23:11:46 +0100
Message-ID: <BKEGKPICNAKILKJKMHCAEEOAEFAA.Riley@Williams.Name>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <16110.4883.885590.597687@napali.hpl.hp.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David.

 > Riley> 2. The IA64 arch didn't define CLOCK_TICK_RATE at all, but
 > Riley>    then used the 1193182 value as a magic value in several
 > Riley>    files. I've inserted that as the definition thereof in
 > Riley>    timex.h for that arch.

 > AFAIK, on ia64, it makes absolutely no sense at all to define this
 > magic CLOCK_TICK_RATE in timex.h. There simply is nothing in the
 > ia64 architecture that requires any timer to operate at 1193182 Hz.

I think we're talking at cross-purposes here. The kernel includes a
timer that, amongst other things, measures how long it's been up, and
on most architectures, this is based on a hardware timer that runs at
a particular frequency. This define states what frequency that timer
runs at, nothing more nor less than that.

On most architectures, the said timer runs at 1,193,181.818181818 Hz.
However, there is absolutely nothing that states that it has to run at
that frequency. Indeed, some of the other architectures run at wildly
different frequencies from that one - varying from 25,000 Hz right up
to 40,000,000 Hz.

 > If there are drivers that rely on the frequency, those drivers
 > should be fixed instead.

There are generic drivers that rely on knowing the frequency of the
kernel timer, and those are almost certainly currently bug-ridden in
any architecture where the kernel timer doesn't run at the above
frequency simply because they currently assume it runs at that
frequency. However, ANY bugfix involves each architecture declaring
the frequency its particular kernel timer runs at, and thus requires
the CLOCK_TICK_RATE macro to be defined.

 > Please do not add CLOCK_TICK_RATE to the ia64 timex.h header file.

It needs to be declared there. The only question is regarding the
value it is defined to, and it would have to be somebody with better
knowledge of the ia64 than me who decides that. All I can do is to
post a reasonable default until such decision is made.

Best wishes from Riley.
---
 * Nothing as pretty as a smile, nothing as ugly as a frown.

---
Outgoing mail is certified Virus Free.
Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.490 / Virus Database: 289 - Release Date: 16-Jun-2003

