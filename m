Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266019AbRGCVhf>; Tue, 3 Jul 2001 17:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266024AbRGCVhZ>; Tue, 3 Jul 2001 17:37:25 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:54283 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S266019AbRGCVhH>; Tue, 3 Jul 2001 17:37:07 -0400
Subject: Re: ACPI fundamental locking problems
To: andrew.grover@intel.com (Grover, Andrew)
Date: Tue, 3 Jul 2001 22:37:14 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk ('Alan Cox'), jgarzik@mandrakesoft.com,
        linux-kernel@vger.kernel.org, acpi@phobos.fachschaften.tu-muenchen.de
In-Reply-To: <4148FEAAD879D311AC5700A0C969E89006CDDF2F@orsmsx35.jf.intel.com> from "Grover, Andrew" at Jul 03, 2001 02:28:49 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15HXr8-0008Pw-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This goes to the special nature of the Global Lock. If we cannot acquire it,
> we set a bit, and the system interrupts when it is released. Please see
> acpi_ev_acquire_global_lock().

Gotcha..now I follow - I read it as acquire or spin not acquire or fail

> > if you make a callback from the ACPI code - eg power 
> > management that itself
> > needs to call AML code ?
> 
> All we do at interrupt level is signal the semaphore that threads needing
> the GL have blocked on. They continue execution at non-interrupt level.

Obvious question - you call kmalloc with that lock held - that can sleep
as it is GFP_KERNEL so other threads can run and make acpi calls ..
I assume the other threads block on the acpi lock, and the kmalloc eventually
returns.

> > Microsoft very early on in debugging Win2K problems ask 
> > people to use non
> > ACPI settings. 
> 
> What is your source for this? They certainly could have said that, but
> everything I've heard is that MS was so committed to ACPI, they almost left
> APM support out of W2K.

Microsoft helpdesk engineers I know (contrary to assumptions from some quarters
there is a lot of respect between some of the MS and linux folks for each others
work)

> 3) ACPI increases visibility of vendor code. You can disassemble AML. You
> can step through it with our debugger.

Well actually the license on the intel bios says not. Of course the license
is invalid here but nevertheless..

> > Governments. They'd hate the US to get prior warning of say protestors
> > walking into their top secret menwith hill base playing the 
> > mission impossible
> > theme tune then chaining themselves to things..
> 
> You're kidding.........right?

No. There are people more paranoid than I care to consider sane. They have
lots of money. There are also a bunch of greenpeace people who today walked
straight into a US top secret base in the UK singing the mission impossible
theme tune .. which did you doubt ?

[Come to think of it which do you find the more improbable ..]

Alan

