Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263370AbRFKDY4>; Sun, 10 Jun 2001 23:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263375AbRFKDYr>; Sun, 10 Jun 2001 23:24:47 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:30686 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S263372AbRFKDYe>;
	Sun, 10 Jun 2001 23:24:34 -0400
Message-ID: <3B2439E5.493B0472@mandrakesoft.com>
Date: Sun, 10 Jun 2001 23:24:21 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Aron Lentsch <lentsch@nal.go.jp>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IRQ problems on new Toshiba Libretto
In-Reply-To: <Pine.LNX.4.21.0106111107270.1065-100000@triton.nal.go.jp>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aron,

Can you also include your kernel .config?

Looking at your dmesg output, there is no mention of a PCI BIOS at all. 
That either implies there is no kernel support for PCI BIOS built in
(ok) or your BIOS doesn't support PCI BIOS (ug).

Further, there is no PCI interrupt routing table found by direct scan of
memory, so it looks like your BIOS is not providing interrupt routing
info at all.  Without that, we can only route irqs on "a wing and a
prayer"


Suggestions:
* Build kernel with CONFIG_PCI_GOANY config option.
* Do not build an SMP kernel (CONFIG_SMP) unless you are really using a
multiprocessor machine.
* Go through BIOS setup.  Check for and enable "PNP OS" setting, and
similar settings which reflect an automatically assignment of machine
resources.

It is also possible that this machine's interrupt routing info is in
ACPI tables..  though I do not believe the Linux ACPI can make use of
this yet.


-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |
