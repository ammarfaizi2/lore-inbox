Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129406AbRAIRUw>; Tue, 9 Jan 2001 12:20:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129431AbRAIRUm>; Tue, 9 Jan 2001 12:20:42 -0500
Received: from h201.s254.netsol.com ([216.168.254.201]:30080 "EHLO
	tesla.admin.cto.netsol.com") by vger.kernel.org with ESMTP
	id <S129406AbRAIRUb>; Tue, 9 Jan 2001 12:20:31 -0500
Date: Tue, 9 Jan 2001 12:19:54 -0500
From: Pete Toscano <pete@research.netsol.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, Johannes Erdfelt <johannes@erdfelt.com>,
        Greg KH <greg@kroah.com>
Subject: Re: Related VIA PCI crazyness?
Message-ID: <20010109121954.B10875@tesla.admin.cto.netsol.com>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org,
	Johannes Erdfelt <johannes@erdfelt.com>, Greg KH <greg@kroah.com>
In-Reply-To: <20010107122800.A636@kantaka.co.uk> <93avg9$rlk$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <93avg9$rlk$1@penguin.transmeta.com>; from torvalds@transmeta.com on Sun, Jan 07, 2001 at 03:52:41PM -0800
X-Uptime: 12:09pm  up 1 day,  2:56,  3 users,  load average: 0.00, 0.04, 0.05
X-Married: 422 days, 16 hours, 24 minutes, and 32 seconds
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On Sun, 07 Jan 2001, Linus Torvalds wrote:

[snip]=20
> If the VIA logic for getting/setting the irq is wrong, it should only be
> a problem if there are devices that _haven't_ been routed by the BIOS.=20
> Usually these devices are limited to things like USB, ACPI and CardBus
> controllers, and getting the irq routing wrong in that case can be
> deadly (infinite irq streams on the wrong irq line).=20

hmmmm, interesting that you should mention usb in this conversation.
there's a problem with usb in smp-enabled kernels running on the via
apollo pro 133a chipset.  basically, unless apic is disabled, the usb
controller (usb-uhci) doesn't get any interrupts and no usb device will
be recognized.  this has existed since the early 2.4.0-test days, if not
earlier.

i was talking with johannes erdfelt about this and he feels that it's a
pci irq routing problem.  as of yet, we haven't been able to find anyone
who can help.  we do see an occasional message on linux-usb about this
problem though.

> Could anybody with a VIA chip who has the energy please do something for
> me:
>  - enable DEBUG in arch/i386/kernel/pci-i386.h
>  - do a "/sbin/lspci -xxvvv" on the interrupt routing chip (it's the
>    "ISA bridge" chip - the VIA numbers are 82c586, 82c596, the PCI
>    numbers for them are 1106:0586 and 1106:0596, I think)
>  - do a cat /proc/pci

from a follow-up post, i get the impression that this won't help with
smp-enabled systems, but if there's something similar that you think
might help solve this one, please let me know and i'll be more than
happy to oblige.

thanks,
pete

--=20
Pete Toscano    p:sigsegv@psinet.com     w:pete@research.netsol.com
GPG fingerprint: D8F5 A087 9A4C 56BB 8F78  B29C 1FF0 1BA7 9008 2736

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6W0g6H/Abp5AIJzYRAq1wAKCMGClrDi6uYUq1E33oOROSYrlmaACdHIYn
VZCtFQwErZNTiuorvs+uiJY=
=fkT/
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
