Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261877AbTKZOOC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 09:14:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262569AbTKZOOB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 09:14:01 -0500
Received: from siaar1aa.compuserve.com ([149.174.40.9]:57502 "EHLO
	siaar1aa.compuserve.com") by vger.kernel.org with ESMTP
	id S261877AbTKZONz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 09:13:55 -0500
Message-ID: <3FC4B5C8.6020405@aol.com>
Date: Wed, 26 Nov 2003 15:16:40 +0100
From: Kai Bankett <kbankett@aol.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] irq_balance does not make sense with HT but single physical
 CPU
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms070304070205020202040402"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms070304070205020202040402
Content-Type: multipart/mixed;
 boundary="------------000508070201080709030703"

This is a multi-part message in MIME format.
--------------000508070201080709030703
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Hi @all,

this patch should disable irq_balance threat in case of only one 
installed physical cpu thats running in HyperThreading-mode (so reported 
as 2 cpus).
I think it should make no sense to run irq_blanance in that special case 
- please correct me if i´m wrong.

Thanks,

Kai


--------------000508070201080709030703
Content-Type: text/plain;
 name="2.6.0-test10-io_apic.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.6.0-test10-io_apic.diff"

diff -u -r -N linux-2.6.0-test10/arch/i386/kernel/io_apic.c linux-2.6.0-test10-kai/arch/i386/kernel/io_apic.c
--- linux-2.6.0-test10/arch/i386/kernel/io_apic.c	2003-11-24 02:31:38.000000000 +0100
+++ linux-2.6.0-test10-kai/arch/i386/kernel/io_apic.c	2003-11-26 14:30:29.000000000 +0100
@@ -627,6 +627,16 @@
 		irqbalance_disabled = 1;
 		return 0;
 	}
+
+#ifdef CONFIG_X86_HT
+	/* On Hyper-Threading CPUs - if only one physical installed
+	   balance does not make sense */
+	if (cpu_has_ht && smp_num_siblings == 2 && num_online_cpus() == 2) {
+		irqbalance_disabled = 1;
+		return 0;
+	}
+#endif
+
 	/*
 	 * Enable physical balance only if more than 1 physical processor
 	 * is present

--------------000508070201080709030703--

--------------ms070304070205020202040402
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIJQDCC
Av4wggJnoAMCAQICAwngETANBgkqhkiG9w0BAQQFADCBkjELMAkGA1UEBhMCWkExFTATBgNV
BAgTDFdlc3Rlcm4gQ2FwZTESMBAGA1UEBxMJQ2FwZSBUb3duMQ8wDQYDVQQKEwZUaGF3dGUx
HTAbBgNVBAsTFENlcnRpZmljYXRlIFNlcnZpY2VzMSgwJgYDVQQDEx9QZXJzb25hbCBGcmVl
bWFpbCBSU0EgMjAwMC44LjMwMB4XDTAzMDUwNTE0NTAyM1oXDTA0MDUwNDE0NTAyM1owQjEf
MB0GA1UEAxMWVGhhd3RlIEZyZWVtYWlsIE1lbWJlcjEfMB0GCSqGSIb3DQEJARYQa2Jhbmtl
dHRAYW9sLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALMFsOrR2jINM/04
7ut/y2rXUEFIPEfP3WezS5wyz1WXi3LVta3oGZ5VYGstJyCX9BJJob5GhP0MLTyTdthpX+Kf
gEbfuew52WzXY2xgOwoAiEigTyRBIOlTG2xx2y9oT4o3WVnw58MbMTNDWizCiR0TlAZw9V0p
nDqdGOHz6sFCMk3CSsTJOAhvtUjdeFT5D0R8TD5VnLYg4Skpj1qce1RntAgaAzN+8OKB6vf+
xGfmGym/RUhhGXl9b+WR4p1tQbhH/VKhgE4FapXJ/nb5Cxsbf1zBfSh2pTCOHba/Tcqg9+uA
crY1D0mWwhuqPl1umE7kE6XDpmrnR0lMRDz1PKsCAwEAAaMtMCswGwYDVR0RBBQwEoEQa2Jh
bmtldHRAYW9sLmNvbTAMBgNVHRMBAf8EAjAAMA0GCSqGSIb3DQEBBAUAA4GBALBWhbhz5ltx
Rgc3sutBBL+tFB78zt5yR1D4XFRLUKC2amC/znS2cpMYPhidL4zp2QKCStbiVFHfclnhJiVQ
FOZ7qOaAYnQG5jMmryVyrriNW+Xhvowar2Huhh1vxlGP4abrLqC6pw3xZglr/v8R9HRtxYMk
eeG1Pg2D4ghk0ZAKMIIC/jCCAmegAwIBAgIDCeARMA0GCSqGSIb3DQEBBAUAMIGSMQswCQYD
VQQGEwJaQTEVMBMGA1UECBMMV2VzdGVybiBDYXBlMRIwEAYDVQQHEwlDYXBlIFRvd24xDzAN
BgNVBAoTBlRoYXd0ZTEdMBsGA1UECxMUQ2VydGlmaWNhdGUgU2VydmljZXMxKDAmBgNVBAMT
H1BlcnNvbmFsIEZyZWVtYWlsIFJTQSAyMDAwLjguMzAwHhcNMDMwNTA1MTQ1MDIzWhcNMDQw
NTA0MTQ1MDIzWjBCMR8wHQYDVQQDExZUaGF3dGUgRnJlZW1haWwgTWVtYmVyMR8wHQYJKoZI
hvcNAQkBFhBrYmFua2V0dEBhb2wuY29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC
AQEAswWw6tHaMg0z/Tju63/LatdQQUg8R8/dZ7NLnDLPVZeLctW1regZnlVgay0nIJf0Ekmh
vkaE/QwtPJN22Glf4p+ARt+57DnZbNdjbGA7CgCISKBPJEEg6VMbbHHbL2hPijdZWfDnwxsx
M0NaLMKJHROUBnD1XSmcOp0Y4fPqwUIyTcJKxMk4CG+1SN14VPkPRHxMPlWctiDhKSmPWpx7
VGe0CBoDM37w4oHq9/7EZ+YbKb9FSGEZeX1v5ZHinW1BuEf9UqGATgVqlcn+dvkLGxt/XMF9
KHalMI4dtr9NyqD364BytjUPSZbCG6o+XW6YTuQTpcOmaudHSUxEPPU8qwIDAQABoy0wKzAb
BgNVHREEFDASgRBrYmFua2V0dEBhb2wuY29tMAwGA1UdEwEB/wQCMAAwDQYJKoZIhvcNAQEE
BQADgYEAsFaFuHPmW3FGBzey60EEv60UHvzO3nJHUPhcVEtQoLZqYL/OdLZykxg+GJ0vjOnZ
AoJK1uJUUd9yWeEmJVAU5nuo5oBidAbmMyavJXKuuI1b5eG+jBqvYe6GHW/GUY/hpusuoLqn
DfFmCWv+/xH0dG3FgyR54bU+DYPiCGTRkAowggM4MIICoaADAgECAhBmRXK3zHT1z2N2RYTQ
LpEBMA0GCSqGSIb3DQEBBAUAMIHRMQswCQYDVQQGEwJaQTEVMBMGA1UECBMMV2VzdGVybiBD
YXBlMRIwEAYDVQQHEwlDYXBlIFRvd24xGjAYBgNVBAoTEVRoYXd0ZSBDb25zdWx0aW5nMSgw
JgYDVQQLEx9DZXJ0aWZpY2F0aW9uIFNlcnZpY2VzIERpdmlzaW9uMSQwIgYDVQQDExtUaGF3
dGUgUGVyc29uYWwgRnJlZW1haWwgQ0ExKzApBgkqhkiG9w0BCQEWHHBlcnNvbmFsLWZyZWVt
YWlsQHRoYXd0ZS5jb20wHhcNMDAwODMwMDAwMDAwWhcNMDQwODI3MjM1OTU5WjCBkjELMAkG
A1UEBhMCWkExFTATBgNVBAgTDFdlc3Rlcm4gQ2FwZTESMBAGA1UEBxMJQ2FwZSBUb3duMQ8w
DQYDVQQKEwZUaGF3dGUxHTAbBgNVBAsTFENlcnRpZmljYXRlIFNlcnZpY2VzMSgwJgYDVQQD
Ex9QZXJzb25hbCBGcmVlbWFpbCBSU0EgMjAwMC44LjMwMIGfMA0GCSqGSIb3DQEBAQUAA4GN
ADCBiQKBgQDeMzKmY8cJJUU+0m54J2eBxdqIGYKXDuNEKYpjNSptcDz63K737nRvMLwzkH/5
NHGgo22Y8cNPomXbDfpL8dbdYaX5hc1VmjUanZJ1qCeu2HL5ugL217CR3hzpq+AYA6h8Q0JQ
UYeDPPA5tJtUihOH/7ObnUlmAC0JieyUa+mhaQIDAQABo04wTDApBgNVHREEIjAgpB4wHDEa
MBgGA1UEAxMRUHJpdmF0ZUxhYmVsMS0yOTcwEgYDVR0TAQH/BAgwBgEB/wIBADALBgNVHQ8E
BAMCAQYwDQYJKoZIhvcNAQEEBQADgYEAMbFLR135AXHl9VNsXXnWPZjAJhNigSKnEvgilegb
SbcnewQ5uvzm8iTrkfq97A0qOPdQVahs9w2tTBu8A/S166JHn2yiDFiNMUIJEWywGmnRKxKy
QF1q+XnQ6i4l3Yrk/NsNH50C81rbyjz2ROomaYd/SJ7OpZ/nhNjJYmKtBcYxggPVMIID0QIB
ATCBmjCBkjELMAkGA1UEBhMCWkExFTATBgNVBAgTDFdlc3Rlcm4gQ2FwZTESMBAGA1UEBxMJ
Q2FwZSBUb3duMQ8wDQYDVQQKEwZUaGF3dGUxHTAbBgNVBAsTFENlcnRpZmljYXRlIFNlcnZp
Y2VzMSgwJgYDVQQDEx9QZXJzb25hbCBGcmVlbWFpbCBSU0EgMjAwMC44LjMwAgMJ4BEwCQYF
Kw4DAhoFAKCCAg8wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcN
MDMxMTI2MTQxNjQwWjAjBgkqhkiG9w0BCQQxFgQUaZCP+Cw6nNYoP3gVn8zELKhSE+cwUgYJ
KoZIhvcNAQkPMUUwQzAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwIC
AUAwBwYFKw4DAgcwDQYIKoZIhvcNAwICASgwgasGCSsGAQQBgjcQBDGBnTCBmjCBkjELMAkG
A1UEBhMCWkExFTATBgNVBAgTDFdlc3Rlcm4gQ2FwZTESMBAGA1UEBxMJQ2FwZSBUb3duMQ8w
DQYDVQQKEwZUaGF3dGUxHTAbBgNVBAsTFENlcnRpZmljYXRlIFNlcnZpY2VzMSgwJgYDVQQD
Ex9QZXJzb25hbCBGcmVlbWFpbCBSU0EgMjAwMC44LjMwAgMJ4BEwga0GCyqGSIb3DQEJEAIL
MYGdoIGaMIGSMQswCQYDVQQGEwJaQTEVMBMGA1UECBMMV2VzdGVybiBDYXBlMRIwEAYDVQQH
EwlDYXBlIFRvd24xDzANBgNVBAoTBlRoYXd0ZTEdMBsGA1UECxMUQ2VydGlmaWNhdGUgU2Vy
dmljZXMxKDAmBgNVBAMTH1BlcnNvbmFsIEZyZWVtYWlsIFJTQSAyMDAwLjguMzACAwngETAN
BgkqhkiG9w0BAQEFAASCAQBEOZXFICF74q1rj2vHaPbvvUBHsJm43AteHWMy7oSqWNicmmQO
SuDYOmPq0f/ybh7S453jpn0r0Fp3d8VxaYigGErlfo9XvABlpIrTqrzMzcsge9h+67GCuprh
eNUIb+QmghD1HXdg7yceo6sWdCKIDhgjuLquqNwXHNXTAwxFO6xg54EX8j6QuPxzTstsmnHo
/akKl4CcAHOwTrursQAG0E5qo8uaQzHw82ZFnfvTEDS8usf4yhvjLVKQi1qgIwoWHeikHPKw
2sAl/ABRHzN4NIHEnDYTc8sWB2TX5+O0m7/UvsNROfpiH0/dHWcP8afAZj431eLMLPvQs8w7
U4DxAAAAAAAA
--------------ms070304070205020202040402--

