Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264153AbUFXJyE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264153AbUFXJyE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 05:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264134AbUFXJyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 05:54:04 -0400
Received: from kendy.up.ac.za ([137.215.101.101]:58256 "EHLO kendy.up.ac.za")
	by vger.kernel.org with ESMTP id S264153AbUFXJxv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 05:53:51 -0400
Message-ID: <40DAA4AA.5000102@cs.up.ac.za>
Date: Thu, 24 Jun 2004 11:53:46 +0200
From: Jaco Kroon <jkroon@cs.up.ac.za>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040622
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: NFS lockups+empty directories
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms050707090803010004090504"
X-Scan-Signature: 2c86631c336091203f602be4a4c98c29
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms050707090803010004090504
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello there

I'm having 2 problems with nfs atm, I'll first describe the problem of 
the mysterious deadlocks.

On the client that has deadlocked I see these (tcpdump host servername -n)
11:37:31.272353 IP 137.215.40.16.3750658894 > 137.215.98.25.2049: 140 
read [|nfs]
11:37:32.671933 IP 137.215.40.16.3717104462 > 137.215.98.25.2049: 140 
read [|nfs]
11:37:33.371732 IP 137.215.40.16.3733881678 > 137.215.98.25.2049: 140 
read [|nfs]

On the server I get lots and lots of these (tcpdump host clientname -n)
11:39:23.239369 IP 137.215.40.16.3733881678 > 137.215.98.25.2049: 140 
read [|nfs]
11:37:03.280950 IP 137.215.98.25.2049 > 137.215.40.16.3717104462: reply 
ok 1472 read [|nfs]
11:37:03.280965 IP 137.215.98.25 > 137.215.40.16: udp
11:37:03.280975 IP 137.215.98.25 > 137.215.40.16: udp
11:37:03.280986 IP 137.215.98.25 > 137.215.40.16: udp
11:37:03.280997 IP 137.215.98.25 > 137.215.40.16: udp
11:37:03.281008 IP 137.215.98.25 > 137.215.40.16: udp

The port numbers are *obviously* wrong, but I suspect this is a tcpdump 
problem.  What worries me is that it doesn't look like the packets from 
the server reaches the client.  Now unless there is someone playing 
around on the routers (which might well be the case) or the routers is 
just messed up, then this means that there is a problem in the 
networking code - unlikely since all other services are still 
functioning, or I'm doing something wrong.  My fstab line looks like:

phugeet.cs.up.ac.za:/home/ /home/phugeet        nfs     defaults,sync   0 0

Whilst my exports file contains:

/home 137.215.40.19(no_root_squash,rw,sync)

My question then is this - why can't tcpdump get the port numbers on 
those latter packets?  Then also, shouldn't the source port numbers for 
these also be 2049?  Once this starts happening I can't fix anything 
without rebooting - or I haven't figured out how to yet.  Also, I cannot 
umount the mount, not even with -f (k, correction, at least doing a 
umount -f causes all "deadlocked" processes to be shot down, after which 
a second umount -f actually umounts the mount).

Right, now for the disappearing directory entries:

(client):
oasis home # mount
/dev/rd/host0/target0/part1 on / type ext3 (rw,noatime)
none on /dev type devfs (rw)
none on /proc type proc (rw)
none on /sys type sysfs (rw)
none on /dev/pts type devpts (rw)
/dev/rd/host0/target0/part3 on /usr type reiserfs (rw,noatime)
/dev/rd/host0/target0/part5 on /tmp type reiserfs (rw,noatime)
/dev/rd/host0/target0/part6 on /var type reiserfs (rw,noatime)
/dev/rd/host0/target0/part7 on /home type reiserfs (rw,noatime)
none on /dev/shm type tmpfs (rw)
phugeet.cs.up.ac.za:/home/ on /home/phugeet type nfs 
(rw,sync,addr=137.215.98.25)
oasis home # ll /home/phugeet/courses
total 0

(server):
phugeet home # mount
/dev/hda2 on / type ext3 (rw,noatime)
none on /proc type proc (rw)
none on /sys type sysfs (rw)
none on /dev/pts type devpts (rw)
none on /dev/shm type tmpfs (rw)
none on /proc/bus/usb type usbfs (rw)
phugeet home # ls /home/courses
ACE101         CBD780         COS151         COS226  COS332  DCP780    
HONS2003  KVM780  RNW780         Studymaterial         index.html
ACM            CEN101         COS160         COS283  COS333  EPE121    
HONS2004  MIT853  RNW781         UPUV                  lib
AIP780         COS110         COS213         COS284  COS341  EPE210    
INY272    MScPhD  SEC780         VRS780                post
ALGON          COS130         COS214         COS301  COS343  GPG780    
INY326    PGT780  SEC781         WCJ                   results.php
Announcements  COS130-EPE111  COS221         COS314  COS344  GRF780    
IRA310    PIN780  SWA780-ERA780  ZZZ111                temp
BTI720         COS130SS       COS222-ERB210  COS324  COS444  HONS2002  
KMI780    PIN781  SWC780-ERD732  change_filenames.txt  visitors.php

The options are the same as above.

Any help, or any other pointers will be much appreciated thanks.

Jaco

-- 
#ifdef STUPIDLY_TRUST_BROKEN_PCMD_ENA_BIT
        2.4.0-test2 /usr/src/linux/drivers/ide/cmd640.c
===========================================
This message and attachments are subject to a disclaimer. Please refer to www.it.up.ac.za/documentation/governance/disclaimer/ for full details.
Hierdie boodskap en aanhangsels is aan 'n vrywaringsklousule onderhewig. Volledige besonderhede is by www.it.up.ac.za/documentation/governance/disclaimer/ beskikbaar.
===========================================


--------------ms050707090803010004090504
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIII7TCC
AtEwggI6oAMCAQICAwuV3TANBgkqhkiG9w0BAQQFADBiMQswCQYDVQQGEwJaQTElMCMGA1UE
ChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNv
bmFsIEZyZWVtYWlsIElzc3VpbmcgQ0EwHhcNMDQwMTI4MTMxNTM0WhcNMDUwMTI3MTMxNTM0
WjBEMR8wHQYDVQQDExZUaGF3dGUgRnJlZW1haWwgTWVtYmVyMSEwHwYJKoZIhvcNAQkBFhJq
a3Jvb25AY3MudXAuYWMuemEwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDGM68H
Bm8eLZzRqFlPks3sjEOAQrolKEESLKGNAL6Pu+KUMRQ9wC5feaXfg5wmVBe6VLhTY9pkiVJi
mTX1VrHdJgnvqkKfjQrPn66oAqUlytHCSB6s5SmIquw1Nu4rMK5D+/LMqV73iTEyP/2p9GbK
w9h3xmqn3HytZfqgK/Zh8SKhjRzAE+PT2aVSBL43RetHgn4CRKVacERTLYK2Gfv5jhljPuSE
6ppfVOq/Jm/tduG/xn92wWlIOL8oPq4dQcy5wYjg9nrImwM7tFlD22iY0IESSqKTe2EkhcUY
rpc+M3XZEU7bz+sSTG7MbXNfkfn+4G92KN7Z9hhex1QAxBfnAgMBAAGjLzAtMB0GA1UdEQQW
MBSBEmprcm9vbkBjcy51cC5hYy56YTAMBgNVHRMBAf8EAjAAMA0GCSqGSIb3DQEBBAUAA4GB
AKItHT03yxemitMQFThOBwjiQrPwKqF5lqskzUY467RLA+6EBki+6MtGnv6yhwrOaV7H4BE3
p7gpVXtQZBlmHfZnK2l5C56OSdahZ77ti7+qsft7t1z+DyUUWCuRxA5hy4xXKgqd9cwy6mEp
uU7muCasFm9FR6H5vQbkCHH1DmjqMIIC0TCCAjqgAwIBAgIDC5XdMA0GCSqGSIb3DQEBBAUA
MGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQu
MSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQTAeFw0wNDAx
MjgxMzE1MzRaFw0wNTAxMjcxMzE1MzRaMEQxHzAdBgNVBAMTFlRoYXd0ZSBGcmVlbWFpbCBN
ZW1iZXIxITAfBgkqhkiG9w0BCQEWEmprcm9vbkBjcy51cC5hYy56YTCCASIwDQYJKoZIhvcN
AQEBBQADggEPADCCAQoCggEBAMYzrwcGbx4tnNGoWU+SzeyMQ4BCuiUoQRIsoY0Avo+74pQx
FD3ALl95pd+DnCZUF7pUuFNj2mSJUmKZNfVWsd0mCe+qQp+NCs+frqgCpSXK0cJIHqzlKYiq
7DU27iswrkP78sypXveJMTI//an0ZsrD2HfGaqfcfK1l+qAr9mHxIqGNHMAT49PZpVIEvjdF
60eCfgJEpVpwRFMtgrYZ+/mOGWM+5ITqml9U6r8mb+124b/Gf3bBaUg4vyg+rh1BzLnBiOD2
esibAzu0WUPbaJjQgRJKopN7YSSFxRiulz4zddkRTtvP6xJMbsxtc1+R+f7gb3Yo3tn2GF7H
VADEF+cCAwEAAaMvMC0wHQYDVR0RBBYwFIESamtyb29uQGNzLnVwLmFjLnphMAwGA1UdEwEB
/wQCMAAwDQYJKoZIhvcNAQEEBQADgYEAoi0dPTfLF6aK0xAVOE4HCOJCs/AqoXmWqyTNRjjr
tEsD7oQGSL7oy0ae/rKHCs5pXsfgETenuClVe1BkGWYd9mcraXkLno5J1qFnvu2Lv6qx+3u3
XP4PJRRYK5HEDmHLjFcqCp31zDLqYSm5Tua4JqwWb0VHofm9BuQIcfUOaOowggM/MIICqKAD
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
IEZyZWVtYWlsIElzc3VpbmcgQ0ECAwuV3TAJBgUrDgMCGgUAoIIBpzAYBgkqhkiG9w0BCQMx
CwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0wNDA2MjQwOTUzNDZaMCMGCSqGSIb3DQEJ
BDEWBBR5/UfNJXKK1ZzbsIDLOaPapm3gdTBSBgkqhkiG9w0BCQ8xRTBDMAoGCCqGSIb3DQMH
MA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIB
KDB4BgkrBgEEAYI3EAQxazBpMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29u
c3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwg
SXNzdWluZyBDQQIDC5XdMHoGCyqGSIb3DQEJEAILMWugaTBiMQswCQYDVQQGEwJaQTElMCMG
A1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBl
cnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0ECAwuV3TANBgkqhkiG9w0BAQEFAASCAQASEd3M
pk3MBv0bePs2vRj5Qbd3glLq5UeONqYy+YuaUvm7dpJcH77enlFWjh8CaWxKydjyKIXOpymM
n3NuV6hTIk1FmybprrymRP8jKNEExMnxHEUpRzOcihWpQew2z05Ev04wQpNqZbtTfT/JAsL4
wXETO+gmu4b06qIG4jDgOOXPR7UyizwvEnOMTm/idBotBhSg3+Ba2dwP85Frwm9tME/WRY7v
LADYFhh4oGXxXzh40EFnX1EsmnBcV3rV+BNLPGycY2/Txw4zPNVK71WtppT0Z1SJOPlZc4Ec
We0idCGHRgtvuyY1It56t+PghSGORtD8FkIfXOFczg44QPNSAAAAAAAA
--------------ms050707090803010004090504--
