Return-Path: <linux-kernel-owner+w=401wt.eu-S1030257AbXAHW4e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030257AbXAHW4e (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 17:56:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030436AbXAHW4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 17:56:34 -0500
Received: from outbound-fra.frontbridge.com ([62.209.45.174]:37507 "EHLO
	outbound4-fra-R.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030448AbXAHW4d convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 17:56:33 -0500
X-BigFish: VP
X-Server-Uuid: 89466532-923C-4A88-82C1-66ACAA0041DF
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [PATCH] x86_64 ioapic: check_timer_pin Don't add_pin_to_irq
 if it is already there.
Date: Mon, 8 Jan 2007 14:56:21 -0800
Message-ID: <5986589C150B2F49A46483AC44C7BCA490736E@ssvlexmb2.amd.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] x86_64 ioapic: check_timer_pin Don't
 add_pin_to_irq if it is already there.
Thread-Index: Acczd3ScdL7iLk1GQdCgnoYfcO2EhwAACsQA
From: "Lu, Yinghai" <yinghai.lu@amd.com>
To: ebiederm@xmission.com, "Andrew Morton" <akpm@osdl.org>
cc: "Linus Torvalds" <torvalds@osdl.org>,
       "Tobias Diedrich" <ranma+kernel@tdiedrich.de>,
       "Adrian Bunk" <bunk@stusta.de>, "Andi Kleen" <ak@suse.de>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 08 Jan 2007 22:56:22.0499 (UTC)
 FILETIME=[37959330:01C73378]
X-WSS-ID: 69BC139C1WC4159580-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----Original Message-----
From: ebiederm@xmission.com [mailto:ebiederm@xmission.com] 
Sent: Monday, January 08, 2007 2:50 PM
To: Andrew Morton
Cc: Linus Torvalds; Tobias Diedrich; Adrian Bunk; Andi Kleen; Linux
Kernel Mailing List; Lu, Yinghai
Subject: [PATCH] x86_64 ioapic: check_timer_pin Don't add_pin_to_irq if
it is already there.

>Yep.  My oversight.  Here is the trivial patch to fix it.  I don't
>see how we could hit this case but if we are going to allow for it
>we should handle it correctly.

Yes, in your check_timer calling sequence, at that point irq can not be
0.
( remove_irq_to_pin already remove that entry).

Or in check_timer_pin

+	if ((irq != -1) && (irq != 0)) {

==>

+	if (irq != -1) {

YH



