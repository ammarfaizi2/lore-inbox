Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264751AbTFAWzH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 18:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264756AbTFAWzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 18:55:07 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:51644 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S264751AbTFAWzA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 18:55:00 -0400
Date: Mon, 2 Jun 2003 01:08:20 +0200 (MEST)
Message-Id: <200306012308.h51N8K6j001404@harpo.it.uu.se>
From: mikpe@csd.uu.se
To: brian@interlinx.bc.ca
Subject: Re: [PATCH][2.5] Honour dont_enable_local_apic flag
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       zwane@linuxpower.ca
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01 Jun 2003 12:26:56 -0400, Brian J. Murrell wrote:
>>    So what vendor/model CPU is used in the failure case?
>
>VMware 2.0.4.

Details, please. What does `cat /proc/cpuinfo` say?

My intention here is that we should be able to detect
this apparently broken "CPU" by its vendor/model and
clear cpu_has_apic for it.

Alternatively the no_apic label in detect_init_APIC()
could clear cpu_has_apic.

>> 3. What is the exact failure? Hang or crash?
>
>Normal boot until here:
>
>Using local APIC timer interrupts.
>calibrating APIC timer ...
>..... CPU clock speed is 1658.7651 MHz.
>..... host bus clock speed is 0.0000 MHz.
>cpu: 0, clocks: 0, slice: 0

Hmm, obviously a 2.4 kernel.
Looks like a hang in setup_APIC_timer(). My guess is that
the do loops in that procedure don't work if clocks==0
or the local APIC timer registers are frozen.

/Mikael
