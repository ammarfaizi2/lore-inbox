Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268982AbTBZW0F>; Wed, 26 Feb 2003 17:26:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268960AbTBZWZC>; Wed, 26 Feb 2003 17:25:02 -0500
Received: from fmr01.intel.com ([192.55.52.18]:47301 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S269002AbTBZWYW>;
	Wed, 26 Feb 2003 17:24:22 -0500
Message-ID: <F760B14C9561B941B89469F59BA3A84725A1AD@orsmsx401.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: Linus Torvalds <torvalds@transmeta.com>, Ion Badulescu <ionut@badula.org>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
       mingo@redhat.com
Subject: RE: [BUG] 2.5.63: ESR killed my box!
Date: Wed, 26 Feb 2003 14:34:23 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Linus Torvalds [mailto:torvalds@transmeta.com] 
> Wouldn't it be nicer to just fix the write instead? I can see the 
> potential to actually want to change the APIC ID - in 
> particular, if the 
> SMP MP tables say that the APIC ID for the BP should be X, 
> maybe we should 
> actually write X to it instead of just using what is there.

OK so we have a redundancy. You can get the same info from MPS and from
the lapic itself.

The fact that ACPI's boot tables does not include the lapic id (just its
address) suggests strongly to me that we should similarly query the
lapic for its address instead of writing in a new value when using the
MPS tables, as well.

> In particular, Mikaels patch will BUG() if the MP tables 
> don't match the 
> APIC ID. I think that's extremely rude: we should select one 
> of the two 
> and just run with it, instead of unconditionally failing.

Agree.

Regards -- Andy
