Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161437AbWG2EIR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161437AbWG2EIR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 00:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161438AbWG2EIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 00:08:17 -0400
Received: from smtp3.netcabo.pt ([212.113.174.30]:33207 "EHLO
	exch01smtp12.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S1161437AbWG2EIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 00:08:17 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aa4HAAZ7ykSBUw
X-Antivirus-bastov-Mail-From: sergio@sergiomb.no-ip.org via bastov.localdomain
X-Antivirus-bastov: 1.25-st-qms (Clear:RC:1(127.0.0.1):. Processed in 0.279345 secs Process 14050)
Subject: Re: Still broken sata (VIA) on Asus A8V (kernel 2.6.14+) with
	irqbalance
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Reply-To: sergio@sergiomb.no-ip.org
To: Heikki Orsila <shd@zakalwe.fi>
Cc: "Vladimir B. Savkin" <master@sectorb.msk.ru>, linux-kernel@vger.kernel.org
In-Reply-To: <20060728200250.GA12840@zakalwe.fi>
References: <20060201162800.GA32196@tentacle.sectorb.msk.ru>
	 <20060728121210.GA8375@tentacle.sectorb.msk.ru>
	 <20060728200250.GA12840@zakalwe.fi>
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-xb+B0WMVNHYG76h78pOP"
Date: Sat, 29 Jul 2006 05:08:09 +0100
Message-Id: <1154146089.10955.109.camel@bastov.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
X-OriginalArrivalTime: 29 Jul 2006 04:08:14.0828 (UTC) FILETIME=[9D4162C0:01C6B2C4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-xb+B0WMVNHYG76h78pOP
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

cat DMESG | grep -i fixup
PCI: VIA IRQ fixup for 0000:00:0f.1, from 255 to 0
PCI: VIA IRQ fixup for 0000:00:10.0, from 11 to 3
PCI: VIA IRQ fixup for 0000:00:10.1, from 11 to 3
PCI: VIA IRQ fixup for 0000:00:10.2, from 10 to 3

with IO-APIC working , you could try patches to not "VIA IRQ quirk
fixup", but could not be the main problem.=20

I have a very experimental patch
http://lkml.org/lkml/2006/7/28/99


Which you can just apply and make bzImage, install and reboot  , don't
need to recompile all over again.


On Fri, 2006-07-28 at 23:02 +0300, Heikki Orsila wrote:
> On Fri, Jul 28, 2006 at 04:12:15PM +0400, Vladimir B. Savkin wrote:
> > Hello!=20
> > Here goes my first report on the issue.
> >=20
> > On Wed, Feb 01, 2006 at 07:28:00PM +0300, Vladimir B. Savkin wrote:
> > > My system based on Asus A8V (VIA chipset) works fine with 2.6.13.3,
> > > but after upgrading (kernels 2.6.14.7 and 2.6.15.1 tried) it
> > > gaves error messages some minutes after boot.
> > >=20
> > > The messages are as following:
> > >   ata2: command 0xXX timeout, stat 0x50 host_stat 0x4
> > > where XX gets different values from time to time, 0x25 mostly.
> > > I/O to this controller halts after that.
> > >=20
> > > Attached are boot dmesg log and lspci output.
> > >=20
> >=20
> > I just checked - the problem persists with 2.6.17.7
>=20
> This is ASUS K8V SE Deluxe on amd64 with SiI 3114 SATA controller. I=20
> upgraded from Ubuntu 6.06 kernel 2.6.15-23 to vanilla 2.6.17.4 and got=20
> following errors shortly after the boot:
>=20
> Jul 26 00:35:39 cheradenine kernel: ata1: translated ATA stat/err 0x51/04=
 to SCSI SK/ASC/ASCQ 0xb/00/00
> Jul 26 00:35:39 cheradenine kernel: ata1: status=3D0x51 { DriveReady Seek=
Complete Error }
> Jul 26 00:35:39 cheradenine kernel: ata1: error=3D0x04 { DriveStatusError=
 }
>=20
> Linux cheradenine 2.6.17.4 #2 SMP Wed Jul 19 16:33:24 EEST 2006 x86_64 GN=
U/Linux
> =20
> Gnu C                  4.0.3
> Gnu make               3.81beta4
> binutils               2.16.91
> util-linux             2.12r
> mount                  2.12r
> module-init-tools      3.2.2
> e2fsprogs              1.38
> jfsutils               1.1.8
> reiserfsprogs          3.6.19
> reiser4progs           1.0.5
> xfsprogs               2.7.7
> PPP                    2.4.4b1
> Linux C Library        2.3.6
> Dynamic linker (ldd)   2.3.6
> Procps                 3.2.6
> Net-tools              1.60
> Console-tools          0.2.3
> Sh-utils               5.93
> udev                   079
> Modules Loaded        =20
>=20
> > libata version 1.20 loaded.
> > sata_via 0000:00:0f.0: version 1.1
> > ACPI: PCI Interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 16
> > sata_via 0000:00:0f.0: routed to hard irq line 10
> > ata1: SATA max UDMA/133 cmd 0xC000 ctl 0xB802 bmdma 0xA800 irq 16
> > ata2: SATA max UDMA/133 cmd 0xB400 ctl 0xB002 bmdma 0xA808 irq 16
> > ata1: SATA link down (SStatus 0)
> > scsi0 : sata_via
>=20
> Mine is "sata_sil 0000:00:0d.0: version 0.9".
>=20
> 0000:00:0d.0 RAID bus controller: Silicon Image, Inc. SiI 3114 [SATALink/=
SATARaid] Serial ATA Controller (rev 02)
>=20
> If these are symptoms of the same bug, it is not sata_via specific.
>=20
> Heikki Orsila
> heikki.orsila@iki.fi
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--=20
S=E9rgio M.B.

--=-xb+B0WMVNHYG76h78pOP
Content-Type: application/x-pkcs7-signature; name=smime.p7s
Content-Disposition: attachment; filename=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIGSTCCAwIw
ggJroAMCAQICAw/vkjANBgkqhkiG9w0BAQQFADBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhh
d3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVt
YWlsIElzc3VpbmcgQ0EwHhcNMDUxMTI4MjIyODU2WhcNMDYxMTI4MjIyODU2WjBLMR8wHQYDVQQD
ExZUaGF3dGUgRnJlZW1haWwgTWVtYmVyMSgwJgYJKoZIhvcNAQkBFhlzZXJnaW9Ac2VyZ2lvbWIu
bm8taXAub3JnMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEApCNuKD3pz8GRKd1q+36r
m0z7z+TBsbTrVa45UQsEeh9OQGZIASJMH5erC0u6KbKJ+km97RLOdsgSlKG6+5xuzsk+aqU7A0Gp
kMjzIJT7UH/bbPnIFMQNnWJxluuYq1u+v8iIbfezQy1+SXyAyBv+OC7LnCOiOar/L9AD9zDy2fPX
EqEDlbO3CJsoaR4Va8sgtoV0NmKnAt7DA0iZ2dmlsw6Qh+4euI+FgZ2WHPBQnfJ7PfSH5GIWl/Nx
eUqnYpDaJafk/l94nX71UifdPXDMxJJlEOGqV9l4omhNlPmsZ/zrGXgLdBv9JuPjJ9mxhgwZsZbz
VBc8emB0i3A7E6D6rwIDAQABo1kwVzAOBgNVHQ8BAf8EBAMCBJAwEQYJYIZIAYb4QgEBBAQDAgUg
MCQGA1UdEQQdMBuBGXNlcmdpb0BzZXJnaW9tYi5uby1pcC5vcmcwDAYDVR0TAQH/BAIwADANBgkq
hkiG9w0BAQQFAAOBgQBIVheRn3oHTU5rgIFHcBRxkIhOYPQHKk/oX4KakCrDCxp33XAqTG3aIG/v
dsUT/OuFm5w0GlrUTrPaKYYxxfQ00+3d8y87aX22sUdj8oXJRYiPgQiE6lqu9no8axH6UXCCbKTi
8383JcxReoXyuP000eUggq3tWr6fE/QmONUARzCCAz8wggKooAMCAQICAQ0wDQYJKoZIhvcNAQEF
BQAwgdExCzAJBgNVBAYTAlpBMRUwEwYDVQQIEwxXZXN0ZXJuIENhcGUxEjAQBgNVBAcTCUNhcGUg
VG93bjEaMBgGA1UEChMRVGhhd3RlIENvbnN1bHRpbmcxKDAmBgNVBAsTH0NlcnRpZmljYXRpb24g
U2VydmljZXMgRGl2aXNpb24xJDAiBgNVBAMTG1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBDQTEr
MCkGCSqGSIb3DQEJARYccGVyc29uYWwtZnJlZW1haWxAdGhhd3RlLmNvbTAeFw0wMzA3MTcwMDAw
MDBaFw0xMzA3MTYyMzU5NTlaMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3Vs
dGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWlu
ZyBDQTCBnzANBgkqhkiG9w0BAQEFAAOBjQAwgYkCgYEAxKY8VXNV+065yplaHmjAdQRwnd/p/6Me
7L3N9VvyGna9fww6YfK/Uc4B1OVQCjDXAmNaLIkVcI7dyfArhVqqP3FWy688Cwfn8R+RNiQqE88r
1fOCdz0Dviv+uxg+B79AgAJk16emu59l0cUqVIUPSAR/p7bRPGEEQB5kGXJgt/sCAwEAAaOBlDCB
kTASBgNVHRMBAf8ECDAGAQH/AgEAMEMGA1UdHwQ8MDowOKA2oDSGMmh0dHA6Ly9jcmwudGhhd3Rl
LmNvbS9UaGF3dGVQZXJzb25hbEZyZWVtYWlsQ0EuY3JsMAsGA1UdDwQEAwIBBjApBgNVHREEIjAg
pB4wHDEaMBgGA1UEAxMRUHJpdmF0ZUxhYmVsMi0xMzgwDQYJKoZIhvcNAQEFBQADgYEASIzRUIPq
Cy7MDaNmrGcPf6+svsIXoUOWlJ1/TCG4+DYfqi2fNi/A9BxQIJNwPP2t4WFiw9k6GX6EsZkbAMUa
C4J0niVQlGLH2ydxVyWN3amcOY6MIE9lX5Xa9/eH1sYITq726jTlEBpbNU1341YheILcIRk13iSx
0x1G/11fZU8xggHvMIIB6wIBATBpMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29u
c3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNz
dWluZyBDQQIDD++SMAkGBSsOAwIaBQCgXTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqG
SIb3DQEJBTEPFw0wNjA3MjkwNDA4MDhaMCMGCSqGSIb3DQEJBDEWBBS729W3JbDDOa46Ip1tXrEI
WKIAkTANBgkqhkiG9w0BAQEFAASCAQBPEROPBYRr3zCR0wnMexnIG1yYZAXrjhJC7LNRAWJMrAis
yK115vRd4YEa98BYBry7dXzzFgTdrzUeKPLPCGT5Yo2F0OTnhpqXRbK8sOW6OsaU3mggnR750ChO
MjA9M5//IJMrQkMJHZvewRorOIEF5r5JhyVckiSEtiWbN8CenUDVuC0kTmX+4s0cuzCUiEojVCQc
ONMNAI/xecbKATqCaLNrqgurOlUiQVUHDCNqVwg4EmIGGnV2hDfDRKJAx8XRT6WDKOHFbPjHwp2e
Lk842QDu2YLz7IOjFTab1kwPhiUYlYZzW1pG4UxTz7YxhVv4cGo9LW3/HwAmYvRHbvpjAAAAAAAA



--=-xb+B0WMVNHYG76h78pOP--
