Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263817AbUEDUZu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263817AbUEDUZu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 16:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263444AbUEDUZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 16:25:50 -0400
Received: from fmr05.intel.com ([134.134.136.6]:19350 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S264349AbUEDUZn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 16:25:43 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [PATCH] mxcsr patch for i386 & x86-64
Date: Tue, 4 May 2004 13:25:33 -0700
Message-ID: <E305A4AFB7947540BC487567B5449BA802CA7C7C@scsmsx402.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] mxcsr patch for i386 & x86-64
Thread-Index: AcQyC3g+uE6KKA6ORO6c6Mn08RnfewAB3XYw
From: "Kamble, Nitin A" <nitin.a.kamble@intel.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Cc: "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>
X-OriginalArrivalTime: 04 May 2004 20:25:34.0545 (UTC) FILETIME=[F42C1C10:01C43215]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Ahh. Have we verified that the new semantics of that MXCSR_MASK field
>works on non-intel CPU's too?
Yes, this semantics is same for AMD and Intel. And we have verified that
it also works AMD.

>
>It would also (in my opinion) make sense to just export the
>"common_mxcsr_mask" (and probably just rename it as
"mxcsr_feature_mask"
>or something - where does that "common" come from? Is it just to imply
>that it's the bits that all CPU's support "in common", or what?

Yes, The "common" word is for the common set of bit-mask between all the
SMP processors, in case they are not same. Renaming the
mxcsr_common_mask to mxcsr_feature_mask is ok.

>
>Right now you export a function that does just a simple mask operation,
>and quite frankly, that just seems to make it less clear what the code
is
>doing. So who not get rid of that "set_fpu_mxcsr()" function, and just
>replace all the "0xffbf" uses with "mxcsr_feature_mask"?
>
>Hmm?
I agree that it will be cleaner to read. The idea of the set_fpu_mxcsr()
was to export access to the static mxcsr_common_mask variable. We can
get rid of the function by making the mask a global variable, or through
a new function exporting the static variable.
>
>		Linus
