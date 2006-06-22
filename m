Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1030435AbWFVWxb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030435AbWFVWxb (ORCPT <rfc822;akpm@zip.com.au>);
	Thu, 22 Jun 2006 18:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030436AbWFVWxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 18:53:31 -0400
Received: from smtp1.netcabo.pt ([212.113.174.28]:48086 "EHLO
	exch01smtp10.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S1030435AbWFVWxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 18:53:30 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AUchABW6mkREgQuEUIJGgkw
X-Antivirus-bastov-Mail-From: sergio@sergiomb.no-ip.org via bastov.localdomain
X-Antivirus-bastov: 1.25-st-qms (Clear:RC:0(213.22.222.44):SA:1(8.7/5.0):. Processed in 3.88917 secs Process 21769)
Subject: Re: how I know if a interrupt is ioapic_edge_type or 
	ioapic_level_type? [Was Re: [Fwd: Re: [Linux-usb-users] Fwd: Re:
	2.6.17-rc6-mm2 - USB issues]]
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Reply-To: sergio@sergiomb.no-ip.org
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: kernel@agotnes.com, akpm@osdl.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb-users@lists.sourceforge.net,
        linux-usb-devel@lists.sourceforge.net, stern@rowland.harvard.edu,
        cw@f00f.org, vsu@altlinux.ru
In-Reply-To: <20060622142902.5c8f8e67.rdunlap@xenotime.net>
References: <44953B4B.9040108@agotnes.com> <4497DA3F.80302@agotnes.com>
	 <20060620044003.4287426d.akpm@osdl.org> <4499245C.8040207@agotnes.com>
	 <1150936606.2855.21.camel@localhost.portugal>
	 <20060621174754.159bb1d0.rdunlap@xenotime.net>
	 <1150938288.3221.2.camel@localhost.portugal>
	 <20060621210817.74b6b2bc.rdunlap@xenotime.net>
	 <1150977386.2859.34.camel@localhost.localdomain>
	 <20060622142902.5c8f8e67.rdunlap@xenotime.net>
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-22ndrzz8d8MQ57YFI5Iv"
Date: Thu, 22 Jun 2006 23:46:38 +0100
Message-Id: <1151016398.3022.4.camel@localhost.portugal>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
X-OriginalArrivalTime: 22 Jun 2006 22:53:28.0492 (UTC) FILETIME=[AD4036C0:01C6964E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-22ndrzz8d8MQ57YFI5Iv
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-06-22 at 14:29 -0700, Randy.Dunlap wrote:
> On Thu, 22 Jun 2006 12:56:25 +0100 Sergio Monteiro Basto wrote:
>=20
> > On Wed, 2006-06-21 at 21:08 -0700, Randy.Dunlap wrote:
> > >=20
> > > If you have a specific issue/problem, it would probably be
> > > better just to focus on that.=20
> >=20
> > on linux-2.6.17/drivers/pci/quirks.c=09
> >=20
> >   * we must mask the PCI_INTERRUPT_LINE value versus 0xf to get
> >   * interrupts delivered properly.
> >   */
> >=20
> >  static void quirk_via_irq(struct pci_dev *dev)
> >  {
> >  	u8 irq, new_irq;
> >=20
> > I want here put something like:  if ( dev->irq !=3D XT-PIC) return and =
don't quirk this dev.
> >  	else=20
>=20
> I don't think the interrupt device mode is known by this code (AFAICT
> with a quick look).  The function is only called for certain VIA chipsets=
.
>=20
> Do you want the quirk for any particular hardware device?
> You might be able to look at the function's <dev> parameter
> to decide on using the quirk or not.
>=20
>=20
> > 	new_irq =3D dev->irq & 0xf;
> >  	pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);

yap, in my opinion this function should back to=20

--- orig/drivers/pci/quirks.c	2006-06-21 20:25:41.000000000 +1000
+++ linux-2.6.17-rc6-mm2/drivers/pci/quirks.c	2006-06-21 20:25:08.000000000=
 +1000
@@ -662,13 +662,7 @@
 		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, new_irq);
 	}
 }
-DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_0, qu=
irk_via_irq);
-DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_1, qu=
irk_via_irq);
-DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_2, qu=
irk_via_irq);
-DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_3, qu=
irk_via_irq);
-DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686, quir=
k_via_irq);
-DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_4, qu=
irk_via_irq);
-DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_5, qu=
irk_via_irq);
+DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_ANY_ID, quirk_via_irq);
=20
 /*
  * VIA VT82C598 has its device ID settable and many BIOSes


But do you know or not ? how I know if dev->irq is XT-pic ?=20


--=20
S=E9rgio M. B.

--=-22ndrzz8d8MQ57YFI5Iv
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
SIb3DQEJBTEPFw0wNjA2MjIyMjQ2MjZaMCMGCSqGSIb3DQEJBDEWBBQqPhhHf4Ei/abxA6stKSO3
lvhviDANBgkqhkiG9w0BAQEFAASCAQAtZ7+lcLT+687zF6cv5k42ShP7SRORC+2/FO88+z0rtkjb
HNv6bWkIG87Kgar0GIDEIbLgfaSXj9ZJ3NFZXf4g6mYgBIs92mptvsqJzoPTmCM95FPN1z8/1bXO
132P+1oEZIPXKVDlTOblYIL8BK0Xm786V97LB9fSmbjr1bxrHym+rYHxp2cNIUG6YxED/1VFGNyg
cYsEm7H91bkn02Bf19HcLI1POHD0beQfepsDt6DWUovUhHdKnP+K6M3Sg0t1t46STuly4KNypBEu
nJaAftgvQpBa5oy2ns5lQMRnBPg7072SsF2bZaQn+cHqtvlSUzSzEhZ+M6dD3tw72mpjAAAAAAAA



--=-22ndrzz8d8MQ57YFI5Iv--
