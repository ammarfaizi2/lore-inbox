Return-Path: <linux-kernel-owner+w=401wt.eu-S932657AbXAHUlS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932657AbXAHUlS (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 15:41:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932661AbXAHUlS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 15:41:18 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:53382 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932657AbXAHUlR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 15:41:17 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Lu, Yinghai" <yinghai.lu@amd.com>
Cc: "Linus Torvalds" <torvalds@osdl.org>,
       "Tobias Diedrich" <ranma+kernel@tdiedrich.de>,
       "Andrew Morton" <akpm@osdl.org>, "Adrian Bunk" <bunk@stusta.de>,
       "Andi Kleen" <ak@suse.de>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] x86_64 ioapic: Improve the heuristics for when check_timer fails.
References: <5986589C150B2F49A46483AC44C7BCA4907361@ssvlexmb2.amd.com>
Date: Mon, 08 Jan 2007 13:39:58 -0700
In-Reply-To: <5986589C150B2F49A46483AC44C7BCA4907361@ssvlexmb2.amd.com>
	(Yinghai Lu's message of "Mon, 8 Jan 2007 09:41:18 -0800")
Message-ID: <m14pr1i76p.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Lu, Yinghai" <yinghai.lu@amd.com> writes:

>>+static int check_timer_pin(int apic, int pin)
>>+{
>>+	int irq, idx;
>>+	/* 
>>+	 * Test the architecture default i8254 timer pin
>>+	 * of apic 0 pin 2.
>>+	 */
>
> Comments need to be updated.

Probably.   Although this is all I have this doing in my patch.

>>+
>>+
>>+	/* If the apic pin pair is in use by another irq fail */
>>+	irq = irq_from_pin(apic, pin);
             ^^^^^^^^^^^^^^^^^^
>>+	if ((irq != -1) && (irq != 0)) {
>>+		apic_printk(APIC_VERBOSE,KERN_INFO "...apic %d pin % in
> use by irq %d\n",
>>+			apic, pin, irq);
>>+		return 0; 
>>+	}
>>+
>>+	/* Add an entry in mp_irqs for irq 0 */
>>+	idx = update_irq0_entry(apic, pin);
>>+
>>+	/* Add an entry in irq_to_pin */
>>+	add_pin_to_irq(0, apic, pin);
>>+
>>+	/* Now setup the irq */
>>+	setup_IO_APIC_irq(apic, pin, idx, 0);
>>+
>>+	/* And finally check to see if the irq works */
>>+	return do_check_timer_pin(apic, pin);
>>+}
>>+
>
> Did you miss to call irq_from_pin before add_pin_to_irq? You defined
> irq_from_pin in PATCH 2/4.

No see above.

Eric

