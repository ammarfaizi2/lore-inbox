Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131398AbQK0Ome>; Mon, 27 Nov 2000 09:42:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131329AbQK0OmY>; Mon, 27 Nov 2000 09:42:24 -0500
Received: from p3EE3C9DF.dip.t-dialin.net ([62.227.201.223]:4100 "HELO
        emma1.emma.line.org") by vger.kernel.org with SMTP
        id <S131655AbQK0OmH>; Mon, 27 Nov 2000 09:42:07 -0500
Date: Mon, 27 Nov 2000 09:10:05 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Cc: Kurt Garloff <garloff@suse.de>
Subject: Re: [2.2.17] yes: oops again in /proc/scsi/scsi
Message-ID: <20001127091005.A2973@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
        Kurt Garloff <garloff@suse.de>
In-Reply-To: <20001122020618.A1411@emma1.emma.line.org> <20001123010712.C32555@garloff.etpnet.phys.tue.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
        protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001123010712.C32555@garloff.etpnet.phys.tue.nl>; from garloff@suse.de on Don, Nov 23, 2000 at 01:07:12 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, 23 Nov 2000, Kurt Garloff wrote:

> While 2.0e3 contains a bug that can cause an OOps inside the driver (just
> use the echo "INQUIRY 0" >/proc/scsi/tmscsim/?), the normal bus rescanning
> should not be able to trigger it. The above looks like the bug is occuring
> somewhere else.
> Having said this, I'd like to ask you to try 2.0e6 of the tmscsim driver and
> check whether you are able to reproduce the bug.

My previous mail was a tad too early. After I moved the bus back to the
Tekram DC-390U (sym53c8xx driver), I caught an oops again, and
rescan-scsi-bus.sh caught a SIGSEGV. There seems to be a kernel bug somewhere
in that SCSI handling stuff:

Before the oops:
----------------
scsi singledevice 0 0 0 0
scsi singledevice 0 0 1 0
scsi singledevice 0 0 2 0
  Vendor: PLEXTOR   Model: CD-ROM PX-32TS    Rev: 1.02
  Type:   CD-ROM                             ANSI SCSI revision: 02
Detected scsi CD-ROM sr3 at scsi0, channel 0, id 2, lun 0
scsi singledevice 0 0 3 0
  Vendor: YAMAHA    Model: CRW4416S          Rev: 1.0j
  Type:   CD-ROM                             ANSI SCSI revision: 02
Detected scsi CD-ROM sr4 at scsi0, channel 0, id 3, lun 0
sr4: scsi3-mmc drive: 16x/16x writer cd/rw xa/form2 cdda tray
scsi singledevice 0 0 4 0
sym53c875-0-<4,*>: FAST-5 SCSI 5.0 MB/s (200 ns, offset 8)
  Vendor: HP        Model: HP35480A          Rev: 1209
  Type:   Sequential-Access                  ANSI SCSI revision: 02
Detected scsi tape st2 at scsi0, channel 0, id 4, lun 0
scsi singledevice 0 0 5 0
  Vendor: PLEXTOR   Model: CD-ROM PX-20TS    Rev: 1.00
  Type:   CD-ROM                             ANSI SCSI revision: 02
Detected scsi CD-ROM sr5 at scsi0, channel 0, id 5, lun 0
scsi singledevice 0 0 6 0
sym53c875-0-<6,*>: FAST-5 SCSI 4.0 MB/s (250 ns, offset 8)
  Vendor: TANDBERG  Model:  TDC 4222         Rev: =07:
  Type:   Sequential-Access                  ANSI SCSI revision: 02
Detected scsi tape st3 at scsi0, channel 0, id 6, lun 0
scsi singledevice 0 0 7 0
scsi singledevice 1 0 0 0
scsi singledevice 1 0 1 0
scsi singledevice 1 0 2 0
scsi singledevice 1 0 2 0
scsi singledevice 1 0 3 0
scsi singledevice 1 0 3 0
scsi singledevice 1 0 4 0
scsi singledevice 1 0 4 0
scsi singledevice 1 0 5 0
scsi singledevice 1 0 5 0
scsi singledevice 1 0 6 0
scsi singledevice 1 0 6 0
scsi singledevice 1 0 7 0
scsi singledevice 2 0 0 0
scsi singledevice 2 0 1 0
scsi singledevice 2 0 2 0
scsi singledevice 2 0 3 0
scsi singledevice 2 0 4 0
scsi singledevice 2 0 5 0
scsi singledevice 2 0 6 0
scsi singledevice 2 0 7 0
scsi singledevice 0 0 0 0
scsi singledevice 0 0 1 0
scsi singledevice 0 0 2 0
  Vendor: PLEXTOR   Model: CD-ROM PX-32TS    Rev: 1.02
  Type:   CD-ROM                             ANSI SCSI revision: 02
Detected scsi CD-ROM sr2 at scsi0, channel 0, id 2, lun 0

Oops ran through ksymoops:
--------------------------
Unable to handle kernel NULL pointer dereference at virtual address 00000052
current->tss.cr3 = 07106000, %%cr3 = 07106000
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[sr_finish+112/388]
EFLAGS: 00010206
eax: 00000000   ebx: 00000054   ecx: 00000005   edx: c7f9cc00
esi: c629bd50   edi: c7f9cc40   ebp: 00000001   esp: c629bd3c
ds: 0018   es: 0018   ss: 0018
Process rescan-scsi-bus (pid: 2846, process nr: 23, stackpage=c629b000)
Stack: 00000000 c7f88340 c02a9960 c629bd4c 00307273 c01fedaf c7f88700 c7555de0
       c629becc c01fedf3 00000000 00000000 c7f88340 00000000 c6e132c0 c02cb0e0
       c6e132c8 c0132793 c6e132c0 c629bda4 c629bda4 c0001a00 00020000 c63532c0
Call Trace: [scan_scsis+491/1076] [scan_scsis+559/1076] [get_new_inode+147/312] [iget4+121/132] [vsprintf+720/764] [wake_up_process+64/76] [__wake_up+59/68]
Code: 80 48 52 20 a1 8c 99 2a c0 80 4c 18 16 08 a1 8c 99 2a c0 80
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   80 48 52 20               orb    $0x20,0x52(%eax)
Code;  00000004 Before first symbol
   4:   a1 8c 99 2a c0            mov    0xc02a998c,%eax
Code;  00000009 Before first symbol
   9:   80 4c 18 16 08            orb    $0x8,0x16(%eax,%ebx,1)
Code;  0000000e Before first symbol
   e:   a1 8c 99 2a c0            mov    0xc02a998c,%eax
Code;  00000013 Before first symbol
  13:   80 00 00                  addb   $0x0,(%eax)

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: Weitere Infos: siehe http://www.gnupg.org

iQCVAwUBOiIW3SdEoB0mv1ypAQH4AQQAuAcKEY3nY4JxDtAoT4LZ2TyP3J6m3Gan
eIdIaYeBvzx6alhRDK5HNldE4213YwqFABA0eygNA1hJeSib3vvhIcJChDWMl49s
+25wdZSiZyo9xzgSaaiUrwg/UUZzwXvLLXGMGEwY2JKsZS6CbHYDYy210F0JCOCS
W5OM8PO7FIU=
=cx5/
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
