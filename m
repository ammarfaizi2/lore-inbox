Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267741AbSLGKBo>; Sat, 7 Dec 2002 05:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267742AbSLGKBo>; Sat, 7 Dec 2002 05:01:44 -0500
Received: from proxy.firewall-by-call.de ([62.116.172.146]:38610 "EHLO
	ibis.city-map.de") by vger.kernel.org with ESMTP id <S267741AbSLGKBk>;
	Sat, 7 Dec 2002 05:01:40 -0500
Message-ID: <011901c29dd8$b0dd8700$7100a8c0@STEINKAMP>
From: "Henrik Steffen" <steffen@city-map.de>
To: <pgsql-general@postgresql.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Kernel BUG
Date: Sat, 7 Dec 2002 11:09:09 +0100
MIME-Version: 1.0
Content-Type: multipart/signed;
	micalg=SHA1;
	protocol="application/x-pkcs7-signature";
	boundary="----=_NextPart_000_0115_01C29DE1.11F27520"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0115_01C29DE1.11F27520
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hello all,

running postgres 7.3 on an redhat linux 2.4.19 I had
the following problems this morning. One of the database
tables was completely destroyed. Every access to this
certain table led to a whole shut-down of the database.

attention kernel-list: please cc me because I am not subscribed to the =
list

here the trace:

ksymoops 2.4.1 on i686 2.4.19.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19/ (default)
     -m /boot/System.map-2.4.19 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid =
lsmod file?
Dec  7 08:16:09 db2 kernel: kernel BUG at page_alloc.c:89!
Dec  7 08:16:09 db2 kernel: invalid operand: 0000
Dec  7 08:16:09 db2 kernel: CPU:    0
Dec  7 08:16:09 db2 kernel: EIP:    0010:[__free_pages_ok+33/608]    Not =
tainted
Dec  7 08:16:09 db2 kernel: EIP:    0010:[<c012a451>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Dec  7 08:16:09 db2 kernel: EFLAGS: 00010286
Dec  7 08:16:09 db2 kernel: eax: c121c39c   ebx: c13c69b0   ecx: =
f5e14ac0   edx: c12b2dec
Dec  7 08:16:09 db2 kernel: esi: 00000000   edi: f5cc35b0   ebp: =
000005de   esp: dc28ded4
Dec  7 08:16:09 db2 kernel: ds: 0018   es: 0018   ss: 0018
Dec  7 08:16:09 db2 kernel: Process postmaster (pid: 24608, =
stackpage=3Ddc28d000)
Dec  7 08:16:09 db2 kernel: Stack: c012484f 00000000 00000000 f6768c00 =
f7cc8200 0000001f 00000cca 00001000=20
Dec  7 08:16:09 db2 kernel:        c13c69b0 f5cc35b0 000005de c01243e5 =
dc28df5c c13c69b0 00000000 00001000=20
Dec  7 08:16:09 db2 kernel:        00001000 00000000 00000000 00000000 =
f5cc3500 d5456e40 dc28c000 00000000=20
Dec  7 08:16:09 db2 kernel: Call Trace:    [file_read_actor+143/208] =
[do_generic_file_read+549/1056] [generic_file_read+122/288] =
[file_read_actor+0/208] [sys_read+149/240]
Dec  7 08:16:09 db2 kernel: Call Trace:    [<c012484f>] [<c01243e5>] =
[<c012490a>] [<c01247c0>] [<c0130b75>]
Dec  7 08:16:09 db2 kernel:   [<c0117ecb>] [<c0109c6c>] [<c010878b>]
Dec  7 08:16:09 db2 kernel: Code: 0f 0b 59 00 d8 41 1f c0 8b 53 08 85 d2 =
74 08 0f 0b 5b 00 d8=20

>>EIP; c012a451 <__free_pages_ok+21/260>   <=3D=3D=3D=3D=3D
Trace; c012484f <file_read_actor+8f/d0>
Trace; c01243e5 <do_generic_file_read+225/420>
Trace; c012490a <generic_file_read+7a/120>
Trace; c01247c0 <file_read_actor+0/d0>
Trace; c0130b75 <sys_read+95/f0>
Trace; c0117ecb <do_softirq+4b/90>
Trace; c0109c6c <do_IRQ+9c/b0>
Trace; c010878b <system_call+33/38>
Code;  c012a451 <__free_pages_ok+21/260>
00000000 <_EIP>:
Code;  c012a451 <__free_pages_ok+21/260>   <=3D=3D=3D=3D=3D
   0:   0f 0b                     ud2a      <=3D=3D=3D=3D=3D
Code;  c012a453 <__free_pages_ok+23/260>
   2:   59                        pop    %ecx
Code;  c012a454 <__free_pages_ok+24/260>
   3:   00 d8                     add    %bl,%al
Code;  c012a456 <__free_pages_ok+26/260>
   5:   41                        inc    %ecx
Code;  c012a457 <__free_pages_ok+27/260>
   6:   1f                        pop    %ds
Code;  c012a458 <__free_pages_ok+28/260>
   7:   c0 8b 53 08 85 d2 74      rorb   $0x74,0xd2850853(%ebx)
Code;  c012a45f <__free_pages_ok+2f/260>
   e:   08 0f                     or     %cl,(%edi)
Code;  c012a461 <__free_pages_ok+31/260>
  10:   0b 5b 00                  or     0x0(%ebx),%ebx
Code;  c012a464 <__free_pages_ok+34/260>
  13:   d8 00                     fadds  (%eax)

Dec  7 08:21:08 db2 kernel:  kernel BUG at page_alloc.c:89!
Dec  7 08:21:08 db2 kernel: invalid operand: 0000
Dec  7 08:21:08 db2 kernel: CPU:    0
Dec  7 08:21:08 db2 kernel: EIP:    0010:[__free_pages_ok+33/608]    Not =
tainted
Dec  7 08:21:08 db2 kernel: EIP:    0010:[<c012a451>]    Not tainted
Dec  7 08:21:08 db2 kernel: EFLAGS: 00010286
Dec  7 08:21:08 db2 kernel: eax: 00000000   ebx: c13c69b0   ecx: =
f5e14ac0   edx: 00000000
Dec  7 08:21:08 db2 kernel: esi: 00000000   edi: f5cc35b0   ebp: =
000005de   esp: ef1d7ed4
Dec  7 08:21:08 db2 kernel: ds: 0018   es: 0018   ss: 0018
Dec  7 08:21:08 db2 kernel: Process postmaster (pid: 24634, =
stackpage=3Def1d7000)
Dec  7 08:21:08 db2 kernel: Stack: c012484f 00000000 00000000 f6768c00 =
00000001 0000001f 00000cca 00001000=20
Dec  7 08:21:08 db2 kernel:        c13c69b0 f5cc35b0 000005de c01243e5 =
ef1d7f5c c13c69b0 00000000 00001000=20
Dec  7 08:21:08 db2 kernel:        00001000 00000000 00000000 00000000 =
f5cc3500 cb5dd7c0 cb5dd7e0 00030002=20
Dec  7 08:21:08 db2 kernel: Call Trace:    [file_read_actor+143/208] =
[do_generic_file_read+549/1056] [generic_file_read+122/288] =
[file_read_actor+0/208] [sys_read+149/240]
Dec  7 08:21:08 db2 kernel: Call Trace:    [<c012484f>] [<c01243e5>] =
[<c012490a>] [<c01247c0>] [<c0130b75>]
Dec  7 08:21:08 db2 kernel:   [<c0109c38>] [<c0109c5c>] [<c010878b>]
Dec  7 08:21:08 db2 kernel: Code: 0f 0b 59 00 d8 41 1f c0 8b 53 08 85 d2 =
74 08 0f 0b 5b 00 d8=20

>>EIP; c012a451 <__free_pages_ok+21/260>   <=3D=3D=3D=3D=3D
Trace; c012484f <file_read_actor+8f/d0>
Trace; c01243e5 <do_generic_file_read+225/420>
Trace; c012490a <generic_file_read+7a/120>
Trace; c01247c0 <file_read_actor+0/d0>
Trace; c0130b75 <sys_read+95/f0>
Trace; c0109c38 <do_IRQ+68/b0>
Trace; c0109c5c <do_IRQ+8c/b0>
Trace; c010878b <system_call+33/38>
Code;  c012a451 <__free_pages_ok+21/260>
00000000 <_EIP>:
Code;  c012a451 <__free_pages_ok+21/260>   <=3D=3D=3D=3D=3D
   0:   0f 0b                     ud2a      <=3D=3D=3D=3D=3D
Code;  c012a453 <__free_pages_ok+23/260>
   2:   59                        pop    %ecx
Code;  c012a454 <__free_pages_ok+24/260>
   3:   00 d8                     add    %bl,%al
Code;  c012a456 <__free_pages_ok+26/260>
   5:   41                        inc    %ecx
Code;  c012a457 <__free_pages_ok+27/260>
   6:   1f                        pop    %ds
Code;  c012a458 <__free_pages_ok+28/260>
   7:   c0 8b 53 08 85 d2 74      rorb   $0x74,0xd2850853(%ebx)
Code;  c012a45f <__free_pages_ok+2f/260>
   e:   08 0f                     or     %cl,(%edi)
Code;  c012a461 <__free_pages_ok+31/260>
  10:   0b 5b 00                  or     0x0(%ebx),%ebx
Code;  c012a464 <__free_pages_ok+34/260>
  13:   d8 00                     fadds  (%eax)


2 warnings issued.  Results may not be reliable.


--

Mit freundlichem Gru=DF

Henrik Steffen
Gesch=E4ftsf=FChrer

top concepts Internetmarketing GmbH
Am Steinkamp 7 - D-21684 Stade - Germany
--------------------------------------------------------
http://www.topconcepts.com          Tel. +49 4141 991230
mail: steffen@topconcepts.com       Fax. +49 4141 991233
--------------------------------------------------------
24h-Support Hotline:  +49 1908 34697 (EUR 1.86/Min,topc)
--------------------------------------------------------
System-Partner gesucht: http://www.franchise.city-map.de
--------------------------------------------------------
Handelsregister: AG Stade HRB 5811 - UstId: DE 213645563
--------------------------------------------------------
Falls Ihr  eMail Programm das angeh=E4ngte digitale Zerti-
fikat nicht  unterst=FCtzt, k=F6nnen Sie es einfach ignorie-
ren. Ein eigenes digitales Zertifikat k=F6nnen Sie kosten-
los beantragen unter: http://www.trustcenter.de
--------------------------------------------------------

------=_NextPart_000_0115_01C29DE1.11F27520
Content-Type: application/x-pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIGdDCCAxAw
ggJ5oAMCAQICDwCNuAAAAAJNnNItK1EoETANBgkqhkiG9w0BAQQFADCBvDELMAkGA1UEBhMCREUx
EDAOBgNVBAgTB0hhbWJ1cmcxEDAOBgNVBAcTB0hhbWJ1cmcxOjA4BgNVBAoTMVRDIFRydXN0Q2Vu
dGVyIGZvciBTZWN1cml0eSBpbiBEYXRhIE5ldHdvcmtzIEdtYkgxIjAgBgNVBAsTGVRDIFRydXN0
Q2VudGVyIENsYXNzIDEgQ0ExKTAnBgkqhkiG9w0BCQEWGmNlcnRpZmljYXRlQHRydXN0Y2VudGVy
LmRlMB4XDTAyMTEyOTE0NDE0NFoXDTAzMTEyOTE0NDE0NFowSjELMAkGA1UEBhMCREUxFzAVBgNV
BAMTDkhlbnJpayBTdGVmZmVuMSIwIAYJKoZIhvcNAQkBFhNzdGVmZmVuQGNpdHktbWFwLmRlMFww
DQYJKoZIhvcNAQEBBQADSwAwSAJBAM64VnQWgxn5XVfoVKjOzSmu5LayRKX1GdTE7o23TOks9zq7
J36jw2kbsaY367P1xnghrrkuG9h6kKYA9CPzsE0CAwEAAaOByDCBxTAMBgNVHRMBAf8EAjAAMA4G
A1UdDwEB/wQEAwIF4DAzBglghkgBhvhCAQgEJhYkaHR0cDovL3d3dy50cnVzdGNlbnRlci5kZS9n
dWlkZWxpbmVzMBEGCWCGSAGG+EIBAQQEAwIFoDBdBglghkgBhvhCAQMEUBZOaHR0cHM6Ly93d3cu
dHJ1c3RjZW50ZXIuZGUvY2dpLWJpbi9jaGVjay1yZXYuY2dpLzhEQjgwMDAwMDAwMjREOUNEMjJE
MkI1MTI4MTE/MA0GCSqGSIb3DQEBBAUAA4GBABZMzjYmOivTczf/3n8qHheIUSOGS1xOHK/hlyW2
LMbV8hS1t+5fhoRGOfb6vY4qdH8YHQNjIRvMChIwNo9KhF1aoNIsmgRi9GIX/X56lqLeQqAsrF70
fkjjw8Z7MjTrR1I0PTht8nOey6lwHvRrSqanl0beIwPQWeAr7XCH6BbHMIIDXDCCAsWgAwIBAgIC
A+kwDQYJKoZIhvcNAQEEBQAwgbwxCzAJBgNVBAYTAkRFMRAwDgYDVQQIEwdIYW1idXJnMRAwDgYD
VQQHEwdIYW1idXJnMTowOAYDVQQKEzFUQyBUcnVzdENlbnRlciBmb3IgU2VjdXJpdHkgaW4gRGF0
YSBOZXR3b3JrcyBHbWJIMSIwIAYDVQQLExlUQyBUcnVzdENlbnRlciBDbGFzcyAxIENBMSkwJwYJ
KoZIhvcNAQkBFhpjZXJ0aWZpY2F0ZUB0cnVzdGNlbnRlci5kZTAeFw05ODAzMDkxMTU5NTlaFw0x
MTAxMDExMTU5NTlaMIG8MQswCQYDVQQGEwJERTEQMA4GA1UECBMHSGFtYnVyZzEQMA4GA1UEBxMH
SGFtYnVyZzE6MDgGA1UEChMxVEMgVHJ1c3RDZW50ZXIgZm9yIFNlY3VyaXR5IGluIERhdGEgTmV0
d29ya3MgR21iSDEiMCAGA1UECxMZVEMgVHJ1c3RDZW50ZXIgQ2xhc3MgMSBDQTEpMCcGCSqGSIb3
DQEJARYaY2VydGlmaWNhdGVAdHJ1c3RjZW50ZXIuZGUwgZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJ
AoGBALAp67R2s67Xtlu0Xue947GcSQRXW6Gr2X8TG/26YavY53HfLQCUXVFIfSPvdWKEkDwKH1kR
dC+OgKX9MAI9KVLNchpJIZy8y1KOSKFjlsgQhTBpV3RFwFqGxtU94GhXfTFqJI1Flz4xfmhmMm4k
bewyNslByvAxRMijYcoboDYfAgMBAAGjazBpMA8GA1UdEwEB/wQFMAMBAf8wDgYDVR0PAQH/BAQD
AgGGMDMGCWCGSAGG+EIBCAQmFiRodHRwOi8vd3d3LnRydXN0Y2VudGVyLmRlL2d1aWRlbGluZXMw
EQYJYIZIAYb4QgEBBAQDAgAHMA0GCSqGSIb3DQEBBAUAA4GBAE+ZWYXIZFaCxW892EYJLzxRwadw
WIGSEur01BYAll5yKOfWNl8anK8fwoMatAVVmaZYXDco8lce612/sdNFD3IcA9IAxyxV2v5fiXaL
4tR39U0JF6/EuqswK0+4HerZ/1nwUHRGul7qNrDrknsPWNoy4VK9IzcP9fMASq6wXt5uMYIB8zCC
Ae8CAQEwgdAwgbwxCzAJBgNVBAYTAkRFMRAwDgYDVQQIEwdIYW1idXJnMRAwDgYDVQQHEwdIYW1i
dXJnMTowOAYDVQQKEzFUQyBUcnVzdENlbnRlciBmb3IgU2VjdXJpdHkgaW4gRGF0YSBOZXR3b3Jr
cyBHbWJIMSIwIAYDVQQLExlUQyBUcnVzdENlbnRlciBDbGFzcyAxIENBMSkwJwYJKoZIhvcNAQkB
FhpjZXJ0aWZpY2F0ZUB0cnVzdGNlbnRlci5kZQIPAI24AAAAAk2c0i0rUSgRMAkGBSsOAwIaBQCg
gbowGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMDIxMjA3MTAwOTA5
WjAjBgkqhkiG9w0BCQQxFgQUOPqrBpJvBq6JTnjWcZliwX61278wWwYJKoZIhvcNAQkPMU4wTDAK
BggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYFKw4DAgcwDQYIKoZI
hvcNAwICASgwBwYFKw4DAh0wDQYJKoZIhvcNAQEBBQAEQHVA7yuspA2Nf0Icl3frtxfL14OXzj6N
XfiWncLJ2cf506/BJmeNM3QO6CURoWvwIMYHM5DkmWTPun+zhWxzX+cAAAAAAAA=

------=_NextPart_000_0115_01C29DE1.11F27520--

