Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965243AbWIFBVK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965243AbWIFBVK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 21:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965244AbWIFBVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 21:21:10 -0400
Received: from smtp4.netcabo.pt ([212.113.174.31]:18095 "EHLO
	exch01smtp11.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S965243AbWIFBVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 21:21:08 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AT0KAGu+/USBTog5gTM
X-Antivirus-bastov-Mail-From: sergio@sergiomb.no-ip.org via bastov.localdomain
X-Antivirus-bastov: 1.25-st-qms (Clear:RC:0(83.132.128.172):SA:0(-1.2/5.0):. Processed in 5.946334 secs Process 29191)
Subject: [PATCH] take 4 Re: VIA IRQ quirk, another (embarrassing)
	suggestion.
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Reply-To: sergio@sergiomb.no-ip.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@osdl.org>,
       bjorn.helgaas@hp.com, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, greg@kroah.com, harmon@ksu.edu,
       Daniel Drake <dsd@gentoo.org>, Len Brown <len.brown@intel.com>
In-Reply-To: <44FD9431.2050403@garzik.org>
References: <1157330567.3046.24.camel@localhost.portugal>
	 <20060903175841.7a84c63c.akpm@osdl.org> <44FBBD28.6070601@garzik.org>
	 <20060904055502.GA26816@tuatara.stupidest.org>
	 <1157370847.4624.15.camel@localhost.localdomain>
	 <20060904183352.GA14004@tuatara.stupidest.org>
	 <1157468155.30252.17.camel@localhost.localdomain>
	 <44FD9431.2050403@garzik.org>
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-prcOky5KZSwwkxvHMZRF"
Date: Wed, 06 Sep 2006 02:14:15 +0100
Message-Id: <1157505255.3145.32.camel@localhost.portugal>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
X-OriginalArrivalTime: 06 Sep 2006 01:21:06.0455 (UTC) FILETIME=[B9FD5A70:01C6D152]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-prcOky5KZSwwkxvHMZRF
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-09-05 at 11:13 -0400, Jeff Garzik wrote:
> Sergio Monteiro Basto wrote:
> > On Mon, 2006-09-04 at 11:33 -0700, Chris Wedgwood wrote:
> >> On Mon, Sep 04, 2006 at 12:54:07PM +0100, Sergio Monteiro Basto wrote:
> >>
> >>> I don't know if this is a real question. Have we VIA products on PCI
> >>> card, running on not VIA chip sets ?
> >> Yes.  Certainly for on-board devices too.
> >=20
> > OK , other argument.
> > We have billions of VIA chip sets with VIA PCI on-board and=20
> > VIA PCI on others chip sets, if exists, are a very few.
> > So, because some exceptions, we shouldn't stop a resolution of a very
> > large % of the cases.=20
>=20
> No thanks.  As VIA SATA maintainer, I like being able to use my VIA SATA=20
> PCI card.
>=20
> 	Jeff

I have 2 computer with 2 different Asrock
(http://www.asrock.com/product/775Dual-880Pro.htm) boards, both have a
VIA8237 and a VIA SATA, and both are quirked wrongly, when I use kernels
2.6.17+ .=20
And if I haven't bought this 2 computers in a supermarket, I won't be
here discussion this subjects.

So I like to remember =20
http://lkml.org/lkml/2006/7/28/264
http://lkml.org/lkml/2006/9/4/111 ( that confirm a VIA SATA on XT-PIC
mode ) http://lkml.org/lkml/2006/9/1/106 )

So VIA SATA needs my patch or Daniel Drake patch to _WORK_ .

Adding my patch to Daniel Drake patch ( that is already on -mm series )
could be a reasonable solution.

Patch for 2.6.18-rc5-mm1

Cc: Daniel Drake <dsd@gentoo.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Scott J. Harmon" <harmon@ksu.edu>
Cc: Andrew Morton <akpm@osdl.org>
Cc: Chris Wedgwood <cw@f00f.org>
Cc: Greg KH <greg@kroah.com>
Signed-off-by: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org
diff linux-2.6.17.x86_64/drivers/pci/quirks.c.orig linux-2.6.17.x86_64/driv=
ers/pci/quirks.c -up
--- linux-2.6.17.x86_64/drivers/pci/quirks.c.orig       2006-09-06 02:03:09=
.000000000 +0100
+++ linux-2.6.17.x86_64/drivers/pci/quirks.c    2006-09-06 02:05:44.0000000=
00 +0100
@@ -654,6 +654,14 @@ static void quirk_via_irq(struct pci_dev
 {
        u8 irq, new_irq;

+#ifdef CONFIG_X86_IO_APIC
+       if (nr_ioapics && !skip_ioapic_setup)
+               return;
+#endif
+#ifdef CONFIG_ACPI
+       if (acpi_irq_model !=3D ACPI_IRQ_MODEL_PIC)
+               return;
+#endif
        if (via_irq_fixup_needed =3D=3D -1)
                via_irq_fixup_needed =3D pci_dev_present(via_irq_fixup_tbl)=
;

@@ -663,7 +671,7 @@ static void quirk_via_irq(struct pci_dev
        new_irq =3D dev->irq & 0xf;
        pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
        if (new_irq !=3D irq) {
-               printk(KERN_INFO "PCI: VIA IRQ fixup for %s, from %d to %d\=
n",
+               printk(KERN_INFO "PCI: VIA PIC IRQ fixup for %s, from %d to=
 %d\n",
                        pci_name(dev), irq, new_irq);
                udelay(15);     /* unknown if delay really needed */
                pci_write_config_byte(dev, PCI_INTERRUPT_LINE, new_irq);


Thanks,
--=20
S=E9rgio M. B.

--=-prcOky5KZSwwkxvHMZRF
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
SIb3DQEJBTEPFw0wNjA5MDYwMTE0MTFaMCMGCSqGSIb3DQEJBDEWBBSn/f7v/NmXjT9QgCoGBVes
UOaYoDANBgkqhkiG9w0BAQEFAASCAQBrngn5bAee4/BJXAZ7oevl6iF/L7UNdO3uYGkiXBhqIUaP
p2GH7kMxOPtHOnuAiyfwYNQdVMeDahKrQlHetT5/EFpuzUpFx/1qs+nVOSJo9oayZYMks+Xwr/2Z
AIHxQGci1FMUUbwnNGnE3+MVgOdjnBdyWa5l50H8wRxmuxW/bkW5A01wiQKNbH6wyRaru1aLZy9h
MYlbbbPHp6d3sDozGDmsGbA45ydnSw6E5RvL/rfRDAqkD8CzGOQs3kuVdoveOwYEYQnkuEIHY3l7
HSjQyyDAcaax3jY+DtHYyIqNrkJYSGgvYYNBMU/WdZmBb5PSl+Z0uQtxZp2lxt0ttFCzAAAAAAAA



--=-prcOky5KZSwwkxvHMZRF--
