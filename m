Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318310AbSHUONJ>; Wed, 21 Aug 2002 10:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318313AbSHUONJ>; Wed, 21 Aug 2002 10:13:09 -0400
Received: from zeus.kernel.org ([204.152.189.113]:7094 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S318310AbSHUONE>;
	Wed, 21 Aug 2002 10:13:04 -0400
Message-ID: <3D63A2FC.92BA1342@otpbank.hu>
Date: Wed, 21 Aug 2002 16:26:04 +0200
From: Nagy Tibor <nagyt@otpbank.hu>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: hu, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Dell Perc 3/QC performance
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------msD99E45FE60C268541AF7ECFE"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------msD99E45FE60C268541AF7ECFE
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

I am not satisfied with the disk I/O performance of the RAID controller
'Dell Perc 3/QC' (AMI megaraid) under Linux.

Short description of my problem:

We have a Dell PowerEdge 6600 + PERC 3/QC, and I am not satisfied with
the performance. I/O speed is not linearly growing if I read more disks
simultenausly. If I read 1 disk, I get about 49 MB/s read speed, if I
read 2 disks simultaneosly I get about 64 MB/s read speed (only
+15MB/s), if I read 3 disks simultaneosly I get about 68 MB/s read speed
(only +4MB/s), If I read more disk I don't get higher speed.

Do you have any idea, what is the problem?

Detailed description:

1. Configuration

Dell Poweredge 6600: 4 x 1400 MHz, 4 GB RAM
PERC 3/QC Firmware: 1.61N Bios: 3.17

 Logical drive 0 (18 GB) - RAID 1 - Channel 0 Id 0 - 18 GB
                                  \ Channel 0 Id 1 - 18 GB

 Logical drive 1 (22 GB) - RAID 1 - Channel 2 Id 0 - 72 GB
 Logical drive 2 (22 GB) +        \ Channel 3 Id 9 - 72 GB
 Logical drive 3 (24 GB) /

 Logical drive 4 (22 GB) - RAID 1 - Channel 2 Id 1 - 72 GB
 Logical drive 5 (22 GB) +        \ Channel 3 Id 10 - 72 GB
 Logical drive 6 (24 GB) /

 Logical drive 7 (22 GB) - RAID 1 - Channel 2 Id 2 - 72 GB
 Logical drive 8 (22 GB) +        \ Channel 3 Id 11 - 72 GB
 Logical drive 9 (24 GB) /

 18 GB disks: Quantum ATLAS 10KIII 18 SCA (160 MB SCSI)
 72 GB disks: Hitachi DK32DJ-72 (160 MB SCSI)

 The 18 GB disks are installed in the server itself, the 72 GB disks are
installed in a PowerVault 221S disk tower with splitted backplane.

 The 72 GB disks are splitted into 22-24 GB logical drives, because
Informix database engine can use max 2GB chunks (partitions), and only
15 partitions can be installed in linux on 1 drive.

 'Cache policy' is set to 'Direct IO' and 'Read (ahead) policy' to
'adaptive' for all logical drives. (I tried other confugurations, too.)

 Logical drives 1-9 are used as raw devices by informix, logical drive 0
is for the operating system.

2. Operating system

SuSe Linux 8.0, kernel 2.4.18

emiir:~ # uname -a
Linux emiir 2.4.18-64GB-SMP #1 SMP Wed Mar 27 13:58:12 UTC 2002 i686
unknown


3. I/O test

3.1 Read from Logical drive 1

dd if=/dev/rsdb1 of=/dev/null bs=1024k	->  49 MB/s I/O

3.2 Read from Logical drive 1 and 4 (different disks)

dd if=/dev/rsdb1 of=/dev/null bs=1024k &
dd if=/dev/rsde1 of=/dev/null bs=1024k &  -> 64 MB/s I/O

3.2 Read from Logical drive 1, 4 and 7 (different disks)

dd if=/dev/rsdb1 of=/dev/null bs=1024k &
dd if=/dev/rsde1 of=/dev/null bs=1024k &
dd if=/dev/rsdh1 of=/dev/null bs=1024k &  -> 68 MB/s I/O

All I/O speed came from the column 'bi' of 'vmstat 1'.


4. Result

I do not understand, why the speed is not increased nearly linearly. The
I/O between the PERC controller and the host is 64 bit PCI with 66MHz,
ca. 530MB/s, each of the four SCSI channel has a speed of 160MB/s. At
least test 3.2 should result the double of the speed of test 3.1 (two
SCSI channel, separate disks).

I see also on the dell site 300 MB/s for sequential read:
  http://www.dell.com/us/en/biz/topics/power_ps1q02-perc.htm

Do you have any idea what can be wrong?

Than you

Tibor

------------------------------------------------------------------------
Tibor Nagy
National Savings and Commercial Bank Ltd (OTP Bank)
H-1051 Budapest Nador u. 16.
Tel: 00 36 1 374 6990	Fax: 00 36 1 374 6981	E-mail: nagyt@otpbank.hu
------------------------------------------------------------------------
--------------msD99E45FE60C268541AF7ECFE
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIH5wYJKoZIhvcNAQcCoIIH2DCCB9QCAQExCzAJBgUrDgMCGgUAMAsGCSqGSIb3DQEHAaCC
BbowggJ6MIIB46ADAgECAgMHn6wwDQYJKoZIhvcNAQEEBQAwgZIxCzAJBgNVBAYTAlpBMRUw
EwYDVQQIEwxXZXN0ZXJuIENhcGUxEjAQBgNVBAcTCUNhcGUgVG93bjEPMA0GA1UEChMGVGhh
d3RlMR0wGwYDVQQLExRDZXJ0aWZpY2F0ZSBTZXJ2aWNlczEoMCYGA1UEAxMfUGVyc29uYWwg
RnJlZW1haWwgUlNBIDIwMDAuOC4zMDAeFw0wMjA2MDUxMTE1MzJaFw0wMzA2MDUxMTE1MzJa
MEIxHzAdBgNVBAMTFlRoYXd0ZSBGcmVlbWFpbCBNZW1iZXIxHzAdBgkqhkiG9w0BCQEWEG5h
Z3l0QG90cGJhbmsuaHUwgZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBAMzA1PHsL3+xE06d
23p7BlCJJYSyi1vsfYeVmB4dsc/OSg/y4WxqOILMh+3wxQ35FNs23AjnYfRljhGNtoSm5jRe
ioE19dUKG1FCV0T1RMYTE8tXRzt9YzOAr2koWg/+Wqxt/0Qi9fl1PtgrYliS5cC0kBRND9Yb
aybBEoFNPrSZAgMBAAGjLTArMBsGA1UdEQQUMBKBEG5hZ3l0QG90cGJhbmsuaHUwDAYDVR0T
AQH/BAIwADANBgkqhkiG9w0BAQQFAAOBgQBJUxrLMZI2MLY9RnIXFM77knDXEdzyneSa04p6
egw5r6YSzHKnm2seObq5EkDk5vD6n0ZRZaZzbhMu+1QHIJ2v3FUMNqb37ZrROjzJqtLrcOHB
kVr5kNblco2VJUozzGJguLclckzTUsgXWAelq2EjN4TRoJVdwMp1Ld6YqOW3VzCCAzgwggKh
oAMCAQICEGZFcrfMdPXPY3ZFhNAukQEwDQYJKoZIhvcNAQEEBQAwgdExCzAJBgNVBAYTAlpB
MRUwEwYDVQQIEwxXZXN0ZXJuIENhcGUxEjAQBgNVBAcTCUNhcGUgVG93bjEaMBgGA1UEChMR
VGhhd3RlIENvbnN1bHRpbmcxKDAmBgNVBAsTH0NlcnRpZmljYXRpb24gU2VydmljZXMgRGl2
aXNpb24xJDAiBgNVBAMTG1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBDQTErMCkGCSqGSIb3
DQEJARYccGVyc29uYWwtZnJlZW1haWxAdGhhd3RlLmNvbTAeFw0wMDA4MzAwMDAwMDBaFw0w
NDA4MjcyMzU5NTlaMIGSMQswCQYDVQQGEwJaQTEVMBMGA1UECBMMV2VzdGVybiBDYXBlMRIw
EAYDVQQHEwlDYXBlIFRvd24xDzANBgNVBAoTBlRoYXd0ZTEdMBsGA1UECxMUQ2VydGlmaWNh
dGUgU2VydmljZXMxKDAmBgNVBAMTH1BlcnNvbmFsIEZyZWVtYWlsIFJTQSAyMDAwLjguMzAw
gZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBAN4zMqZjxwklRT7SbngnZ4HF2ogZgpcO40Qp
imM1Km1wPPrcrvfudG8wvDOQf/k0caCjbZjxw0+iZdsN+kvx1t1hpfmFzVWaNRqdknWoJ67Y
cvm6AvbXsJHeHOmr4BgDqHxDQlBRh4M88Dm0m1SKE4f/s5udSWYALQmJ7JRr6aFpAgMBAAGj
TjBMMCkGA1UdEQQiMCCkHjAcMRowGAYDVQQDExFQcml2YXRlTGFiZWwxLTI5NzASBgNVHRMB
Af8ECDAGAQH/AgEAMAsGA1UdDwQEAwIBBjANBgkqhkiG9w0BAQQFAAOBgQAxsUtHXfkBceX1
U2xdedY9mMAmE2KBIqcS+CKV6BtJtyd7BDm6/ObyJOuR+r3sDSo491BVqGz3Da1MG7wD9LXr
okefbKIMWI0xQgkRbLAaadErErJAXWr5edDqLiXdiuT82w0fnQLzWtvKPPZE6iZph39Ins6l
n+eE2MliYq0FxjGCAfUwggHxAgEBMIGaMIGSMQswCQYDVQQGEwJaQTEVMBMGA1UECBMMV2Vz
dGVybiBDYXBlMRIwEAYDVQQHEwlDYXBlIFRvd24xDzANBgNVBAoTBlRoYXd0ZTEdMBsGA1UE
CxMUQ2VydGlmaWNhdGUgU2VydmljZXMxKDAmBgNVBAMTH1BlcnNvbmFsIEZyZWVtYWlsIFJT
QSAyMDAwLjguMzACAwefrDAJBgUrDgMCGgUAoIGxMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0B
BwEwHAYJKoZIhvcNAQkFMQ8XDTAyMDgyMTE0MjYwNlowIwYJKoZIhvcNAQkEMRYEFMiFaaD+
i85N9S4O4E6gEUt44nXJMFIGCSqGSIb3DQEJDzFFMEMwCgYIKoZIhvcNAwcwDgYIKoZIhvcN
AwICAgCAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgFAMA0GCCqGSIb3DQMCAgEoMA0GCSqGSIb3
DQEBAQUABIGAjYsTPXgCoyaL49oERaLvRyhNDDTriEcZ6BIDUNX28SaMCsUbkH1j32NRGQjO
+LkeYAZcx03Cnvu5e0PZQENLIt3ChRXoTTjyjQLFKfM95u4DX6VFfxsd7DKVn8udgLidaPmn
6Y5faJ+Q/wy8RVA3uginvU8BI072soMbbU9KlTg=
--------------msD99E45FE60C268541AF7ECFE--

