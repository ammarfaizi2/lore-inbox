Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131724AbRDQN3n>; Tue, 17 Apr 2001 09:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132620AbRDQN3d>; Tue, 17 Apr 2001 09:29:33 -0400
Received: from mailout00.sul.t-online.com ([194.25.134.16]:6148 "EHLO
	mailout00.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S131724AbRDQN31>; Tue, 17 Apr 2001 09:29:27 -0400
Message-ID: <3ADC4522.A778AB4C@computer.org>
Date: Tue, 17 Apr 2001 15:29:06 +0200
From: k.lichtenwalder@computer.org
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-ac3 i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4 raw devices don't do 64bit offset?
In-Reply-To: <E14p7Fo-0008VK-00@the-village.bc.nu> <3ADAEB38.44CBD71A@computer.org> <3ADB1243.327FB189@computer.org>
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------msCE8F135A2783C3DEA0C9DB5B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------msCE8F135A2783C3DEA0C9DB5B
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Well, I looked a bit deeper into it. The limiting factor is the
s_maxbytes value from the superblock. (If the offset is larger than
s_maxbytes, default_llseek will return EINVAL, what I'm seeing), So,
where does it inherit this value from? My fs is reiserfs, so there's a
4GB limit. But the raw device is bound to the dvd (maj 22, min 64)?

Klaus
k.lichtenwalder@computer.org wrote:
> 
> k.lichtenwalder@computer.org wrote:
> >
> > Alan Cox wrote:
> > >
> > > > sorry if this was already discussed, but I couldn't find it in the
> > > > archives. I'm trying to use xine (the linux dvd player) on
> > > > linux-2.4.3-ac3 and can't watch the whole dvd. The reason is that as
> > > > soon as the llseek sets a value in the offset_high field for sys_llseek,
> > > > I get a EINVAL back from the seek. Is this intentional? Or simply still
> > > > (only) a missing feature?
> > >
> > > Did you open the file with open64() ?
> >
> > No it's using open(), but sets -D_FILE_OFFSET_BITS=64. Looks like this
> > is not enough for the raw devices?
> 
> Just to be on the right track I simply forced it to using open64 all
> along on this descriptor. It doesn't change anything. And, for the
> records, if I delete the raw device so that xine uses the block device,
> everything works fine.

-- 
------------------------------------------------------------------------ 
 Klaus Lichtenwalder, Dipl. Inform.,       http://www.webforum.de/Klaus/
 Fax +49-(0)89-91072699                            Lichtenwalder@ACM.org
 NIC: KL2100, KL76-RIPE                     K.Lichtenwalder@Computer.org
 PGP Key fingerprint = 2658 EA97 E1A1 2680 5ECA  0036 80F5 F250 3CF8
C2C7
--------------msCE8F135A2783C3DEA0C9DB5B
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
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTAxMDQxNzEzMjkwNlowIwYJKoZIhvcNAQkE
MRYEFHCxe0El+mIY17hv4Ett09aeLQ2DMFIGCSqGSIb3DQEJDzFFMEMwCgYIKoZIhvcNAwcw
DgYIKoZIhvcNAwICAgCAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgFAMA0GCCqGSIb3DQMCAgEo
MA0GCSqGSIb3DQEBAQUABIGAHI6ZOGrTD092fpePvDg7PkQphTjjbx1lyyWWTrlene3fqDED
l/U13yaZpz0+ttdesYdJa2C2bKBDETF+xs8/gf/jz3ZwoEl9chLcsz+bWnfs7WgUQG63GM/q
hJKWvphS/ElJrqzkty9d1zO1McmXBLf+xaaJIVsD0BZlEyF2IyA=
--------------msCE8F135A2783C3DEA0C9DB5B--

