Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272540AbTHMNNH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 09:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272778AbTHMNNH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 09:13:07 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:56995 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S272540AbTHMNNF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 09:13:05 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16186.14686.455795.927909@gargle.gargle.HOWL>
Date: Wed, 13 Aug 2003 15:13:02 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Ruben Puettmann <ruben@puettmann.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22 APM problems with IBM Thinkpad's
In-Reply-To: <20030813123119.GA25111@puettmann.net>
References: <20030813123119.GA25111@puettmann.net>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ruben Puettmann writes:
 > 
 >     hy,
 > 
 > cause many problems with acpi I try to get apm running on my ibm
 > thinkpad R40 ( 2722). But with 2.4.22-pre10 and 2.4.22-pre10-ac1.
 > 
 > Problems which happend:
 > 
 > apm -s don't work with radeonfb usb and so on see my mails on lkm the
 > last days
 > 
 > If CONFIG_APM_DISPLAY_BLANK is Y the thinkpad freezed on blanking the
 > display

This sounds like a well-known APM/local-APIC clash.

Never ever use DISPLAY_BLANK if you also have SMP or UP_APIC.

With APIC support enabled (SMP or UP_APIC), APM must be constrained:
DISPLAY_BLANK off
CPU_IDLE off
built-in driver, not module

This is because the apm driver does BIOS calls, and many BIOSen
(including the code in graphics cards, e.g. all Radeons it seems)
like to hang if a local APIC timer interrupt arrives.
