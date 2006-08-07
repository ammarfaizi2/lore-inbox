Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932359AbWHGUwa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbWHGUwa (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 7 Aug 2006 16:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932352AbWHGUwa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 16:52:30 -0400
Received: from smtp4.netcabo.pt ([212.113.174.31]:42425 "EHLO
	exch01smtp11.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S932358AbWHGUw3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 16:52:29 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AcwMAPNC10SBUodw
X-Antivirus-bastov-Mail-From: sergio@sergiomb.no-ip.org via bastov.localdomain
X-Antivirus-bastov: 1.25-st-qms (Clear:RC:0(213.22.17.217):SA:1(10.3/5.0):. Processed in 4.768231 secs Process 21306)
Subject: Re: Problem: irq 217: nobody cared + backtrace
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Reply-To: sergio@sergiomb.no-ip.org
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-usb-devel@lists.sourceforge.net,
        Greg Kroah-Hartman <gregkh@suse.de>
In-Reply-To: <9a8748490608040736n5c9ea078x79f4ce56b613703a@mail.gmail.com>
References: <9a8748490608030717x1db108f1m2cc616459bb776db@mail.gmail.com>
	 <Pine.LNX.4.44L0.0608031158560.7384-100000@iolanthe.rowland.org>
	 <9a8748490608040736n5c9ea078x79f4ce56b613703a@mail.gmail.com>
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-HEcbALXSzGlgrZTYIQKU"
Date: Mon, 07 Aug 2006 21:52:17 +0100
Message-Id: <1154983937.4682.6.camel@localhost.portugal>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
X-OriginalArrivalTime: 07 Aug 2006 20:52:27.0631 (UTC) FILETIME=[64713FF0:01C6BA63]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-HEcbALXSzGlgrZTYIQKU
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

my system is much different, but I got similar problems=20
http://bugme.osdl.org/show_bug.cgi?id=3D6419#c17

irq 201: nobody cared (try booting with the "irqpoll" option)

Call Trace:
 [<ffffffff8026a20a>] dump_stack+0x12/0x17
 [<ffffffff802b6c26>] __report_bad_irq+0x30/0x7d
 [<ffffffff802b6e46>] note_interrupt+0x1d3/0x219
 [<ffffffff802b6383>] __do_IRQ+0xc8/0x107
 [<ffffffff8026b166>] do_IRQ+0xe7/0xf5
 [<ffffffff8025d189>] ret_from_intr+0x0/0xa
DWARF2 unwinder stuck at ret_from_intr+0x0/0xa
Leftover inexact backtrace:
 <IRQ> <EOI> [<ffffffff80230d50>] unix_poll+0x0/0x99
 [<ffffffff802569ed>] mwait_idle+0x36/0x4a
 [<ffffffff8024888d>] cpu_idle+0x95/0xb8
 [<ffffffff806da842>] start_kernel+0x220/0x225
 [<ffffffff806da28a>] _sinittext+0x28a/0x28e

handlers:
[<ffffffff880eaaf5>] (rhine_interrupt+0x0/0xae3 [via_rhine])
Disabling IRQ #201

root@monteirov:~#cat /proc/interrupts
           CPU0       CPU1
  0:     356842     312644    IO-APIC-edge  timer
  1:        586        711    IO-APIC-edge  i8042
  6:          5          0    IO-APIC-edge  floppy
  7:          2          0    IO-APIC-edge  parport0
  8:          0          0    IO-APIC-edge  rtc
  9:          0          0   IO-APIC-level  acpi
 12:      33214      32075    IO-APIC-edge  i8042
 15:      11161      11127    IO-APIC-edge  ide1
193:      65857       9444   IO-APIC-level  libata
201:     100000          0   IO-APIC-level  eth0
         ^^^^^^
209:      91593      91062   IO-APIC-level  uhci_hcd:usb1,
uhci_hcd:usb2, uhci_hcd:usb3, uhci_hcd:usb4, ehci_hcd:usb5
217:       1151        538   IO-APIC-level  VIA8237
225:      49661      49438   IO-APIC-level  nvidia
NMI:        438        403
LOC:     669481     669457
ERR:          0
MIS:          0




On Fri, 2006-08-04 at 16:36 +0200, Jesper Juhl wrote:
> On 03/08/06, Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > Has this happened more than once?
>=20
> Seems to happen consistently after ~100000 interrupts.
>=20
> >  In case it happens again, here's how
> > you can get more information.  Turn on CONFIG_USB_DEBUG and
> > CONFIG_DEBUG_FS, and mount a debugfs filesystem somewhere (say
> > /sys/kernel/debug).  Then after the problem occurs, save a copy of
> >
> >         /sys/kernel/debug/uhci/0000:00:1d.1
> >
>=20
> # cat /sys/kernel/debug/uhci/0000:00:1d.1
> Root-hub state: auto-stopped   FSBR: 0
> HC status
>   usbcmd    =3D     0048   Maxp32 CF EGSM
>   usbstat   =3D     0020   HCHalted
>   usbint    =3D     0002
>   usbfrnum  =3D   (1)160
>   flbaseadd =3D 37428160
>   sof       =3D       40
>   stat1     =3D     0080
>   stat2     =3D     0080
> Most recent frame: 458 (88)   Last ISO frame: 458 (88)
>=20
>=20
> > That will indicate whether the UHCI controller thinks it is sending an
> > interrupt request.
> >
>=20
> And just for completenes, here's the backtrace I got just before
> saving the above info :
>=20
> irq 217: nobody cared (try booting with the "irqpoll" option)
>  [<c0103a3c>] show_trace_log_lvl+0x152/0x165
>  [<c0103a5e>] show_trace+0xf/0x13
>  [<c0103b59>] dump_stack+0x15/0x19
>  [<c013846e>] __report_bad_irq+0x24/0x7f
>  [<c0138552>] note_interrupt+0x6b/0xd5
>  [<c0137ca8>] __do_IRQ+0xf4/0x100
>  [<c01050a1>] do_IRQ+0x95/0xbc
>  [<c0103502>] common_interrupt+0x1a/0x20
>  [<c0137b7e>] handle_IRQ_event+0x20/0x56
>  [<c0137c4c>] __do_IRQ+0x98/0x100
>  [<c01050a1>] do_IRQ+0x95/0xbc
>  [<c0103502>] common_interrupt+0x1a/0x20
>  [<c0100e64>] mwait_idle+0x30/0x35
>  [<c0100d45>] cpu_idle+0x78/0x81
>  [<c04cc7fb>] start_kernel+0x173/0x19d
>  [<c0100210>] 0xc0100210
> DWARF2 unwinder stuck at 0xc0100210
> Leftover inexact backtrace:
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> handlers:
> [<c02c5c22>] (usb_hcd_irq+0x0/0x53)
> Disabling IRQ #217
>=20
>=20

--=-HEcbALXSzGlgrZTYIQKU
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
SIb3DQEJBTEPFw0wNjA4MDcyMDUyMTNaMCMGCSqGSIb3DQEJBDEWBBSRc3MTHGxHqpKGTAaeg3bf
2ijV4zANBgkqhkiG9w0BAQEFAASCAQAHuBj/1Z+pQ2vw+rqxrxn49hlQ2CVtqVkT8yCnPWvGEm0k
UfbpLbWzlYKHa9M8d9giIlFouTVdvxBdKNRXolrBFvbd2fHZYukk32c7dsxQum0VOyI9KqB5c5xT
GloMKcXo4Xabbtc1H8QfSR75sp9V6+oM6KH1ooZtV049ST/G3bLHYgilKZ5xw46deYrw65sV0e0e
+bM7GcnsVF9XNbps/VJTXnPflIslRxhmW/ab5DaIC+8jQhXPjd4pS8Ex6UxCWTVgUEghk42d/pqi
/iPOnTir39T74gHAE76BPj/uU8nzELwGg8sj37Oz41D2jxIx5qbRZFqp/1w7t3OBiGYtAAAAAAAA



--=-HEcbALXSzGlgrZTYIQKU--
