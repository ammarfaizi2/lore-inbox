Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263893AbUANWVw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 17:21:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264126AbUANWVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 17:21:52 -0500
Received: from modemcable178.89-70-69.mc.videotron.ca ([69.70.89.178]:53120
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S263893AbUANWVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 17:21:51 -0500
Date: Wed, 14 Jan 2004 17:20:51 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: "Nakajima, Jun" <jun.nakajima@intel.com>
cc: James Cleverdon <jamesclv@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Chris McDermott <lcm@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: RE: [PATCH] 2.6.1-mm2: Get irq_vector size right for generic subarch
 UP installer kernels
In-Reply-To: <7F740D512C7C1046AB53446D3720017361883B@scsmsx402.sc.intel.com>
Message-ID: <Pine.LNX.4.58.0401141711260.9824@montezuma.fsmlabs.com>
References: <7F740D512C7C1046AB53446D3720017361883B@scsmsx402.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jan 2004, Nakajima, Jun wrote:

> assign_irq_vector() is okay, and it simply returns vectors
> (FIRST_DEVICE_VECTOR <= vector < FIRST_SYSTEM_VECTOR). That means those
> IRQs will eventually share the same vector(s). Look at the code.

Ok so you have different irqs sharing vectors, how does this work with the
following (where $vector really means $irq of course)?

.data
ENTRY(interrupt)
.text

vector=0
ENTRY(irq_entries_start)
.rept NR_IRQS
        ALIGN
1:      pushl $vector-256
        jmp common_interrupt

Also i was thinking about when you exhaust all 200 odd
spare vectors and then end up doing set_intr_gate twice on the same
vector? I may be missing something really obvious here.

Thanks

