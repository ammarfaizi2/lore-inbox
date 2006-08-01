Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750708AbWHAXSg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbWHAXSg (ORCPT <rfc822;akpm@zip.com.au>);
	Tue, 1 Aug 2006 19:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbWHAXSg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 19:18:36 -0400
Received: from smtp3.netcabo.pt ([212.113.174.30]:17930 "EHLO
	exch01smtp12.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S1750708AbWHAXSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 19:18:35 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AT0KABp9z0SBUodVgS8B
X-Antivirus-bastov-Mail-From: sergio@sergiomb.no-ip.org via bastov.localdomain
X-Antivirus-bastov: 1.25-st-qms (Clear:RC:0(213.22.17.217):SA:1(10.3/5.0):. Processed in 3.288549 secs Process 22820)
Subject: Re: [2.6.18-rc2-mm1] pata_via fails
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Reply-To: sergio@sergiomb.no-ip.org
To: "J.A." =?ISO-8859-1?Q?Magall=F3n?= <jamagallon@ono.com>
Cc: "Linux-Kernel," <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
In-Reply-To: <20060802010415.2bebc5fc@werewolf.auna.net>
References: <20060802010415.2bebc5fc@werewolf.auna.net>
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-IgKN0St56ANi0jei9eMM"
Date: Wed, 02 Aug 2006 00:18:27 +0100
Message-Id: <1154474307.3819.5.camel@localhost.portugal>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
X-OriginalArrivalTime: 01 Aug 2006 23:18:34.0099 (UTC) FILETIME=[CF2F9C30:01C6B5C0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-IgKN0St56ANi0jei9eMM
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-08-02 at 01:04 +0200, J.A. Magall=F3n wrote:
> Jul 10 15:09:46 nada kernel: PCI: VIA IRQ fixup for 0000:00:11.1, from
> 255 to 0
> Any ideas ?
yes, try this patch
http://lkml.org/lkml/2006/7/28/99
As you are using -mm tree use just hunk #1 above

--- linux-2.6.17.i686/drivers/pci/quirks.c.orig	2006-07-28 12:59:04.0000000=
00 +0100
+++ linux-2.6.17.i686/drivers/pci/quirks.c	2006-07-28 13:26:49.000000000 +0=
100
@@ -648,11 +648,17 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_V
  *
  * Some of the on-chip devices are actually '586 devices' so they are
  * listed here.
+ *=20
+ * if flags say that we have working apic(s), we don't need to quirk these
+ * devices
  */
 static void quirk_via_irq(struct pci_dev *dev)
 {
 	u8 irq, new_irq;
=20
+	if ((smp_found_config && !skip_ioapic_setup && nr_ioapics) || cpu_has_api=
c)
+		return;
+
 	new_irq =3D dev->irq & 0xf;
 	pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
 	if (new_irq !=3D irq) {


--=20
S=E9rgio M. B.

--=-IgKN0St56ANi0jei9eMM
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
SIb3DQEJBTEPFw0wNjA4MDEyMzE4MjRaMCMGCSqGSIb3DQEJBDEWBBSiJFaeG4g3hrbH3P+tufZn
rYJjRzANBgkqhkiG9w0BAQEFAASCAQCa3DYOM27I/7x9IQUBlvBM6OQUY8N16uVevYu+39VW5ynL
UR0gX5ivQq+94GjxuqI6UqD8yDsIbVlkAI0hcwPTGLaSNEr0KUzhTYHwlvgFmh7W/FmYQGBKG0qD
wtQO+MGbAUiuqKwKpjV0r8drkrg9VvwA6Cm2l6dS0gHcJstjVmGqYFSZtivt9/Tq8trJfCgJTVAV
mpgMfd3MhyhQM47iLTIZtXSjVxMee3+0ywMqsbDNfGcHrRnQ8MS9vRHqO7guIwlFArB4A8c5t3T+
iZg2G4T1XIHtGMK+SUUIzBiJWwMu1DWQkN17EqGgJWNYxbB1W3JOX483deIVe4kJoeaCAAAAAAAA



--=-IgKN0St56ANi0jei9eMM--
