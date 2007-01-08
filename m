Return-Path: <linux-kernel-owner+w=401wt.eu-S1422689AbXAHRlr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422689AbXAHRlr (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 12:41:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422692AbXAHRlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 12:41:47 -0500
Received: from outbound-cpk.frontbridge.com ([207.46.163.16]:49680 "EHLO
	outbound2-cpk-R.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1422689AbXAHRlq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 12:41:46 -0500
X-BigFish: VP
X-Server-Uuid: 519AC16A-9632-469E-B354-112C592D09E8
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [PATCH 4/4] x86_64 ioapic: Improve the heuristics for when
 check_timer fails.
Date: Mon, 8 Jan 2007 09:41:18 -0800
Message-ID: <5986589C150B2F49A46483AC44C7BCA4907361@ssvlexmb2.amd.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 4/4] x86_64 ioapic: Improve the heuristics for when
 check_timer fails.
Thread-Index: AcczP8NNzpTt9J57QD+KkxpJlyA+XgAC6wIg
From: "Lu, Yinghai" <yinghai.lu@amd.com>
To: ebiederm@xmission.com, "Linus Torvalds" <torvalds@osdl.org>
cc: "Tobias Diedrich" <ranma+kernel@tdiedrich.de>,
       "Andrew Morton" <akpm@osdl.org>, "Adrian Bunk" <bunk@stusta.de>,
       "Andi Kleen" <ak@suse.de>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 08 Jan 2007 17:41:19.0838 (UTC)
 FILETIME=[34B867E0:01C7334C]
X-WSS-ID: 69BC5DB50T04173175-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----Original Message-----
From: ebiederm@xmission.com [mailto:ebiederm@xmission.com] 
Sent: Monday, January 08, 2007 8:11 AM
To: Linus Torvalds
Cc: Tobias Diedrich; Lu, Yinghai; Andrew Morton; Adrian Bunk; Andi
Kleen; Linux Kernel Mailing List
Subject: [PATCH 4/4] x86_64 ioapic: Improve the heuristics for when
check_timer fails.


>+static int check_timer_pin(int apic, int pin)
>+{
>+	int irq, idx;
>+	/* 
>+	 * Test the architecture default i8254 timer pin
>+	 * of apic 0 pin 2.
>+	 */

Comments need to be updated.

>+
>+
>+	/* If the apic pin pair is in use by another irq fail */
>+	irq = irq_from_pin(apic, pin);
>+	if ((irq != -1) && (irq != 0)) {
>+		apic_printk(APIC_VERBOSE,KERN_INFO "...apic %d pin % in
use by irq %d\n",
>+			apic, pin, irq);
>+		return 0; 
>+	}
>+
>+	/* Add an entry in mp_irqs for irq 0 */
>+	idx = update_irq0_entry(apic, pin);
>+
>+	/* Add an entry in irq_to_pin */
>+	add_pin_to_irq(0, apic, pin);
>+
>+	/* Now setup the irq */
>+	setup_IO_APIC_irq(apic, pin, idx, 0);
>+
>+	/* And finally check to see if the irq works */
>+	return do_check_timer_pin(apic, pin);
>+}
>+

Did you miss to call irq_from_pin before add_pin_to_irq? You defined
irq_from_pin in PATCH 2/4.

YH


