Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291844AbSBNTLV>; Thu, 14 Feb 2002 14:11:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291842AbSBNTLE>; Thu, 14 Feb 2002 14:11:04 -0500
Received: from [208.179.59.195] ([208.179.59.195]:47740 "EHLO
	Booterz.killerlabs.com") by vger.kernel.org with ESMTP
	id <S291843AbSBNTLA>; Thu, 14 Feb 2002 14:11:00 -0500
Message-ID: <3C6C0BAE.7030701@blue-labs.org>
Date: Thu, 14 Feb 2002 14:10:38 -0500
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8+) Gecko/20020212
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] include/asm/checksum.h trigraph cleanups
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms090208020100030806090108"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms090208020100030806090108
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Subject says all, this is against 2.4.18-rc1.  Assembler blocks aligned 
with style used for first assembler block.

-d

--- include/asm/checksum.h.orig Thu Feb 14 14:06:31 2002
+++ include/asm/checksum.h      Thu Feb 14 14:05:16 2002
@@ -69,30 +69,31 @@
                                          unsigned int ihl) {
        unsigned int sum;
 
-       __asm__ __volatile__("
-           movl (%1), %0
-           subl $4, %2
-           jbe 2f
-           addl 4(%1), %0
-           adcl 8(%1), %0
-           adcl 12(%1), %0
-1:         adcl 16(%1), %0
-           lea 4(%1), %1
-           decl %2
-           jne 1b
-           adcl $0, %0
-           movl %0, %2
-           shrl $16, %0
-           addw %w2, %w0
-           adcl $0, %0
-           notl %0
-2:
-           "
+       __asm__ __volatile__(
+"          movl (%1), %0       \n"
+"          subl $4, %2         \n"
+"          jbe 2f              \n"
+"          addl 4(%1), %0      \n"
+"          adcl 8(%1), %0      \n"
+"          adcl 12(%1), %0     \n"
+"1:        adcl 16(%1), %0     \n"
+"          lea 4(%1), %1       \n"
+"          decl %2             \n"
+"          jne 1b              \n"
+"          adcl $0, %0         \n"
+"          movl %0, %2         \n"
+"          shrl $16, %0        \n"
+"          addw %w2, %w0       \n"
+"          adcl $0, %0         \n"
+"          notl %0             \n"
+"2:                            \n"
+
        /* Since the input registers which are loaded with iph and ipl
           are modified, we must also specify them as outputs, or gcc
           will assume they contain their original values. */
        : "=r" (sum), "=r" (iph), "=r" (ihl)
        : "1" (iph), "2" (ihl));
+
        return(sum);
 }
 
@@ -102,13 +103,13 @@
 
 static inline unsigned int csum_fold(unsigned int sum)
 {
-       __asm__("
-               addl %1, %0
-               adcl $0xffff, %0
-               "
-               : "=r" (sum)
-               : "r" (sum << 16), "0" (sum & 0xffff0000)
-       );
+       __asm__(
+"          addl %1, %0         \n"
+"          adcl $0xffff, %0    \n"
+
+       : "=r" (sum)
+       : "r" (sum << 16), "0" (sum & 0xffff0000));
+
        return (~sum) >> 16;
 }
 
@@ -118,15 +119,16 @@
                                                   unsigned short proto,
                                                   unsigned int sum)
 {
-    __asm__("
-       addl %1, %0
-       adcl %2, %0
-       adcl %3, %0
-       adcl $0, %0
-       "
+       __asm__(
+"          addl %1, %0         \n"
+"          adcl %2, %0         \n"
+"          adcl %3, %0         \n"
+"          adcl $0, %0         \n"
+
        : "=r" (sum)
        : "g" (daddr), "g"(saddr), "g"((ntohs(len)<<16)+proto*256), 
"0"(sum));
-    return sum;
+
+       return sum;
 }
 
 /*
@@ -158,22 +160,22 @@
                                                     unsigned short proto,
                                                     unsigned int sum)
 {
-       __asm__("
-               addl 0(%1), %0
-               adcl 4(%1), %0
-               adcl 8(%1), %0
-               adcl 12(%1), %0
-               adcl 0(%2), %0
-               adcl 4(%2), %0
-               adcl 8(%2), %0
-               adcl 12(%2), %0
-               adcl %3, %0
-               adcl %4, %0
-               adcl $0, %0
-               "
-               : "=&r" (sum)
-               : "r" (saddr), "r" (daddr),
-                 "r"(htonl(len)), "r"(htonl(proto)), "0"(sum));
+       __asm__(
+"          addl 0(%1), %0      \n"
+"          adcl 4(%1), %0      \n"
+"          adcl 8(%1), %0      \n"
+"          adcl 12(%1), %0     \n"
+"          adcl 0(%2), %0      \n"
+"          adcl 4(%2), %0      \n"
+"          adcl 8(%2), %0      \n"
+"          adcl 12(%2), %0     \n"
+"          adcl %3, %0         \n"
+"          adcl %4, %0         \n"
+"          adcl $0, %0         \n"
+
+       : "=&r" (sum)
+       : "r" (saddr), "r" (daddr),
+         "r"(htonl(len)), "r"(htonl(proto)), "0"(sum));
 
        return csum_fold(sum);
 }


--------------ms090208020100030806090108
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
ARYccGVyc29uYWwtZnJlZW1haWxAdGhhd3RlLmNvbTAeFw0wMDA4MzAwMDAwMDBaFw0wMjA4
MjkyMzU5NTlaMIGSMQswCQYDVQQGEwJaQTEVMBMGA1UECBMMV2VzdGVybiBDYXBlMRIwEAYD
VQQHEwlDYXBlIFRvd24xDzANBgNVBAoTBlRoYXd0ZTEdMBsGA1UECxMUQ2VydGlmaWNhdGUg
U2VydmljZXMxKDAmBgNVBAMTH1BlcnNvbmFsIEZyZWVtYWlsIFJTQSAyMDAwLjguMzAwgZ8w
DQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBAN4zMqZjxwklRT7SbngnZ4HF2ogZgpcO40QpimM1
Km1wPPrcrvfudG8wvDOQf/k0caCjbZjxw0+iZdsN+kvx1t1hpfmFzVWaNRqdknWoJ67Ycvm6
AvbXsJHeHOmr4BgDqHxDQlBRh4M88Dm0m1SKE4f/s5udSWYALQmJ7JRr6aFpAgMBAAGjTjBM
MCkGA1UdEQQiMCCkHjAcMRowGAYDVQQDExFQcml2YXRlTGFiZWwxLTI5NzASBgNVHRMBAf8E
CDAGAQH/AgEAMAsGA1UdDwQEAwIBBjANBgkqhkiG9w0BAQQFAAOBgQBzG28mZYv/FTRLWWKK
7US+ScfoDbuPuQ1qJipihB+4h2N0HG23zxpTkUvhzeY42e1Q9DpsNJKs5pKcbsEjAcIJp+9L
rnLdBmf1UG8uWLi2C8FQV7XsHNfvF7bViJu3ooga7TlbOX00/LaWGCVNavSdxcORL6mWuAU8
Uvzd6WIDSDGCAycwggMjAgEBMIGaMIGSMQswCQYDVQQGEwJaQTEVMBMGA1UECBMMV2VzdGVy
biBDYXBlMRIwEAYDVQQHEwlDYXBlIFRvd24xDzANBgNVBAoTBlRoYXd0ZTEdMBsGA1UECxMU
Q2VydGlmaWNhdGUgU2VydmljZXMxKDAmBgNVBAMTH1BlcnNvbmFsIEZyZWVtYWlsIFJTQSAy
MDAwLjguMzACAwZepDAJBgUrDgMCGgUAoIIBYTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0wMjAyMTQxOTEwMzhaMCMGCSqGSIb3DQEJBDEWBBQlU9bNVfSf
fUTkNdr4aOR4tEHzxzBSBgkqhkiG9w0BCQ8xRTBDMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMC
AgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDCBrQYLKoZIhvcN
AQkQAgsxgZ2ggZowgZIxCzAJBgNVBAYTAlpBMRUwEwYDVQQIEwxXZXN0ZXJuIENhcGUxEjAQ
BgNVBAcTCUNhcGUgVG93bjEPMA0GA1UEChMGVGhhd3RlMR0wGwYDVQQLExRDZXJ0aWZpY2F0
ZSBTZXJ2aWNlczEoMCYGA1UEAxMfUGVyc29uYWwgRnJlZW1haWwgUlNBIDIwMDAuOC4zMAID
Bl6kMA0GCSqGSIb3DQEBAQUABIIBADzCLunN7drAXBV6ipI+wBNlY/ZxGgk003soM7+YVl8S
b1Gec5mYrAn1nfJlBm7P3TK/mf5SQwwkL9TKAJAUnA40hnvw2zaVURJd8WWZfhtXTaMY7tC1
D1TtziF4ZUVdLObboY2/B8Wh7t7xe4Ltvx1vpTZdkDftnbqA7UkCvmfjOeq7kyfBw0olj0dK
s9FMny3HZdcuro7gLx+s9YyeNiIsjpt7t2GWldDu09iaRRwy+IiO154nx0oEx2D2RTVapdmC
U2OzTQAr3eV0584WUh4CpNyx8bm07DtRKDSTMua6FP4g932N/U96l6uc87Uupmp2YoiI/+iR
5OE4xo9m7hEAAAAAAAA=
--------------ms090208020100030806090108--

