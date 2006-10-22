Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbWJVVVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbWJVVVk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 17:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750723AbWJVVVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 17:21:40 -0400
Received: from www.osadl.org ([213.239.205.134]:7126 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1750703AbWJVVVj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 17:21:39 -0400
Subject: Re: various laptop nagles - any suggestions?   (note:
	2.6.19-rc2-mm1 but applies to multiple kernels)
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, teunis <teunis@wintersgift.com>,
       linux-kernel@vger.kernel.org, Dmitry Torokhov <dtor@mail.ru>,
       john stultz <johnstul@us.ibm.com>, Len Brown <lenb@kernel.org>
In-Reply-To: <1161424147.5274.400.camel@localhost.localdomain>
References: <4537A25D.6070205@wintersgift.com>
	 <20061019194157.1ed094b9.akpm@osdl.org> <4538F9AD.8000806@wintersgift.com>
	 <20061020110746.0db17489.akpm@osdl.org>
	 <1161368034.5274.278.camel@localhost.localdomain>
	 <20061020112627.04a4035a.akpm@osdl.org>
	 <1161370015.5274.282.camel@localhost.localdomain>
	 <20061020121537.dea13469.akpm@osdl.org> <20061020203731.GA22407@elte.hu>
	 <20061020135450.6794a2bb.akpm@osdl.org> <20061020205651.GA26801@elte.hu>
	 <20061020182527.a07666a4.akpm@osdl.org>
	 <1161424147.5274.400.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sun, 22 Oct 2006 23:22:39 +0200
Message-Id: <1161552160.22373.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-10-21 at 11:49 +0200, Thomas Gleixner wrote:
> [   11.515305] calibrating APIC timer ...
> [   11.618612] ..... tt1-tt2 831283
> [   11.618614] ..... mult: 35701101
> [   11.618616] ..... calibration result: 532021
> [   11.618619] ..... CPU clock speed is 1995.0325 MHz.
> [   11.618622] ..... host bus clock speed is 133.0021 MHz.
> 
> That looks reasonable. It really boils down to the lapic not working
> when going idle.

This LAPIC business is weird. I found two boxen, where the LAPIC timer
calibration is wrong by factor 1.8 and 2.3 on every third/fifth boot.
Unsurprisingly one is a VAIO with a CoreDuo inside, which claims to have
a 4.6GHz CPU and 390MHz bus speed occasionally. This problem seems to be
independent of the "lapic stops on C2" one. 

I have a patch ready, which should detect both problems, but having
acpi_processor as a module is painful, as we might enable the C2 states
way after we decided to use the LAPIC timer and switched over to
highres/dyntick mode. I need to find a way to back out from
highres/dyntick mode gracefully in that case except we can agree to make
the acpi_processor bits built-in only or at least make the Kconfig
tristate depending on experimental. Len ?

	tglx


