Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132675AbRDQSxg>; Tue, 17 Apr 2001 14:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132817AbRDQSxQ>; Tue, 17 Apr 2001 14:53:16 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:16393 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S132675AbRDQSxG>; Tue, 17 Apr 2001 14:53:06 -0400
Message-ID: <3ADC90EB.526BF2FF@computer.org>
Date: Tue, 17 Apr 2001 20:52:27 +0200
From: k.lichtenwalder@computer.org
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-ac3 i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: xine discussion list <xine-user@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org
Subject: why raw devices don't seek above 4GB (sometimes)
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms485EA2BF86F3412615AA3740"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms485EA2BF86F3412615AA3740
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

ok,
I found my problem. As previously said, I'm on reiser. Which (obviously)
has a file size limit of 4GB set in the superblock. Llseek only allows
seek offsets which are smaller than the allowed file size. What happens
is:
I set up a raw device: raw /dev/raw/raw1 /dev/hdd
with /dev/hdd being my DVD drive.
Xine then does repeated llseeks on /dev/raw/raw1 until it gets above 4G.
Because /dev/raw/raw1 and the associated /dev/hdd both are on reiserfs,
and reiserfs has a 4G limit, llseek assumes the same for the associated
raw devices and returns from the llseek with EINVAL. Bang. 
I don't know whether there's an easy solution. 
Please contact me if you nee further details/tests

Klaus
-- 
------------------------------------------------------------------------ 
 Klaus Lichtenwalder, Dipl. Inform.,       http://www.webforum.de/Klaus/
 Fax +49-(0)89-91072699                            Lichtenwalder@ACM.org
 NIC: KL2100, KL76-RIPE                     K.Lichtenwalder@Computer.org
 PGP Key fingerprint = 2658 EA97 E1A1 2680 5ECA  0036 80F5 F250 3CF8
C2C7
--------------ms485EA2BF86F3412615AA3740
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIH8AYJKoZIhvcNAQcCoIIH4TCCB90CAQExCzAJBgUrDgMCGgUAMAsGCSqGSIb3DQEHAaCC
BcMwggKSMIIB+6ADAgECAgMET3AwDQYJKoZIhvcNAQEEBQAwgZIxCzAJBgNVBAYTAlpBMRUw
EwYDVQQIEwxXZXN0ZXJuIENhcGUxEjAQBgNVBAcTCUNhcGUgVG93bjEPMA0GA1UEChMGVGhh
d3RlMR0wGwYDVQQLExRDZXJ0aWZpY2F0ZSBTZXJ2aWNlczEoMCYGA1UEAxMfUGVyc29uYWwg
RnJlZW1haWwgUlNBIDIwMDAuOC4zMDAeFw0wMTAzMDQxMzIxNDdaFw0wMjAzMDQxMzIxNDda
ME4xHzAdBgNVBAMTFlRoYXd0ZSBGcmVlbWFpbCBNZW1iZXIxKzApBgkqhkiG9w0BCQEWHGsu
bGljaHRlbndhbGRlckBjb21wdXRlci5vcmcwgZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGB
ANqA0o51D3JnYIwGN4nr0wIzJyxAyaQl/ejwy2K2/EN4QTkGdUBccnsGp4BY3T9dC2LCjC8B
jzvH6RdiirmqcgewrAn9qs/77tEplYKQK4Fyb2fDHycar0Txe159q8D1/H952e3DD73KAdwy
oUa1Nyys7Qb5XeABsP/8lKOEOhaHAgMBAAGjOTA3MCcGA1UdEQQgMB6BHGsubGljaHRlbndh
bGRlckBjb21wdXRlci5vcmcwDAYDVR0TAQH/BAIwADANBgkqhkiG9w0BAQQFAAOBgQDMT0Tv
/mCyekubllPFpH7NAu3Meu2n4I4Vg4oBcju4LCuBfpGc0zWmgyf46wZyz5iQcwdkTCr9vWXH
ZJyA4F0aRBsbn9OkUed8i6hZllft3Wr7enzRbNnLJRbgGNWs0NZbfeMWKi6R0o3hYVTOrjro
uP8wud4MLPtofU9wa1/5CjCCAykwggKSoAMCAQICAQwwDQYJKoZIhvcNAQEEBQAwgdExCzAJ
BgNVBAYTAlpBMRUwEwYDVQQIEwxXZXN0ZXJuIENhcGUxEjAQBgNVBAcTCUNhcGUgVG93bjEa
MBgGA1UEChMRVGhhd3RlIENvbnN1bHRpbmcxKDAmBgNVBAsTH0NlcnRpZmljYXRpb24gU2Vy
dmljZXMgRGl2aXNpb24xJDAiBgNVBAMTG1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBDQTEr
MCkGCSqGSIb3DQEJARYccGVyc29uYWwtZnJlZW1haWxAdGhhd3RlLmNvbTAeFw0wMDA4MzAw
MDAwMDBaFw0wMjA4MjkyMzU5NTlaMIGSMQswCQYDVQQGEwJaQTEVMBMGA1UECBMMV2VzdGVy
biBDYXBlMRIwEAYDVQQHEwlDYXBlIFRvd24xDzANBgNVBAoTBlRoYXd0ZTEdMBsGA1UECxMU
Q2VydGlmaWNhdGUgU2VydmljZXMxKDAmBgNVBAMTH1BlcnNvbmFsIEZyZWVtYWlsIFJTQSAy
MDAwLjguMzAwgZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBAN4zMqZjxwklRT7SbngnZ4HF
2ogZgpcO40QpimM1Km1wPPrcrvfudG8wvDOQf/k0caCjbZjxw0+iZdsN+kvx1t1hpfmFzVWa
NRqdknWoJ67Ycvm6AvbXsJHeHOmr4BgDqHxDQlBRh4M88Dm0m1SKE4f/s5udSWYALQmJ7JRr
6aFpAgMBAAGjTjBMMCkGA1UdEQQiMCCkHjAcMRowGAYDVQQDExFQcml2YXRlTGFiZWwxLTI5
NzASBgNVHRMBAf8ECDAGAQH/AgEAMAsGA1UdDwQEAwIBBjANBgkqhkiG9w0BAQQFAAOBgQBz
G28mZYv/FTRLWWKK7US+ScfoDbuPuQ1qJipihB+4h2N0HG23zxpTkUvhzeY42e1Q9DpsNJKs
5pKcbsEjAcIJp+9LrnLdBmf1UG8uWLi2C8FQV7XsHNfvF7bViJu3ooga7TlbOX00/LaWGCVN
avSdxcORL6mWuAU8Uvzd6WIDSDGCAfUwggHxAgEBMIGaMIGSMQswCQYDVQQGEwJaQTEVMBMG
A1UECBMMV2VzdGVybiBDYXBlMRIwEAYDVQQHEwlDYXBlIFRvd24xDzANBgNVBAoTBlRoYXd0
ZTEdMBsGA1UECxMUQ2VydGlmaWNhdGUgU2VydmljZXMxKDAmBgNVBAMTH1BlcnNvbmFsIEZy
ZWVtYWlsIFJTQSAyMDAwLjguMzACAwRPcDAJBgUrDgMCGgUAoIGxMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTAxMDQxNzE4NTIzMVowIwYJKoZIhvcNAQkE
MRYEFDbouulKGEfjCNpvgdbgv+8ul8fAMFIGCSqGSIb3DQEJDzFFMEMwCgYIKoZIhvcNAwcw
DgYIKoZIhvcNAwICAgCAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgFAMA0GCCqGSIb3DQMCAgEo
MA0GCSqGSIb3DQEBAQUABIGAWmC7aPNQCAw+3PxuXCTTU5rayZk1J91Nm/ISYT1wV9ove/FC
ftvoXjzIdZZ3QaFkvqyvftBww3GHyZGMNo4y83cQBJyTlXxZmnpQnGiGC7cmFtW4BDWRCmOi
zpl5g2K91DGRHjVUujdD3Gnyr20rafBqSNkW0rBhh3qSjd3RbOY=
--------------ms485EA2BF86F3412615AA3740--

