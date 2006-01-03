Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751186AbWACH11@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbWACH11 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 02:27:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbWACH11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 02:27:27 -0500
Received: from general.keba.co.at ([193.154.24.243]:53640 "EHLO
	helga.keba.co.at") by vger.kernel.org with ESMTP id S1751186AbWACH11 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 02:27:27 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Latency traces I cannot interpret (sa1100, 2.6.15-rc7-rt1)
Date: Tue, 3 Jan 2006 08:27:19 +0100
Message-ID: <AAD6DA242BC63C488511C611BD51F367323311@MAILIT.keba.co.at>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Latency traces I cannot interpret (sa1100, 2.6.15-rc7-rt1)
Thread-Index: AcYPslyOL94lxfasSZ+043sxaUXufAAgfEsw
From: "kus Kusche Klaus" <kus@keba.com>
To: "Daniel Walker" <dwalker@mvista.com>
Cc: "Ingo Molnar" <mingo@elte.hu>, "Lee Revell" <rlrevell@joe-job.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Daniel Walker
> On Mon, 2006-01-02 at 15:55 +0100, kus Kusche Klaus wrote:
> > As I wrote in some earlier mail, I'm probably the first one ever
> > who tried it on ARM: When I tried first, tracing didn't work at all,
> > because the trace timing macro's were not defined (at least for
> > sa1100). I quick-hacked the three missing macros (this caused the
> > tracer to produce at least some output) without checking if 
> > anything else is missing.
> What macro's are you talking about? Did you submit a patch already to
> fix that? If not, please do.

Too dirty to be a patch.

The missing pieces are:
#include <asm/arch/hardware.h>
#define mach_read_cycles() (OSCR)
#define mach_cycles_to_usecs(d) ((d)>>2)
#define mach_usecs_to_cycles(d) ((d)<<2)

First of all, they are plain wrong, because they use a factor of 4,
whereas the correct factor is 3.6864
(so the timings in my traces are not really microseconds).

However, I do not know how to do that quickly and correctly...
(64 bit arithmetic?)

Moreover, they should go to include/asm-arm/arch-sa1100/timex.h,
because only SA and PXA have an OSCR timer, and because the factor
differs across the chips, but I did them in include/asm-arm/timex.h.

(however, the macros are not defined for *any* ARM chip in the
current tree)

-- 
Klaus Kusche                 (Software Development - Control Systems)
KEBA AG             Gewerbepark Urfahr, A-4041 Linz, Austria (Europe)
Tel: +43 / 732 / 7090-3120                 Fax: +43 / 732 / 7090-6301
E-Mail: kus@keba.com                                WWW: www.keba.com
