Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270294AbRHMQ5H>; Mon, 13 Aug 2001 12:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270299AbRHMQ45>; Mon, 13 Aug 2001 12:56:57 -0400
Received: from postfix1-2.free.fr ([213.228.0.130]:35332 "HELO
	postfix1-2.free.fr") by vger.kernel.org with SMTP
	id <S270294AbRHMQ4w> convert rfc822-to-8bit; Mon, 13 Aug 2001 12:56:52 -0400
Date: Mon, 13 Aug 2001 18:54:26 +0200 (CEST)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: Justin Guyett <justin@soze.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Are we going too fast?
In-Reply-To: <Pine.LNX.4.33.0108130327460.27721-100000@kobayashi.soze.net>
Message-ID: <20010813175724.T666-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 13 Aug 2001, Justin Guyett wrote:

> On Mon, 13 Aug 2001, Gérard Roudier wrote:
>
> > You may want to elaborate on the ncr53c8xx problems (I maintain this
> > driver). More generally, you must not ignore the thousands of bugs in the
> > hardware you are using, but software developpers haven't access to all
> > errata descriptions since hardware vendors donnot like to make this
> > information freely available.
>
> I've got a quick unrelated question.
>
> Why not change the name (or at least the description) of sym53c8xx to
> include the 53c1010 chips, which this driver seems to work on (and on a
> SMP box, no less)?

I have an SMP box and a C1010 chip. I like the 'way' this hardware
combination 'seems' to work for me. :-)

About the driver name, I have changed it to just 'sym' for the port to
FreeBSD. Software modules are usually named using a short name under this
O/S. At the time I did the port, LSI had bought SYMBIOS, but they seemed
to want to keep with SYMBIOS name for the 53C8XX PCI-SCSI family.

Then they (LSI) invented the 53C1010, called it LSI53C1010 and designed it
in a way that made possible to use a single driver for the SYM53C8xx
series (NCR+SYMBIOS) and this one.

The current LSI53C10xx family consists in 2 different architectures that
require 2 different software drivers:

- [PCI host interface + SCSI Ultra-160 interface + SCSI scripts
  processor] that are supported by the sym53c8xx driver, the
  derivated 'sym' under FreeBSD and the latest SYM-2 (derived from sym)
  that wants to be portable.

- [PCI/X host interface + SCSI Ultra-320 interface + ARM based IO
  processor] that requires a new driver. I heared that LSILOGIC want to
  provide a driver for Linux. Note that the LSI FC controllers and those
  ones should possibly share the same software drivers.

Then, what better name for the sym53c8xx driver?

- sym has been obsoleted by lsi.
- sym53c8,10xx is confusing, given the 10xx family weirdness (see above).
- lsi is too vague a name, given the numerous chips supplied by LSI.
- siop (SCSI IO PROCESSOR) is already used and looks to me more vague
  than all other names that have ever been used for an HBA driver.:)

In my taste, sym53c8xx is still quite good name for the following reasons:

1) It is the SYMBIOS company that made the greatest development for the
   53C8XX family, in my opinion.
2) The 53C10xx chips that can be driven by the sym* drivers use a 53C1010
   core, even if then may be named 53C1000, etc..., for marketing reasons.
3) All future 53C10xx HBAs will probably be based on PCI/X + U320 + ARM
   and so will not be supported by sym* (same for SIOP, btw).

Now, we could change everything that wants to describe this driver.
Here is my current one (from sym-2 that also supports NCR53C8xx chips):

 * Device driver for the SYMBIOS/LSILOGIC 53C8XX and 53C1010 family
 * of PCI-SCSI IO processors.

Just my 0.02 euro. :)

  Gérard.

