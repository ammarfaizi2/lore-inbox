Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932430AbWEXBMo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932430AbWEXBMo (ORCPT <rfc822;akpm@zip.com.au>);
	Tue, 23 May 2006 21:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932524AbWEXBMo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 21:12:44 -0400
Received: from smtp4.netcabo.pt ([212.113.174.31]:20105 "EHLO
	exch01smtp11.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S932430AbWEXBMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 21:12:43 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aa4HACtQc0SBTYY6gks
X-Antivirus-bastov-Mail-From: sergio@sergiomb.no-ip.org via bastov.localdomain
X-Antivirus-bastov: 1.25-st-qms (Clear:RC:0(213.22.17.147):SA:1(8.8/5.0):. Processed in 7.194119 secs Process 3454)
Subject: back to discussion of VIA quirk fixup
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Reply-To: sergio@sergiomb.no-ip.org
To: linux-acpi@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@osdl.org>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-oBofgayzHbuR94v9Bg8C"
Date: Wed, 24 May 2006 02:12:26 +0100
Message-Id: <1148433146.2885.41.camel@localhost.portugal>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2) 
X-OriginalArrivalTime: 24 May 2006 01:12:42.0059 (UTC) FILETIME=[27F8E1B0:01C67ECF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-oBofgayzHbuR94v9Bg8C
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,
Before this matter getting cold, I'd like to tell this:

1=BA This quirk_via_irq function has been created originally by Bjorn
Helgaas, so maybe he can tell better what patch does.

2=BA This is need it on a Compaq presario 700 (laptop) that I bought on
year 2002. After new ACPI get some stability and enter in kernel
(2.4.22), some quirks could be deleted. And when Bjorn has being to
introduction GSIs stuff, came with this patch that replace another bunch
of quirks.

3=BA On my new desktop, one Intel(R) Pentium(R) D ual, using lscpi -n, I
see that I got :
cat /usr/include/linux/pci_ids.h  | grep VIA | grep 3149
#define PCI_DEVICE_ID_VIA_8237_SATA     0x3149
PCI_DEVICE_ID_VIA_82C586_1      0x0571
PCI_DEVICE_ID_VIA_82C586_2      0x3038

But I think, I don't need this quirks, but with or without the quirks I
still have one oops on my ethernet card, you can have more details on:
http://bugme.osdl.org/show_bug.cgi?id=3D6419=20
I think my system runs better without quirks, but I am not sure and I
don't have a way to prove it !

REFERENCES:
http://lkml.org/lkml/2006/5/9/250

Subject	Re: [PATCH] VIA quirk fixup, additional PCI IDs=09
Dave Jones wrote:
>
> On Tue, May 09, 2006 at 12:59:16PM -0700, Andrew Morton wrote:
>  > This looks like a 2.6.17-worthy fix, but it's not clear.  Help.  What
>  > happens if 2.6.17 doesn't have this??
>=20
> We won't run the quirk on machines that used to have it run,
> so we get buggered up irq routing.
>=20
and
Andrew Morton wrote:
OK..

We used to have

DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_ANY_ID, quirk_via_irq);

and we now have

DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_0, qui=
rk_via_irq);
DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_1, qui=
rk_via_irq);
DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_2, qui=
rk_via_irq);
DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_3, qui=
rk_via_irq);
DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686, quirk=
_via_irq);
DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_4, qui=
rk_via_irq);
DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_5, qui=
rk_via_irq);

which is rather a step backwards, because we need to keep that list updated
now, and we'll fail to catch new devices.

What happens if we just revert 75cf7456dd87335f574dcd53c4ae616a2ad71a11?

It says

    Alan Cox pointed out that the VIA 'IRQ fixup' was erroneously running
    on my system which has no VIA southbridge (but I do have a VIA IEEE
    1394 device).

but so what?  Did anything actually go wrong?  Is it likely to go wrong in
the future?

Is there was a problem, is there something we can do at runtime in
quirk_via_irq() to avoid the problem, rather than expanding out the fixup
list in this manner?

Thanks,
--=20
S=E9rgio M. B.

--=-oBofgayzHbuR94v9Bg8C
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
SIb3DQEJBTEPFw0wNjA1MjQwMTEyMjJaMCMGCSqGSIb3DQEJBDEWBBR/1r1Sz3yDPcoNM7bQNGyL
mBItsDANBgkqhkiG9w0BAQEFAASCAQCVBBT6CS9x0uzYx8Bhto/T3t4/ZKYT2OqYIvL1k18eBjEI
7svpWcLuW6eEeMlbH96V4p2VqH1FZGGFQCiS9IgKFZAMHQXVDcqaezYQTwVVR8XKWBmdzMQyFYSu
5GBW5p0wdDws9cuLfDUFIAwe1d7xWJvIjUR3nvctTijvqsJT1zlJVdfirElPR5REyLc0ia6sZ/YD
5FqGQ6KNQVPtrhjEKra8LIZHYc/YScyXDboUpbQlJttB6kb6MmZ1S/kuq9a7fmSCjsZFQdbCuJZx
KnbYxAUz9xIzNaYoHgH7F0yhznwDn1KUEr1jk7lL0mSYrI7sQNGKJ12djxVsqQMwYg4IAAAAAAAA



--=-oBofgayzHbuR94v9Bg8C--
