Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130388AbRCPKyg>; Fri, 16 Mar 2001 05:54:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130438AbRCPKyP>; Fri, 16 Mar 2001 05:54:15 -0500
Received: from lacrosse.corp.redhat.com ([207.175.42.154]:4261 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S130388AbRCPKxy>; Fri, 16 Mar 2001 05:53:54 -0500
Date: Fri, 16 Mar 2001 10:53:10 +0000
From: Tim Waugh <twaugh@redhat.com>
To: Will Newton <will@misconception.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VIA audio and parport in 2.4.2
Message-ID: <20010316105310.G1131@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0103151829040.1581-100000@dogfox.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="1Ow488MNN9B9o/ov"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0103151829040.1581-100000@dogfox.localdomain>; from will@misconception.org.uk on Thu, Mar 15, 2001 at 06:45:37PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1Ow488MNN9B9o/ov
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 15, 2001 at 06:45:37PM +0000, Will Newton wrote:

> I don't know why it prints it twice.

Looks like the module is getting loaded, then unloaded, then loaded
again.  Perhaps because of module autocleaning?

> When printing errors are printed (buffer overrun or something like that,
> it seems RedHat only logs these damn things to console).

Put '*.debug -/var/log/debug' in /etc/syslog.conf and SIGHUP it.

With DMA and PIO debugging messages (especially timeout messages) are
normal and expected.  They are still there because DMA and PIO isn't
really widely tested yet.

If you have a Via chipset that provides a parallel port via the PCI
bus, things like IRQ and DMA get used by default.  I think this is
also a bug, and shouldn't be done unless 'irq=3Dauto dma=3Dauto' is
supplied to the module.

> Also if I try to disbale interrupt driven printing I get an error:
>=20
> [root@dogfox log]# /usr/sbin/tunelp /dev/printers/0 -i 0
> tunelp: ioctl: Invalid argument
> /dev/printers/0 using IRQ 7

Yeah, tunelp doesn't work with 2.4 kernels right now.  It's on my list
of things to fix.  Read Documentation/parport.txt to find out about
how to adjust things like that.

Basically, if you do:

modprobe -r lp parport_pc
modprobe parport_pc irq=3Dnone

then parport won't use interrupts.

> The IRQ, DMA, I/O ports etc. are all the same as they are in Windows, but
> in Linux the sound doesn't work and the printer keeps hanging.

For the 'printer hangs' problem, try the latest pre-patch in the
testing directory and let me know if that fixes it.

> I also get spurios interrupts on 7 when the parport is not loaded.

I'm not sure what you mean here.  Can you be more specific?

Tim.
*/

--1Ow488MNN9B9o/ov
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6sfCVONXnILZ4yVIRAhTKAJ9rAu8XY9cFTSbuRlcRUBL//78zRgCfYRjr
QbYrR4KRV1u38T6IkxazSFc=
=k/if
-----END PGP SIGNATURE-----

--1Ow488MNN9B9o/ov--
