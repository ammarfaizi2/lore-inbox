Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261666AbRESGne>; Sat, 19 May 2001 02:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261667AbRESGnY>; Sat, 19 May 2001 02:43:24 -0400
Received: from odin.sinectis.com.ar ([216.244.192.158]:15886 "EHLO
	mail.sinectis.com.ar") by vger.kernel.org with ESMTP
	id <S261666AbRESGnJ>; Sat, 19 May 2001 02:43:09 -0400
Date: Sat, 19 May 2001 03:36:21 -0300
From: John R Lenton <john@grulic.org.ar>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: MSI6321 + PDC20265 + reiserfs + IBM deskstar => kernel BUG
Message-ID: <20010519033621.F562@grulic.org.ar>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9Iq5ULCa7nGtWwZS"
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9Iq5ULCa7nGtWwZS
Content-Type: multipart/mixed; boundary="dgjlcl3Tl+kb3YDk"
Content-Disposition: inline


--dgjlcl3Tl+kb3YDk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Running kernel 2.4.4 w/Jeff Garzik's via-apic patch, using
reiserfs on a IBM Deskstar on the PDC20265 of a MSI-6321, some
weird shtuff starts happening.

    # mount /dev/hde /mnt
    reiserfs: checking transaction log (device 21:00) ...
    hde: timeout waiting for DMA
    ide_dmaproc: chipset supported ide_dma_timeout func only: 14
    hde: irq timeout: status=3D0x80 { Busy }
    hde: DMA disabled
    ide2: reset: success
    reiserfs: replayed 12 transactions in 44 seconds
    Using r5 hash to sort names
    ReiserFS version 3.6.25

cool!

Now the fun starts: if I start creating a lot of files, I'll
never get to the 1000th, getting the BUG! that follows (the
farthest I've got is B/J/W, i.e. file # 933. Doing a dd instead
of just touching the file is worse). The drive never recovers; I
need to power down the box (a hard reset still leaves it making
these grunging noises).

I attach: the dewhatsitized oops, lspci -vvvxx, hdparm -i
/dev/hde, cat /proc/ide/pdc202xx (but before mounting hde), and
anything else I can think of before hitting y.

Holler if you need anything else.

--=20
John Lenton (john@grulic.org.ar) -- Random fortune:
O mangi la minestra, o minimizzi la finestra.
		-- Andrea `Zuse' Balestrero, "Matemastica e Deformatica"

--dgjlcl3Tl+kb3YDk
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="cpuinfo.gz"
Content-Transfer-Encoding: base64

H4sICIcTBjsAA2NwdWluZm8A5VDLTsMwEDzXX7FHuERJE9KWIxwgQkj8QeU6m9RS1l7FTkj7
9axbRPkDDtxmPI+Vh0dvMAQ/rh4hVzO61o972wp7QTdZh42LOCjDE3Sa7HASpVbkWxxWArdX
CE4TCv1AF+1E0DQN3D17ZhxJOu5ViMhsXS+e8lL2/npO+U1eZHVRKaPNESHYc2pZP9Tw9qS6
1s77w5QyzqvjEC/kyro8726a8aRvrOMpuU4YEtzjYpCj9e77Ta7bFgac5QdyS33yj3vQfUhE
YjATQovAASEGAxRGYI1ABsEsW9BsDQRkoDiK0idFgyE/iy2mWFkD0QLdIskQUB1878lykP6i
3O2yYqcU/1q/+Ifrl3+yfpWvs2qj1BeO3/Cc/AIAAA==

--dgjlcl3Tl+kb3YDk
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="dma.gz"
Content-Transfer-Encoding: base64

H4sICLoTBjsAA2RtYQBTMLFSSE4sTk5MSeUCAMai7RIMAAAA

--dgjlcl3Tl+kb3YDk
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="hdparm.gz"
Content-Transfer-Encoding: base64

H4sICAgTBjsAA2hkcGFybQBlkF1vgjAUhu/7K8710oWWAttIaoKg0UTUgFky7xDKJII1fIjO
+N9XatzNbt6e87znK0VGJs7GPhMuQhDKTJR87jN7QRzifU4i8vZKMEz7SJz5JHJWnkU9DLGo
i6RcSh5vSbxdUGaZDIEvj3nxzW8wS+osFmkLS9mG0xBmWdyPqN0pBtPiIjIINtGIknDXwB1B
lPT+LObUYe/MoI7hMAyb+hAXP4KTYVnaPuOJ7++urWi4RRCMuzzfXE+CB11SrmXd+km6F1hz
3UA/qHMYYwiTS9iV7TBIbVH5M5F5rs7u6n/rFRsKGkVtahHHwrAYe/wqGh00D88klDCTqFPm
qyj44vJoqIkY2vV8xW9VcXRNi+De0K6ryu/KC0Lv4akc1yLVHIFqgUp9f+PCqZBkEDqIOQgb
xAIEqvlZVWVVQrRSrSZ0mnSadH+EabXgZXhsQL8q0xPk8QEAAA==

--dgjlcl3Tl+kb3YDk
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="interrupts.gz"
Content-Transfer-Encoding: base64

H4sICLoTBjsAA2ludGVycnVwdHMAfdGxDoIwEAbgvU9xL2DsFVoKK3EgEW1QE1eEJhBjSAAH
396LgmXAdvqH+9L+V4DfSc2Fu4hTZAA8+SQpIx2Hbp67eD1vTJYCjO3D9iTwK0AoFUqvuNvX
rSv7mpBIVidXUFUOVVlbMnph0Gv6sWKA3M0r/8Ps2HACcxOIhAq8oK2tIDC3QJSovMCctgLy
7jlQEQwnJjFW/vJ0D2eHPPu3LbY/pu7DhHYxALYriqVjb44ZcpX/AQAA

--dgjlcl3Tl+kb3YDk
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="iomem.gz"
Content-Transfer-Encoding: base64

H4sICKcTBjsAA2lvbWVtAJ2STWuDQBCG7/6KgV5S6IeumsTcjPQgpSSkEgohB7M72wrqhl0T
zL/vrmYNKc2hFQTxfZ6Z2WFdt38e9RvxHecwg/eTarCCVfzmdH+pjXkXS1Qoj8hMmFt3dw7X
BUNhVMgl5gahFqGTK2TRVafUpqxPX9oGa1WI2hLc+vzcwo7XxV4/vTfhP2M9PcAA6A/OMSQa
eEVZYwlUMOwJE/iaIGEYRPxCsLzJHWYXxC4tlkkK84OCO9fTFW4RDI8FRdADkFnoBQGM4iyF
DOlXLUrxWaCCtKb3Dptafzf46zS+Ih8M+gTrbEqSceTHz+MoaGET70VZCliuFp7vt1uHUVuK
3RqWDYQ7+c+w3PrcLK73pagKhRf6dB6XuGQcGoVYhfi/tAzobKoRGGXY5qaPauShwrpRXT8S
WDmY/F0OrRzq82rZT0QFiZB7IfPGXDOfRm44Nyef5wqzD9gkJ1qKGrcOx36fj5wP6xxu/zeP
3k+EOgMAAA==

--dgjlcl3Tl+kb3YDk
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="ioports.gz"
Content-Transfer-Encoding: base64

H4sICKcTBjsAA2lvcG9ydHMAnZNLa9wwFIX3+hWCbhLaKbLlhya7GacLLwoDHUIgZCHL0sTU
YxnbE5h/33tsx5NQaIdsBPp0zj1XLyGEWAkROH7Hy6MOmBAhgARoKwMQAcQAQ3W0HZEEJAH5
bc+F111JMAVMAbvB0FxhrubCvNUHyzt7oAWNhWIOCAkYgHJWAjgAB+DaE6PuaB64lOZVaQUT
oVMrGiDobVfp+qa3wy0TMiUuU43Sumt9NwjAAtB9hMiUY+brQX8l4JIVhiVDIkP+nWHAzch3
Wc6Nb1zAIhxjNLX8kG/43pqXxtf+UNn+G88b850/7FWYJSrhT5vW17Xnv06t7fgm2+XPLIaf
hs/6E/iT6fQ/41/Dv3bLrrannn8RAeN8WhHLSmlfK2N5QO/kLg6iiN9s9vmHPMTdMg2f/ueO
EPJT9wN1kd//oKw3z3LRI1JvZQgFTBtozKjZdf5Y9fZS+zxXDkWYxHC/E5M7ZAUSaJDXuEkX
Qhwu7gju6JrsQkGqrgkq0GRhxh/3/54m8WVHI1JA8xHJEQWXkvfZZDbYu5neiMz8kWcev0EP
lW+4NGsRb3GtW93b/SN/ys6m9o19pnLvnXZ4EewPSRKHajYEAAA=

--dgjlcl3Tl+kb3YDk
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="lspci.gz"
Content-Transfer-Encoding: base64

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

--dgjlcl3Tl+kb3YDk
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="oops.gz"
Content-Transfer-Encoding: base64

H4sICBMBBjsAA29vcHMAlVRta9swEP6uX3GDDVLSxJLs+CXtMraylcFgha77UoqRJbnTYlvG
ckr37yfZjvPSwrL74jvp7rl7Tndemz+l1rUBOg/mBHQFKozDzgqeFJuxWvE5wPe6VboysDFS
IHAy+wkTIXO2Kdqz4WQN3hNrvEI/eusB1qMYE7wgCSYL3w/m7tzAxNSSq1xJsQ0t/h1aarEp
5GvBGrxCZd7g4B3U7r2osgQv07r1bv+YVpbzktWzg4gXAbcIrWVTyQI+3V0Da6FuVNWaOV/6
Pn2DVPXECiVA17JhlVgCtoKubu6WLpqgz19vOs2xWd43UhnZ5CatWaX41F9EXhDgB/T5y7eP
17ddMME0pkiy5x7KHnAbLjNrc0wTkVDsbO5sucgD6+FsMfpjgqRR9pZEPJJ5fzvasrOzevTu
bFNv77MACeMuSdxdjKoZVHTTaC6NgfWmFqyVAia1srzDczAt4+uaPcr3HZbFPkO37qwrnUQ+
XfRKaBH7UgMOIk5wQONgKMiPBoUySzAW3A5Cz1xY5v2jwI5MrwjeKaGjM/LimESEZfkBDEmi
YPQJR7yhc3Sr7MH09WXxoDC+LTTe+QzfCNAVKwr40TAul3B/ueW2eoD7vNiYXynXZanatFCm
nYaLxEsIfRgds3i1Mxh3htDpb71pKlakshJTkoShR8MkfDhCdwYN7PtYA11pYdPjHHAGsQ/c
9pY7JeJAA6CucIgCIBHE2e4wtoc5EOJu0Z1R1SMMu2Agb3QJ292EWQuyyH06U779W8wYuC9C
He2L3YNepmm/lXbcmzIVJZtGMZfeByurrsgL2PXwk8x1IyFXjWnBZsp0AXsy+l2mdqdWy/+N
dxBuE/uuvCYbYUcO4AiYngBMHfDY6BfChHCft/iZn7+zu3aUYXFChsWQYf8F94SXddFnwOf4
mcYTl+acnB1lYidkYi5TPxyvyW/ZM/b7d5jabP5qu7H+a/hHNfATauAd273RPJRSP7nPPlHb
V6EOM5ETRoJ0I7E/+EeFlHW26yshE5fmDKG/osilvzgHAAA=

--dgjlcl3Tl+kb3YDk
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="pdc202xx.gz"
Content-Transfer-Encoding: base64

H4sICBMTBjsAA3BkYzIwMnh4AIWSTW6DMBCF9z7FXICKRGkW2aVAWhYJSKQHcPEotWJsZDtV
uX1NChI/Mng3T98bzzybwMrJ42gbbvevEH3z2qB9IcHygXeUqKmAwlL7MLCCBwF5e2hj4awY
LsxxAJT0SyAjH2qddvhF6YoK19xAJFR55/K2QO/3kPxa1NJZ0gxqysCgwNL6LZsQqiPptsyV
EO0NOWqu2BzekVS69vpRW5cklneYGGMUtHFgOM0Xcs0rqhtno1KimAUKBZZKMi9CptN0QfrD
6wHiUhllt+pk3Pw/0kB7PlUepV7TAJjNekpPGSRVbRuPeQjMomOa/2AIE2EDXmBCkPh87Jc+
tLc1aMbXSzWuZ0BLPNu0Wx467bMVdgPokl2L5Oqve4Xk7nMOO7X1bs4tCX2rPyYVO8P7AwAA

--dgjlcl3Tl+kb3YDk
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="ver_linux.gz"
Content-Transfer-Encoding: base64

H4sICEYTBjsAA3Zlcl9saW51eABtkU1v2zAMhu/6FQR22Q7RJMdL5t6GFCiGJYWx7F7INhNr
sURNH2n97yen6wo40UnkI5IvX30/QCCDcNA4dAGUR0Dj4gjkYSA6QbIpJDXASAmMGqFXZwRl
gYYOzuiDJsvZhoybSiNB7BHa5D3aCEZbbXKtxz9JezQ5F0BbuKc2TYGKufrzplf2iIEzYFtt
0ws0yVPrVasVFLzk5VmrhXK6hQ9SwH5Xw15F2GUtsgIh70pxJ9fw7ecvKISQoFdfV1n1ydKz
zS0fbIINXJ2CV194eaFGnXBGl3xdccmaLCfqIVzVSskrwQVfs4kvhovs+ZOGGUrZhRuzX2F3
u3nJVwyLQ3CejjMquayYRx3QX/Elf+HiN6vr+nria1v5z98NbHXjlR/fYcGX7H60ymSX8zYn
9PBx6LpP/2Gdv8TNtU5wMuER4yISzXeRfCXYj6a7pUdyUbJ9v7htgcgOsV02aMAAW1Idvjdx
zj2pMNr2cjuiRZ9Fh6HPCeUd+fjk8hLuLWJ/AZdVnRDjAgAA

--dgjlcl3Tl+kb3YDk--

--9Iq5ULCa7nGtWwZS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.5 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7BhRlgPqu395ykGsRAmxgAJ9Qiml1B39zGuVVEph00RkaH1nFUQCdEfcG
sa3sJNm9CSDOi76tw3utgso=
=36Ds
-----END PGP SIGNATURE-----

--9Iq5ULCa7nGtWwZS--
