Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262684AbVBYMJR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262684AbVBYMJR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 07:09:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262686AbVBYMJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 07:09:17 -0500
Received: from mta2.cl.cam.ac.uk ([128.232.0.14]:22232 "EHLO mta2.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S262684AbVBYMHn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 07:07:43 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: arch/xen is a bad idea
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Date: Fri, 25 Feb 2005 12:07:45 -0000
Message-ID: <A95E2296287EAD4EB592B5DEEFCE0E9D1E3291@liverpoolst.ad.cl.cam.ac.uk>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: arch/xen is a bad idea
Thread-Index: AcUbL1+vuOzkf+06S2uePByX4dLoywAAONTg
From: "Ian Pratt" <m+Ian.Pratt@cl.cam.ac.uk>
To: "Andrew Morton" <akpm@osdl.org>, "Andi Kleen" <ak@suse.de>
Cc: <riel@redhat.com>, <linux-kernel@vger.kernel.org>,
       <Ian.Pratt@cl.cam.ac.uk>, <Steven.Hand@cl.cam.ac.uk>,
       <Christian.Limpach@cl.cam.ac.uk>, <Keir.Fraser@cl.cam.ac.uk>,
       <ian.pratt@cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> The Xen team still believe that it's best to keep arch/xen, 
> arch/xen/i386,
> arch/xen/x86_64, etc.  And I believe that Andi (who is the 
> world expert on
> maintaining an i386 derivative) thinks that this is will be a 
> long-term
> maintenance problem.

I think there's an interim compromise position that everyone might go
for:

Phase 1 is for us to submit a load of patches that squeeze out the low
hanging fruit in unifying xen/i386 and i386. Most of these will be
strict cleanups to i386, and the result will be to almost halve the
number of files that we need to modify.

The next phase is that we re-organise the current arch/xen as follows:

We move the remaining (reduced) contents of arch/xen/i386 to
arch/i386/xen (ditto for x86_64). We then move the xen-specific files
that are shared between all the different xen architectures to
drivers/xen/core. I know this last step is a bit odd, but it's the best
location that Rusty Russel and I could come up with.

At this point, I'd hope that we could get xen into the main-line tree.

The final phase is to see if we can further unify more native and xen
files. This is going to require some significant i386 code refactoring,
and I think its going to be much easier to do if all the code is in the
main-line tree so that people can see the motivation for what's going
on.

What do you think?

Best,
Ian

