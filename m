Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270050AbRHQKOr>; Fri, 17 Aug 2001 06:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270067AbRHQKOh>; Fri, 17 Aug 2001 06:14:37 -0400
Received: from t2.redhat.com ([199.183.24.243]:7158 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S270050AbRHQKOW>; Fri, 17 Aug 2001 06:14:22 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <200108162056.WAA18756@harpo.it.uu.se> 
In-Reply-To: <200108162056.WAA18756@harpo.it.uu.se> 
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: georgn@somanetworks.com, linux-kernel@vger.kernel.org
Subject: Re: Dell I8000, 2.4.8-ac5 and APM 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 17 Aug 2001 11:14:32 +0100
Message-ID: <28536.998043272@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



mikpe@csd.uu.se said:
>  Concerning your problem with pulling the AC plug on your Dell I8000,
> my suspicion is that either (a) the BIOS isn't notifying apm.c of the
> event, or (b) apm.c fails to propagate the event to its PM clients. 

The problem with suspend actually turned out to be because the APIC is
unconditionally enabled _before_ the command line is scanned and the 'noapic'
option is detected. The noapic option, however, does have the effect of
preventing the registration of the power management code :)

Booting with 'apic' makes the thing take some time to suspend, and then 
it reboots instead of resuming. That may be your case (b). I put printk in 
the apic suspend and resume functions and neither of them seem to appear.

--
dwmw2


