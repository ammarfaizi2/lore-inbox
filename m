Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030189AbWADJ2w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030189AbWADJ2w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 04:28:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030190AbWADJ2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 04:28:51 -0500
Received: from general.keba.co.at ([193.154.24.243]:8358 "EHLO
	helga.keba.co.at") by vger.kernel.org with ESMTP id S1030189AbWADJ2v convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 04:28:51 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Latency traces I cannot interpret (sa1100, 2.6.15-rc7-rt1)
Date: Wed, 4 Jan 2006 10:28:40 +0100
Message-ID: <AAD6DA242BC63C488511C611BD51F367323316@MAILIT.keba.co.at>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Latency traces I cannot interpret (sa1100, 2.6.15-rc7-rt1)
Thread-Index: AcYQcF34B1nTsxHXR3ipoHL7OvRAMgAn5TpQ
From: "kus Kusche Klaus" <kus@keba.com>
To: "Daniel Walker" <dwalker@mvista.com>
Cc: "Ingo Molnar" <mingo@elte.hu>, "Lee Revell" <rlrevell@joe-job.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Daniel Walker
> Ok, yet another patch. This one uses the correct lowlevel calls, and I
> fixed the call ordering.

Hmm, I have no deep knowledge of ARM assembler programming,
but your patch branches to a C subroutine without setting up a
return address in the lr register.

Hence, the return in trace_irqs_... jumps to god-knows-where,
but not back to the next instruction.

As a wild guess, I replaced the "b trace_irqs_..." with
"bl trace_irqs_...".

With this change, the kernel boots fine, but the system seems to go
into an infinite loop as soon as the first usermode processes start.
Most likely, my change messes up the lr register of some surrounding
context.

-- 
Klaus Kusche                 (Software Development - Control Systems)
KEBA AG             Gewerbepark Urfahr, A-4041 Linz, Austria (Europe)
Tel: +43 / 732 / 7090-3120                 Fax: +43 / 732 / 7090-6301
E-Mail: kus@keba.com                                WWW: www.keba.com
