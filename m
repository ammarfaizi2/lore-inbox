Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261885AbVHEUfM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbVHEUfM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 16:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261990AbVHEUfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 16:35:11 -0400
Received: from ctb-mesg2.saix.net ([196.25.240.82]:14495 "EHLO
	ctb-mesg2.saix.net") by vger.kernel.org with ESMTP id S261885AbVHEUeI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 16:34:08 -0400
Message-ID: <42F3CD35.3010906@cs.up.ac.za>
Date: Fri, 05 Aug 2005 22:33:57 +0200
From: Jaco Kroon <jkroon@cs.up.ac.za>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.10) Gecko/20050804
X-Accept-Language: en, af, en-gb, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: techteam@cs.up.ac.za
Subject: sporadic "freezes" on amd64 (GA K8NF)
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms090403000601060403050506"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms090403000601060403050506
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello all,

I'm absolutely stumped with this one.  We are still having problems
deciding whether this is a software problem or a hardware problem.  This
particular box (specs lower down) just freezes up sporadically when in
Linux.

Normally it just stops responding entirely.  As in one moment it's still
outputting and the next there is nothing.  Then once, (twice actually),
we actually got a kernel panic, I've taken a picture which can be found
at http://www.kroon.co.za/images/kernel_panic_amd64.jpg (Apologies for
the quality - phones aren't good at taking them).  From this panic (and
the other which I had no way of capturing at the time) it looks like a
bug somewhere when accessing the hard drive.  The one here was on
reiserfs the other was on ext3.

Hardware specs:

2GB RAM
Gigabyte K8NF
AMD 3500+ processor
Ge force 6200 graphics card

We've tried at least three different distributions (Mandrake, SuSE and
Gentoo) with both ext3 and reiserfs as file systems.  Mandrake and SuSE
was 32-bit versions and we tried both a 32 and 64 bit Gentoo.

I've tried various kernels, from 2.6.10, 2.6.11.8, 2.6.11.11, 2.6.12,
2.6.12.3 - all to no avail.  Unfortunately I don't have the kernel
config that was in use when we captured the trace any more.  We are
using the sata_nv module for the sata controller though.

Now for the truly odd thing:  When we down the RAM to 1GB it works fine.
 So we suspected that something might be wrong with the RAM controller
and instead of 4 x 512MB we asked for 2 x 1GB, apparently this crashed
as well.

And for those who want to ask, yes, we've left it doing memtest for a
week, we have tried different combinations of the 4 chips when going
down to 1GB (all the combinations we tried - about 10 - worked).  And
yes, all the burn-in tests (all of the ones on the ultimate boot CD) as
well as some burn-in tests from the suppliers (under Windows) worked
perfectly.  We also ran some benchmarking tools on Windows (Suppliers
said if we can consistently crash Windows they'll swap out, to quote "It
runs Windows - it performs within spec").  Needless to say - we're not
going back to them for future purchases.

And no, we are not using the binary nvidia module :).

Thanks in advance for any and all suggestions.

Jaco

PS:  A text-only version of the stack trace (minus a lot of numbers):
Call Trace:<IRQ> {as_remove_queued_request+288}{as_move_to_dispatch+342}
    {as_next_request+941}{elv_next_request+277}
    {scsi_request_fn+89}{blk_run_queue+40}
    {scsi_end_request+252}{scsi_io_completion+484}
    {sd_rw_intr+598}{scsi_sofirq+53}
    {__do_softirq+83}{do_softirq+53}
    {irq_exit+76}{do_IRQ+71}
    {ret_from_intr+0} <EOI> {system_call+126}

Code: 83 79 88 01 75 09 e9 a7 00 00 00 48 8b 4f 10 48 85 c9 66 90
RIP <ffffffff{rb_erase+384} RSP <ffffffff804379d0>
CR2: 0000.0002e8
 <0>Kernel panic - not synching: Aiee, killing interrupt handler!

--------------ms090403000601060403050506
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIII7TCC
AtEwggI6oAMCAQICAw3p3jANBgkqhkiG9w0BAQQFADBiMQswCQYDVQQGEwJaQTElMCMGA1UE
ChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNv
bmFsIEZyZWVtYWlsIElzc3VpbmcgQ0EwHhcNMDUwMTI4MjExODIyWhcNMDYwMTI4MjExODIy
WjBEMR8wHQYDVQQDExZUaGF3dGUgRnJlZW1haWwgTWVtYmVyMSEwHwYJKoZIhvcNAQkBFhJq
a3Jvb25AY3MudXAuYWMuemEwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCtr2Ta
AszjX/i0k6VWrGUJXaw6xOSXHSt6bYm7w+KrkbROimvs3Lb2FqeTWH2SufIsNhysZBC0LScn
oTN+phyNg2FTLeZXC0PfWlAtoLbti53UG5YX2TAqtUJxuoCNfReHkmq+V2ZnYabk2GYMYR+X
uXBQxXPVI0Kc5d5lLW+Vs7L2eRbUinzM860ZnG75t2kfWsGYIA1YtuFmzNDMCgZZEszm63+V
Z/lDz2Mv26fRPI2Y/ynUWh3w4+maEOFx4bBgvqC6wWa20xxxX4plsL9r7qB5y/VArVnwOa+x
04cDLdeXqi5SKefQaPgsGHnL4nj3G7X/yM65VPOztsY6icxbAgMBAAGjLzAtMB0GA1UdEQQW
MBSBEmprcm9vbkBjcy51cC5hYy56YTAMBgNVHRMBAf8EAjAAMA0GCSqGSIb3DQEBBAUAA4GB
AICJNcVMqOobQZ4/TZUDbhDm47MOm37bUR0JsTPPmSzFhT1FBIVCknH5eV/+cZg49czmqykB
7Kb2fNICyoNXTB4QeRtmf8yRLHX6rxXk7cb3olbdJ34GwCj8aer8OIrJ+xpFgagtPWy0uFEj
5AsDCeXzxs9ULLRYhyGpUFpxA3b7MIIC0TCCAjqgAwIBAgIDDeneMA0GCSqGSIb3DQEBBAUA
MGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQu
MSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQTAeFw0wNTAx
MjgyMTE4MjJaFw0wNjAxMjgyMTE4MjJaMEQxHzAdBgNVBAMTFlRoYXd0ZSBGcmVlbWFpbCBN
ZW1iZXIxITAfBgkqhkiG9w0BCQEWEmprcm9vbkBjcy51cC5hYy56YTCCASIwDQYJKoZIhvcN
AQEBBQADggEPADCCAQoCggEBAK2vZNoCzONf+LSTpVasZQldrDrE5JcdK3ptibvD4quRtE6K
a+zctvYWp5NYfZK58iw2HKxkELQtJyehM36mHI2DYVMt5lcLQ99aUC2gtu2LndQblhfZMCq1
QnG6gI19F4eSar5XZmdhpuTYZgxhH5e5cFDFc9UjQpzl3mUtb5WzsvZ5FtSKfMzzrRmcbvm3
aR9awZggDVi24WbM0MwKBlkSzObrf5Vn+UPPYy/bp9E8jZj/KdRaHfDj6ZoQ4XHhsGC+oLrB
ZrbTHHFfimWwv2vuoHnL9UCtWfA5r7HThwMt15eqLlIp59Bo+CwYecviePcbtf/IzrlU87O2
xjqJzFsCAwEAAaMvMC0wHQYDVR0RBBYwFIESamtyb29uQGNzLnVwLmFjLnphMAwGA1UdEwEB
/wQCMAAwDQYJKoZIhvcNAQEEBQADgYEAgIk1xUyo6htBnj9NlQNuEObjsw6bfttRHQmxM8+Z
LMWFPUUEhUKScfl5X/5xmDj1zOarKQHspvZ80gLKg1dMHhB5G2Z/zJEsdfqvFeTtxveiVt0n
fgbAKPxp6vw4isn7GkWBqC09bLS4USPkCwMJ5fPGz1QstFiHIalQWnEDdvswggM/MIICqKAD
AgECAgENMA0GCSqGSIb3DQEBBQUAMIHRMQswCQYDVQQGEwJaQTEVMBMGA1UECBMMV2VzdGVy
biBDYXBlMRIwEAYDVQQHEwlDYXBlIFRvd24xGjAYBgNVBAoTEVRoYXd0ZSBDb25zdWx0aW5n
MSgwJgYDVQQLEx9DZXJ0aWZpY2F0aW9uIFNlcnZpY2VzIERpdmlzaW9uMSQwIgYDVQQDExtU
aGF3dGUgUGVyc29uYWwgRnJlZW1haWwgQ0ExKzApBgkqhkiG9w0BCQEWHHBlcnNvbmFsLWZy
ZWVtYWlsQHRoYXd0ZS5jb20wHhcNMDMwNzE3MDAwMDAwWhcNMTMwNzE2MjM1OTU5WjBiMQsw
CQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoG
A1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0EwgZ8wDQYJKoZIhvcN
AQEBBQADgY0AMIGJAoGBAMSmPFVzVftOucqZWh5owHUEcJ3f6f+jHuy9zfVb8hp2vX8MOmHy
v1HOAdTlUAow1wJjWiyJFXCO3cnwK4Vaqj9xVsuvPAsH5/EfkTYkKhPPK9Xzgnc9A74r/rsY
Pge/QIACZNenprufZdHFKlSFD0gEf6e20TxhBEAeZBlyYLf7AgMBAAGjgZQwgZEwEgYDVR0T
AQH/BAgwBgEB/wIBADBDBgNVHR8EPDA6MDigNqA0hjJodHRwOi8vY3JsLnRoYXd0ZS5jb20v
VGhhd3RlUGVyc29uYWxGcmVlbWFpbENBLmNybDALBgNVHQ8EBAMCAQYwKQYDVR0RBCIwIKQe
MBwxGjAYBgNVBAMTEVByaXZhdGVMYWJlbDItMTM4MA0GCSqGSIb3DQEBBQUAA4GBAEiM0VCD
6gsuzA2jZqxnD3+vrL7CF6FDlpSdf0whuPg2H6otnzYvwPQcUCCTcDz9reFhYsPZOhl+hLGZ
GwDFGguCdJ4lUJRix9sncVcljd2pnDmOjCBPZV+V2vf3h9bGCE6u9uo05RAaWzVNd+NWIXiC
3CEZNd4ksdMdRv9dX2VPMYIDOzCCAzcCAQEwaTBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMc
VGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFs
IEZyZWVtYWlsIElzc3VpbmcgQ0ECAw3p3jAJBgUrDgMCGgUAoIIBpzAYBgkqhkiG9w0BCQMx
CwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0wNTA4MDUyMDMzNTdaMCMGCSqGSIb3DQEJ
BDEWBBR+UA9t/ud5KM/g2EJVZPhvB+9H3jBSBgkqhkiG9w0BCQ8xRTBDMAoGCCqGSIb3DQMH
MA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIB
KDB4BgkrBgEEAYI3EAQxazBpMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29u
c3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwg
SXNzdWluZyBDQQIDDeneMHoGCyqGSIb3DQEJEAILMWugaTBiMQswCQYDVQQGEwJaQTElMCMG
A1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBl
cnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0ECAw3p3jANBgkqhkiG9w0BAQEFAASCAQCB7FWx
T3/KKVop6ZFS7ta2gBJI7nlblqqWOmS6Us+axijtn1L0BIpSIDoSXZrn1XXBdnrOlLd6Rqoh
vLTjrvj/O8CoqZ8VTp9cXBNmmBUHmSDZZM/JG7ncVJQgXEtp21E/YP9/ydkdzOWmEAnVs+s8
0D5ju9Zpvk2sVLsCsRO7vVblbFOyL+aF8eRClH4h3OE8oldq/cphT5Bex8sVHgvAuH73070C
OSasaHFOaXck8llRwAo6Ph3uccGTr3yNlG2uA/2hLacN+OdFFQQJixjagIUQX5Vdxn/QKRGp
6i0Wxvz3/CjxECL4g10claSKyrQxzBhOUDCu/VQFnTMqWyIFAAAAAAAA
--------------ms090403000601060403050506--
