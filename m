Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262420AbVADXPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262420AbVADXPs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 18:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262417AbVADXPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 18:15:08 -0500
Received: from grendel.firewall.com ([66.28.58.176]:4236 "EHLO
	grendel.firewall.com") by vger.kernel.org with ESMTP
	id S262162AbVADXHg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 18:07:36 -0500
Date: Wed, 5 Jan 2005 00:07:33 +0100
From: Marek Habersack <grendel@caudium.net>
To: Willy Tarreau <willy@w.ods.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Very high load on P4 machines with 2.4.28
Message-ID: <20050104230733.GE5592@beowulf.thanes.org>
Reply-To: grendel@caudium.net
References: <20050104195636.GA23034@beowulf.thanes.org> <20050104220313.GD7048@alpha.home.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
In-Reply-To: <20050104220313.GD7048@alpha.home.local>
Organization: I just...
X-GPG-Fingerprint: 0F0B 21EE 7145 AA2A 3BF6  6D29 AB7F 74F4 621F E6EA
X-message-flag: Outlook - A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 04, 2005 at 11:03:13PM +0100, Willy Tarreau scribbled:
> Hi,
>=20
> On Tue, Jan 04, 2005 at 08:56:36PM +0100, Marek Habersack wrote:
> (...)=20
> > equipped with 2.6Ghz P4 CPUs, 1Gb of ram, 2-4gb of swap, the kernel con=
fig
> > is attached. The machines have normal load averages hovering not higher=
 than
> > 7.0, depending on the time of the day etc. Two of the machines run 2.4.=
25,
> > one 2.4.27 and they work fine. When booted with 2.4.28, though (compiled
> > with Debian's gcc 2.3.5, with p3 or p4 CPU selected in the config), the=
 load
> > is climbing very fast and hovers around a value 3-4 times higher than w=
ith
> > the older kernels. Booted back in the old kernel, the load comes to its
> > usual level. The logs suggest nothing, no errors, nothing unusual is
> > happening.=20
> >=20
> > Has anyone had similar problems with 2.4.28 in an environment resemblin=
g the
> > above? Could it be a problem with highmem i/o?
> =20
> Never encountered yet ! Could you provide some indications about the type=
 of
> work (I/O, network, CPU, scripts execution, #of processes, etc...) ?
Of course. Here's some information:

the machines (with exception of one) are virtual hosting servers running
apache with a lot of customer-provided perl scripts, php code,=20
mysql (quite heavily used). The bandwidth used ranges from 4Mbit/s=20
(the non-virtual box) to 24Mbit/s. The number of processes ranges from ~300=
 to
~600. Interestingly enough, the machine with the highest load average is the
one generating 4Mbit/s and the one with 24Mbit/s has the smallest load
average value. The latter also suffers from the biggest loadavg increase.=
=20
All of the virtual machines have iptables accounting chains for each
configured IP (there are between 62 IP numbers on one and 32 on the other).
The virtual boxes have two 80GB SATA drives raided with softraid. The
non-virtual box has a single IDE drive, no raid.

Some diagnostics (virtuals running 2.4.25 with ow1, non-virtual 2.4.27 with
ow1):

(virtual #1)
# vmstat
procs -----------memory---------- ---swap-- -----io---- --system------cpu--=
--
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id=
 wa
 0  0 108364  33376   3032 382452    1    1    85   107   79    76 42  7 52=
 0

# iostat
avg-cpu:  %user   %nice    %sys %iowait   %idle
          41.86    0.00    6.63    0.00   51.51

Device:            tps   Blk_read/s   Blk_wrtn/s   Blk_read   Blk_wrtn
dev8-0           44.33        91.04       761.64   32859202  274901552
dev8-1           44.07        88.28       759.27   31863034  274048056

# cat /proc/interrupts=20
           CPU0      =20
  0:   36164314          XT-PIC  timer
  1:          2          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  4:          5          XT-PIC  serial
  8:          4          XT-PIC  rtc
 10:  304927622          XT-PIC  eth0
 12:     786373          XT-PIC  eth1
 14:   31209236          XT-PIC  libata
 15:          1          XT-PIC  ide1
NMI:          0=20
ERR:          0


(virtual #2, the 24Mbit/s one)
# vmstat
procs -----------memory---------- ---swap-- -----io---- --system------cpu--=
--
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id=
 wa
 5  3 172448  13084   1208 304048    4    4    90    50  109   117 19  8 73=
 0

# iostat
avg-cpu:  %user   %nice    %sys %iowait   %idle
          18.76    0.00    7.98    0.00   73.26

Device:            tps   Blk_read/s   Blk_wrtn/s   Blk_read   Blk_wrtn
dev8-0           28.66       465.98       323.12  168199261  116634204
dev8-1           28.26       458.50       314.57  165501660  113547124

# cat /proc/interrupts=20
           CPU0      =20
  0:   36164279          XT-PIC  timer
  1:          2          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  4:          5          XT-PIC  serial
  8:          4          XT-PIC  rtc
 10:  713628758          XT-PIC  eth0
 12:    1452211          XT-PIC  eth1
 14:   20094643          XT-PIC  libata
 15:          1          XT-PIC  ide1
NMI:          0=20
ERR:          0


(the non-virtual)
# vmstat
procs -----------memory---------- ---swap-- -----io---- --system------cpu--=
--
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id=
 wa
60  0  70300 115960      0 369244    0    0    79    32   90    45 73  7 21=
 0

# iostat=20
avg-cpu:  %user   %nice    %sys %iowait   %idle
          72.64    0.03    6.63    0.00   20.71

Device:            tps   Blk_read/s   Blk_wrtn/s   Blk_read   Blk_wrtn
dev3-0            7.62        54.77        91.76   19834569   33227488

# cat /proc/interrupts=20
           CPU0      =20
  0:   36284746          XT-PIC  timer
  1:          2          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  4:          6          XT-PIC  serial
  8:          4          XT-PIC  rtc
 10:     787346          XT-PIC  eth1
 11:  120939540          XT-PIC  eth0
 14:    2743009          XT-PIC  ide0
 15:    1069794          XT-PIC  ide1
NMI:          0=20
ERR:          0


sar doesn't show anything interesting for any of the boxes. We tried to run
2.6.10 on the non-virtual box to see whether it could cope with its load
problems, it crashed after one day with no trace in the logs as to what
might have caused the problem (this box runs some software that's pretty
bursty and CPU-intensive giving sometimes around 50-80 apache processes
running at a time). One other interesting thing to note is that we have one
other box with the similar configuration to the virtuals (also a virtual
host) but it runs 2.4.28 with SMP+HT enabled - no load problems there at
all. In the past we had a problem with P4 machines running very slowly when
the kernel was compiled with the P4 CPU target, but it was on different
hardware (an MSI mobo, the boxes above all have Supermicro mobos) and
compiling the kernel with P3 CPU target helped with the slowness. That's why
we tried the same "trick" here - but this time it didn't help. Let me know =
if you=20
need more info,

thanks for your help, best regards

marek

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB2yG1q3909GIf5uoRAvdAAJ4kLfGyQWTrqLn53QGnzQZsoVGrXwCfVq//
NVehjsN8npXjun7NZOWny8s=
=534O
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
