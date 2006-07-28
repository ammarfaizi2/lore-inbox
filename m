Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751783AbWG1BzR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751783AbWG1BzR (ORCPT <rfc822;akpm@zip.com.au>);
	Thu, 27 Jul 2006 21:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751790AbWG1BzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 21:55:17 -0400
Received: from smtp3.netcabo.pt ([212.113.174.30]:52968 "EHLO
	exch01smtp12.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S1751783AbWG1BzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 21:55:14 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AcwMAC4LyUSBT4dPgTQBgRc
X-Antivirus-bastov-Mail-From: sergio@sergiomb.no-ip.org via bastov.localdomain
X-Antivirus-bastov: 1.25-st-qms (Clear:RC:0(213.22.17.217):SA:1(10.3/5.0):. Processed in 2.422004 secs Process 29511)
Subject: [PATCH] VIA IRQ quirk fixup only in XT_PIC mode take 1 was [PATCH]
	Add SATA device to VIA IRQ quirk fixup list
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Reply-To: sergio@sergiomb.no-ip.org
To: linux-kernel@vger.kernel.org
Cc: Daniel Drake <dsd@gentoo.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Andrew Morton <akpm@osdl.org>, Chris Wedgwood <cw@f00f.org>,
        greg@kroah.com, jeff@garzik.org, harmon@ksu.edu
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-vfBYCDLWG1Hgp0w110xm"
Date: Fri, 28 Jul 2006 02:55:01 +0100
Message-Id: <1154051701.7668.23.camel@localhost.portugal>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
X-OriginalArrivalTime: 28 Jul 2006 01:55:12.0177 (UTC) FILETIME=[DCCFC210:01C6B1E8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-vfBYCDLWG1Hgp0w110xm
Content-Type: multipart/mixed; boundary="=-ZifgCtnyiH5FfQCRIN8t"


--=-ZifgCtnyiH5FfQCRIN8t
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi ,=20
Ok here is my first try against 2.6.17, I like the solution , but I have
time to test it, because I have to build the kernel again, I test if
compiles.=20
Just though that I should send this patch soon as possible.
Any feed-back is welcome !
Thanks,=20
=20

Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Scott J. Harmon" <harmon@ksu.edu>
Cc: Andrew Morton <akpm@osdl.org>
Cc: Chris Wedgwood <cw@f00f.org>
Cc: Greg KH <greg@kroah.com>
Signed-off-by: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
---

 quirks.c |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

--- linux-2.6.17.orig/drivers/pci/quirks.c	2006-06-18 02:49:35.000000000 +0=
100
+++ linux-2.6.17/drivers/pci/quirks.c	2006-07-28 02:20:00.000000000 +0100
@@ -642,22 +653,18 @@ static void quirk_via_irq(struct pci_dev
 {
 	u8 irq, new_irq;
=20
-	new_irq =3D dev->irq & 0xf;
-	pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
-	if (new_irq !=3D irq) {
-		printk(KERN_INFO "PCI: VIA IRQ fixup for %s, from %d to %d\n",
-			pci_name(dev), irq, new_irq);
-		udelay(15);	/* unknown if delay really needed */
-		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, new_irq);
-	}
-}
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
+	if (!smp_found_config && !cpu_has_apic) {
+		new_irq =3D dev->irq & 0xf;
+		pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
+		if (new_irq !=3D irq) {
+			printk(KERN_INFO "PCI: VIA IRQ fixup for %s, from %d to %d\n",
+				pci_name(dev), irq, new_irq);
+			udelay(15);	/* unknown if delay really needed */
+			pci_write_config_byte(dev, PCI_INTERRUPT_LINE, new_irq);
+		}
+	}
+}
+DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_ANY_ID, quirk_via_irq);
=20
 /*
  * VIA VT82C598 has its device ID settable and many BIOSes



--=-ZifgCtnyiH5FfQCRIN8t
Content-Disposition: attachment; filename=VIAIRQfixup_onlyonXT_PIC.patch
Content-Transfer-Encoding: base64
Content-Type: text/x-patch; name=VIAIRQfixup_onlyonXT_PIC.patch; charset=ISO-8859-15

LS0tIGxpbnV4LTIuNi4xNy5vcmlnL2RyaXZlcnMvcGNpL3F1aXJrcy5jCTIwMDYtMDYtMTggMDI6
NDk6MzUuMDAwMDAwMDAwICswMTAwDQorKysgbGludXgtMi42LjE3L2RyaXZlcnMvcGNpL3F1aXJr
cy5jCTIwMDYtMDctMjggMDI6MjA6MDAuMDAwMDAwMDAwICswMTAwDQpAQCAtNjQyLDIyICs2NTMs
MTggQEAgc3RhdGljIHZvaWQgcXVpcmtfdmlhX2lycShzdHJ1Y3QgcGNpX2Rldg0KIHsNCiAJdTgg
aXJxLCBuZXdfaXJxOw0KIA0KLQluZXdfaXJxID0gZGV2LT5pcnEgJiAweGY7DQotCXBjaV9yZWFk
X2NvbmZpZ19ieXRlKGRldiwgUENJX0lOVEVSUlVQVF9MSU5FLCAmaXJxKTsNCi0JaWYgKG5ld19p
cnEgIT0gaXJxKSB7DQotCQlwcmludGsoS0VSTl9JTkZPICJQQ0k6IFZJQSBJUlEgZml4dXAgZm9y
ICVzLCBmcm9tICVkIHRvICVkXG4iLA0KLQkJCXBjaV9uYW1lKGRldiksIGlycSwgbmV3X2lycSk7
DQotCQl1ZGVsYXkoMTUpOwkvKiB1bmtub3duIGlmIGRlbGF5IHJlYWxseSBuZWVkZWQgKi8NCi0J
CXBjaV93cml0ZV9jb25maWdfYnl0ZShkZXYsIFBDSV9JTlRFUlJVUFRfTElORSwgbmV3X2lycSk7
DQotCX0NCi19DQotREVDTEFSRV9QQ0lfRklYVVBfRU5BQkxFKFBDSV9WRU5ET1JfSURfVklBLCBQ
Q0lfREVWSUNFX0lEX1ZJQV84MkM1ODZfMCwgcXVpcmtfdmlhX2lycSk7DQotREVDTEFSRV9QQ0lf
RklYVVBfRU5BQkxFKFBDSV9WRU5ET1JfSURfVklBLCBQQ0lfREVWSUNFX0lEX1ZJQV84MkM1ODZf
MSwgcXVpcmtfdmlhX2lycSk7DQotREVDTEFSRV9QQ0lfRklYVVBfRU5BQkxFKFBDSV9WRU5ET1Jf
SURfVklBLCBQQ0lfREVWSUNFX0lEX1ZJQV84MkM1ODZfMiwgcXVpcmtfdmlhX2lycSk7DQotREVD
TEFSRV9QQ0lfRklYVVBfRU5BQkxFKFBDSV9WRU5ET1JfSURfVklBLCBQQ0lfREVWSUNFX0lEX1ZJ
QV84MkM1ODZfMywgcXVpcmtfdmlhX2lycSk7DQotREVDTEFSRV9QQ0lfRklYVVBfRU5BQkxFKFBD
SV9WRU5ET1JfSURfVklBLCBQQ0lfREVWSUNFX0lEX1ZJQV84MkM2ODYsIHF1aXJrX3ZpYV9pcnEp
Ow0KLURFQ0xBUkVfUENJX0ZJWFVQX0VOQUJMRShQQ0lfVkVORE9SX0lEX1ZJQSwgUENJX0RFVklD
RV9JRF9WSUFfODJDNjg2XzQsIHF1aXJrX3ZpYV9pcnEpOw0KLURFQ0xBUkVfUENJX0ZJWFVQX0VO
QUJMRShQQ0lfVkVORE9SX0lEX1ZJQSwgUENJX0RFVklDRV9JRF9WSUFfODJDNjg2XzUsIHF1aXJr
X3ZpYV9pcnEpOw0KKwlpZiAoIXNtcF9mb3VuZF9jb25maWcgJiYgIWNwdV9oYXNfYXBpYykgew0K
KwkJbmV3X2lycSA9IGRldi0+aXJxICYgMHhmOw0KKwkJcGNpX3JlYWRfY29uZmlnX2J5dGUoZGV2
LCBQQ0lfSU5URVJSVVBUX0xJTkUsICZpcnEpOw0KKwkJaWYgKG5ld19pcnEgIT0gaXJxKSB7DQor
CQkJcHJpbnRrKEtFUk5fSU5GTyAiUENJOiBWSUEgSVJRIGZpeHVwIGZvciAlcywgZnJvbSAlZCB0
byAlZFxuIiwNCisJCQkJcGNpX25hbWUoZGV2KSwgaXJxLCBuZXdfaXJxKTsNCisJCQl1ZGVsYXko
MTUpOwkvKiB1bmtub3duIGlmIGRlbGF5IHJlYWxseSBuZWVkZWQgKi8NCisJCQlwY2lfd3JpdGVf
Y29uZmlnX2J5dGUoZGV2LCBQQ0lfSU5URVJSVVBUX0xJTkUsIG5ld19pcnEpOw0KKwkJfQ0KKwl9
DQorfQ0KK0RFQ0xBUkVfUENJX0ZJWFVQX0VOQUJMRShQQ0lfVkVORE9SX0lEX1ZJQSwgUENJX0FO
WV9JRCwgcXVpcmtfdmlhX2lycSk7DQogDQogLyoNCiAgKiBWSUEgVlQ4MkM1OTggaGFzIGl0cyBk
ZXZpY2UgSUQgc2V0dGFibGUgYW5kIG1hbnkgQklPU2VzDQo=


--=-ZifgCtnyiH5FfQCRIN8t--

--=-vfBYCDLWG1Hgp0w110xm
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
SIb3DQEJBTEPFw0wNjA3MjgwMTU0NTdaMCMGCSqGSIb3DQEJBDEWBBSHVBd5X7leiHeuzoD6NV5K
pZB69jANBgkqhkiG9w0BAQEFAASCAQAb1HuP8pf/fCMwC2t3mcJMtwY+FES4Dd9H725VNoM8aTum
dhLoglsv6tgB07a2bwmMfDLuzVaeLtiUFJdDKSBhHYDt5lG6ezQznYVmfwrNlWqecQGG5RKQ9hR3
tOAI+PzzELLBdwUELwBvCbgE6vVW3MUmucMilywu2o3eyvJ5vehlwn3Zcci/7SqxvNns+vE52x8B
pY5i86vJOPX+RA/reNCELqJKUiLUA8ubQIP1XW1JdRmOEapAL5Hf36bLjmyEnoryrIxMC3TpLHuj
sP73kyw6YmJ3XbGKhisvDfuiqDUmirbdlKoN5UfslnZ5jcPJEw27NxFztRMCRmv3/Hb/AAAAAAAA



--=-vfBYCDLWG1Hgp0w110xm--
