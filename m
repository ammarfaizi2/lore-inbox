Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130761AbRALOgq>; Fri, 12 Jan 2001 09:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131153AbRALOgh>; Fri, 12 Jan 2001 09:36:37 -0500
Received: from passion.cambridge.redhat.com ([172.16.18.67]:50305 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S130761AbRALOgW>; Fri, 12 Jan 2001 09:36:22 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20010111225319.G3269@unternet.org> 
In-Reply-To: <20010111225319.G3269@unternet.org>  <20010110223015.B18085@unternet.org> <3A5D9D87.8A868F6A@uow.edu.au> <20010111220943.F3269@unternet.org> <3A5E29D4.1AA38368@mandrakesoft.com> 
To: Frank de Lange <frank@unternet.org>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, Andrew Morton <andrewm@uow.edu.au>,
        linux-kernel@vger.kernel.org
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardware related? 
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Date: Fri, 12 Jan 2001 14:35:31 +0000
Message-ID: <7476.979310131@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


frank@unternet.org said:
>  No, I'm judging based on the fact that I found reports from people
> using NE2K-PCI with several cards as well as tulip-based cards
> (different driver) on abit BP6 as well as Gigabyte motherboards,
> mostly on 2.3.x/2.4.x kernels. I found some postings with these
> problems on 2.2.x kernels. 

IRQ 19 on my BP6 stopped arriving a few days ago. 

 19:      90373      90473   IO-APIC-level  usb-uhci

Removing and reloading the usb-uhci driver didn't help. Loading the uhci 
driver just oopsed, which seems to be its normal behaviour on the occasions 
on which I try it.

Rebooting fixed it. I was half tempted to code a 'kick APIC because I think 
it broke' function, but then decided not to bother.

It might be nice in 2.5 to give drivers some way of kicking the APIC when 
they think they've missed an interrupt, much like the network code kicks 
the driver. And to deal more gracefully with IRQ storms.

Once a driver has a way of saying "Oi! Why isn't IRQ x working?" it would 
be feasible to just disable the damn thing if we receive a million of them 
in rapid succession.

--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
