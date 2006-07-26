Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932101AbWGZMwk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbWGZMwk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 08:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751627AbWGZMwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 08:52:39 -0400
Received: from smtp1.netcabo.pt ([212.113.174.28]:7028 "EHLO
	exch01smtp10.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S1751619AbWGZMwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 08:52:38 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AY8CAHIAx0SBT4h5AQE
X-Antivirus-bastov-Mail-From: sergio@sergiomb.no-ip.org via bastov.localdomain
X-Antivirus-bastov: 1.25-st-qms (Clear:RC:1(127.0.0.1):. Processed in 0.177646 secs Process 25191)
Subject: Re: [PATCH] Add SATA device to VIA IRQ quirk fixup list
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Reply-To: sergio@sergiomb.no-ip.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, Chris Wedgwood <cw@f00f.org>,
       greg@kroah.com, dsd@gentoo.org, jeff@garzik.org, harmon@ksu.edu,
       linux-kernel@vger.kernel.org
In-Reply-To: <1153874577.7559.36.camel@localhost>
References: <20060714095233.5678A8B6253@zog.reactivated.net>
	 <44B77B1A.6060502@garzik.org> <44B78294.1070308@gentoo.org>
	 <44B78538.6030909@garzik.org> <20060714074305.1248b98e.akpm@osdl.org>
	 <44BA48A0.2060008@gentoo.org> <20060716183126.GB4483@kroah.com>
	 <20060717003418.GA27166@tuatara.stupidest.org>
	 <20060724214046.1c1b646e.akpm@osdl.org>
	 <1153874577.7559.36.camel@localhost>
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-zhSPtqpGQDv0mrGCwSBk"
Date: Wed, 26 Jul 2006 13:45:53 +0100
Message-Id: <1153917954.29975.22.camel@bastov.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
X-OriginalArrivalTime: 26 Jul 2006 12:52:37.0531 (UTC) FILETIME=[5F3F9EB0:01C6B0B2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-zhSPtqpGQDv0mrGCwSBk
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi, Alan=20

But can we know if dev->irq is XT-PIC ?  or not ?=20
or could we know if IO_APIC or LOCAL_APIC is enabled or
not ?

on linux-2.6.17/drivers/pci/quirks.c   =20

  * we must mask the PCI_INTERRUPT_LINE value versus 0xf to get
  * interrupts delivered properly.
  */

 static void quirk_via_irq(struct pci_dev *dev)
 {
        u8 irq, new_irq;

I want put here something like:  if ( dev->irq !=3D XT-PIC) return and
don't quirk this dev.
        else=20

        new_irq =3D dev->irq & 0xf;
        pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);



On Wed, 2006-07-26 at 01:42 +0100, Alan Cox wrote:
> A few comments
>=20
> "The legacy IDE is using IRQ 14 or 15 not PCI"
>=20
> This is half correct - V-Link is not involved in this case, however the
> legacy IRQs are configurable and steerable via func 0 reg 0x4C for some
> chips. If this has been set by a weirdass bios (bits 3-0 not 0x0100 for
> the 8233C  varies for others) then we've never supported it.
>=20
>=20
> I have full IRQ routing info for some of the VIA chips and it varies by
> chip how this all works.
>=20
> The 8233/8233C routes via register 0x4C/0x4D of function 0 for internal
> devices and via 0x55->0x57 (polarities on 0x54) for PCI interrupts. The
> devices use the IRQ number not line. Also to add fun the 8233C has a
> 3com nic part that does this...
>=20
> There are then a seperate set of register mappings for SCI and for ISA
> IRQ mapping.
>=20
> There is an errata with the internal devices of the 8235 and earlier
> which can be used to detect them fairly well. Only the low four bits of
> 0ffset 0x3C are writable not the full IRQ value.
>=20
>=20
> Some later chips use bits to indicate PIC v APIC routing.
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--=20
S=E9rgio M.B.

--=-zhSPtqpGQDv0mrGCwSBk
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
SIb3DQEJBTEPFw0wNjA3MjYxMjQ1NTJaMCMGCSqGSIb3DQEJBDEWBBRHTitaf7a20kPXTmJcKtq4
MX6UnDANBgkqhkiG9w0BAQEFAASCAQBUWqqK2MWWLgPUkVvzyefNpY7pzb0Go+xxWEQEPRk03lXC
YIrgvKNw+Oi4ZkLn20VIfT9xyO5x36rjhw0UgM4pevQOEiblPSFTvetmiJk0Y5teW2DCsb+mOOpW
nTTycZy5lV0yh3bytdcAD+YP/YmwmL+OoH3ytHaEyrD9paFe2pwLIkngMkocHHy6MbAuDaGOuHv/
LZcIvCnT+2MRtBI/RLP14wlBY6Sd6PBu2KDcKh8MbB9q/XCmD2UsjLzFrzcIH137ACaGyiG7VXPY
iwIhzJ56xDCGxbn6mTG810yupVOf+Ri0Y+MMk0OTOuqnt6oPIGHSUGcYehcOackGFK1zAAAAAAAA



--=-zhSPtqpGQDv0mrGCwSBk--
