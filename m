Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263353AbTDCLao>; Thu, 3 Apr 2003 06:30:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263354AbTDCLao>; Thu, 3 Apr 2003 06:30:44 -0500
Received: from [81.2.110.254] ([81.2.110.254]:9206 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id <S263353AbTDCLan>;
	Thu, 3 Apr 2003 06:30:43 -0500
Subject: Re: ISA vs PCI interrupt handling
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <m3n0j8lc4y.fsf@defiant.pm.waw.pl>
References: <m3n0j8lc4y.fsf@defiant.pm.waw.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049366617.11275.16.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 03 Apr 2003 11:43:37 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-04-03 at 00:20, Krzysztof Halasa wrote:
> Hi,
> 
> A simple question: there are drivers for ISA and PCI devices. The IRQ
> handlers are registered with request_irq(flags = 0) or
> request_irq(SA_SHIRQ) for PCI.
> 
> In both cases, the device raises an IRQ line and the handler is called.
> Does the handler have to make sure the device has lowered the IRQ?
> I mean, in situation where the handler terminates with the IRQ line
> being still active, will the handler be called again, or will the
> driver deadlock? Does is behave differently on ISA and PCI?

For PCI at least you must mask the IRQ on your device in that situation.
It must also be masked on the device not via disable_irq

