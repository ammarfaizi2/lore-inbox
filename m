Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750839AbVLORps@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750839AbVLORps (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 12:45:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750838AbVLORps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 12:45:48 -0500
Received: from fmr22.intel.com ([143.183.121.14]:3511 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S1750837AbVLORpr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 12:45:47 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH 1/19] MUTEX: Introduce simple mutex implementation 
Date: Thu, 15 Dec 2005 09:45:10 -0800
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F0535A549@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 1/19] MUTEX: Introduce simple mutex implementation 
Thread-Index: AcYBjfrE6sONAJEUSDeHx2Y5kdXuXQAD+5SA
From: "Luck, Tony" <tony.luck@intel.com>
To: <dhowells@redhat.com>, "Andrew Morton" <akpm@osdl.org>
Cc: "Mark Lord" <lkml@rtr.ca>, <tglx@linutronix.de>,
       <alan@lxorguk.ukuu.org.uk>, <pj@sgi.com>, <mingo@elte.hu>,
       <hch@infradead.org>, <torvalds@osdl.org>, <arjan@infradead.org>,
       <matthew@wil.cx>, <linux-kernel@vger.kernel.org>,
       <linux-arch@vger.kernel.org>
X-OriginalArrivalTime: 15 Dec 2005 17:45:11.0442 (UTC) FILETIME=[4C139F20:01C6019F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

     Okay, spinlocks are null ops when CONFIG_SMP and CONFIG_DEBUG_SPINLOCK
     are both disabled, but you still have to disable interrupts, and that
     slows things down, sometimes quite appreciably. It is, for example,
     something I really want to avoid doing on FRV as it takes a *lot* of
     cycles.

There was a USENIX paper a couple of decades ago that described how
to do a fast s/w disable of interrupts on machines where really disabling
interrupts was expensive.  The rough gist was that the spl[1-7]()
functions would just set a flag in memory to hold the desired interrupt
mask.  If an interrupt actually occurred when it was s/w blocked, the
handler would set a pending flag, and just rfi with interrupts disabled.
Then the splx() code checked to see whether there was a pending interrupt
and dealt with it if there was.

-Tony

 
