Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280960AbRLOAZc>; Fri, 14 Dec 2001 19:25:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280961AbRLOAZN>; Fri, 14 Dec 2001 19:25:13 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:9618 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S280960AbRLOAZG>; Fri, 14 Dec 2001 19:25:06 -0500
Date: Sat, 15 Dec 2001 00:25:03 +0000
From: Tim Waugh <twaugh@redhat.com>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ECP Parallel Port
Message-ID: <20011215002503.A14588@redhat.com>
In-Reply-To: <C01668F6B4E@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="ctZH5Gqgrl5HoVnD"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <C01668F6B4E@vcnet.vc.cvut.cz>; from VANDROVE@vc.cvut.cz on Fri, Dec 14, 2001 at 11:50:32PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ctZH5Gqgrl5HoVnD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 14, 2001 at 11:50:32PM +0100, Petr Vandrovec wrote:

>   one of VMware users just pointed to me that ECP mode is now broken=20
> in kernel. 2.4.10-ac9 reports correctly:

You have run into an unfortunate VMware bug.  Arguably it's not really
their fault; they went by existing behaviour rather than documented
behaviour.

Anyhow, the behaviour you are now seeing is the same as the documented
behaviour: ECP mode is only reported _if_ parport will actually use
hardware ECP for ECP transfers.  Previously, it would report [ECP]
even if it knew perfectly well that it had no intention of using it.

This was fixed in order to provide ECP support in the printer driver.

> It looks like a bug to me. Is it known problem, or should I look into
> it more deeply?

It's no bug in the kernel, really.  It is a known problem though.  The
solution is for VMware to do their own port capabilities detection,
since they don't use the kernel for actually using the parallel port
chip (they just use inb/outb).  [Incidentally, I've told them this via
their feedback email address, but since I don't own a VMware license I
am apparently not entitled to file a bug against VMware.]

The work around is to do one of the following:

a) Don't upgrade your kernel; only use a kernel that VMware have
   verified works with their product;
b) Take appropriate steps to get the kernel to use ECP mode.  This
   involves: turning on 'EXPERIMENTAL' driver support, turning on 'Use
   FIFO/DMA if available', and providing 'irq=3Dauto dma=3Dauto' to the
   parport_pc module when you load it.  You may of course have to
   provide the actual IRQ line number or DMA channel if they can't be
   automatically detected.

Be aware that option (b) is the more dangerous: DMA printing has known
problems, and so does PIO printing (but to a lesser extent).

Tim.
*/

--ctZH5Gqgrl5HoVnD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8GphdyaXy9qA00+cRAkuwAJ9auJ8Sfy040omw6OvEme/UUORuFwCfXOjo
uBtD3hkw23CXsB60SOaDxHA=
=ScMr
-----END PGP SIGNATURE-----

--ctZH5Gqgrl5HoVnD--
