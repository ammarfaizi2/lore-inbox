Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758336AbWK2BDH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758336AbWK2BDH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 20:03:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758341AbWK2BDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 20:03:07 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:61326 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1758336AbWK2BDG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 20:03:06 -0500
Subject: Re: 2.6.18 tsc clocksource + ntp = excessive drift; acpi_pm does
	fine.
From: john stultz <johnstul@us.ibm.com>
To: Alexandre Pereira Nunes <alexandre.nunes@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <456CCA54.6090504@gmail.com>
References: <456CCA54.6090504@gmail.com>
Content-Type: text/plain
Date: Tue, 28 Nov 2006 17:03:01 -0800
Message-Id: <1164762181.5521.49.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-11-28 at 21:46 -0200, Alexandre Pereira Nunes wrote:
> Hi,
> 
> with default boot I got tsc clocksource selected on an debian's
> 2.6.18-3-k7 SMP build (but UP machine). ntp keeps bothering me with this
> message:
> frequency error 512 PPM exceeds tolerance 500 PPM

Hmmm. Could you send me your dmesg? Also what frequency is your cpu?

Also does booting w/ "noapic" change the behavior?

> If I remove ntp's drift file and restart, it goes fine for a while and
> then it goes with that behaviour again.
> If I remove ntp's drift file, then do a: echo acpi_pm
>  >/sys/devices/system/clocksource/clocksource0/available_clocksource ;

I think you mean "current_clocksource" there...

> and then restart ntp, it goes fine "forever".
> 
> Any toughs, something I should look at?
> 
> I'll be glad to give more feedback.
> 
> I don't know if that happened with 2.6.17, but I'm pretty sure that with
> 2.6.16 it was fine.

Yea, its likely the generic timekeeping changes for i386. Previously
(pre-2.6.18) it probably defaulted to the acpi pm timer and was fine.
The new code is a bit more aggressive in trying to use the TSC.

As a short term workaround, you can put "clocksource=acpi_pm" on your
grub line and that will force the clocksource at boot.

thanks
-john

