Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265037AbUD3BKp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265037AbUD3BKp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 21:10:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265038AbUD3BKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 21:10:44 -0400
Received: from tokra.juniper.net ([207.17.137.104]:51729 "EHLO juniper.net")
	by vger.kernel.org with ESMTP id S265037AbUD3BKa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 21:10:30 -0400
Content-class: urn:content-classes:message
Subject: Ext3 kernel crash on 2.4.22
MIME-Version: 1.0
Date: Thu, 29 Apr 2004 18:10:09 -0700
Content-Type: multipart/signed;
	protocol="application/x-pkcs7-signature";
	micalg=SHA1;
	boundary="----=_NextPart_000_00A0_01C42E15.34FE79E0"
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Message-ID: <CF049D8CFCAF6A40A3F826BE5DA1924F17970E@exch06.corp.netscreen.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: Ext3 kernel crash on 2.4.22
Thread-Index: AcQuKIgL5G4M1lRXSua4VlNGwqlaWgAGOVAgAAAOxfAAAysLMA==
From: "Eric Moret" <emoret@juniper.net>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 30 Apr 2004 01:10:09.0998 (UTC) FILETIME=[E1DEB6E0:01C42E4F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_00A0_01C42E15.34FE79E0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

Please CC me as I only read lkml occasionally.

I have a crash similar to the one described in a previous post at
http://testing.lkml.org/slashdot.php?mid=326628 unfortunately I have not
seen a resolution on this issue... 

Hardware detail:
Dell PowerEdge 1550 PIII 1GHz, single CPU running SMP kernel
1Gb RAM
Adaptec aic7899 Ultra160 SCSI adapter 18Gb Hard drive SEAGATE ST318395LC

__
Eric


---- OOPS MESSAGE decoded with ksymoops

ksymoops 2.4.9 on i686 2.4.22-9P3idpSMP.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.22-9P3idpSMP/ (default)
     -m /boot/System.map-2.4.22-9P3idpSMP (specified)

kernel BUG at transaction.c:1416!] [ave: 0] invalid operand: 0000
CPU:    0Packets    Flows      Sessions   Peak       Peak Time
EIP:    0010:[<4017659d>]    Tainted: PF  2          04/28/2004 11:52:59
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202    4          2          2          04/27/2004 10:20:54
eax: 00000063   ebx: 4029c066   ecx: 47ad2000   edx: 7f6aff7c04 11:42:39
Warning (Oops_set_regs): garbage '11:42:39' at end of register line ignored
esi: 717636c0   edi: 41cb07c0   ebp: 47ad3bbc   esp: 47ad3b9404 11:52:58
Warning (Oops_set_regs): garbage '11:52:58' at end of register line ignored
ds: 0018   es: 0018   ss: 0018
Process dLogPurger (pid: 2871, stackpage=47ad3000)
Stack: 4029de80 4029c066 4029bea6 00000588 4029ff00 00000002 41c8f000
00000000
       41cb07c0 7fdd0ca0 47ad3bdc 4016f391 41cb07c0 7fdd0ca0 00000000
00000001
       7fdd0ca0 41c87000 47ad3bf4 40157a3a 7fdd0ca0 00000001 47ad2000
40174b60
Call Trace:    [<4016f391>] [<40157a3a>] [<40174b60>] [<40158cbb>]
[<4014ca2f>]
  [<4014ce3a>] [<40149be1>] [<40149cfa>] [<40160400>] [<4023ca4c>]
[<4023ce55>]
  [<4023d105>] [<4010b553>] [<402852c1>] [<4015f810>] [<4014a7c3>]
[<4014a9a3>]
  [<40107d2f>] [<4010961f>]
Code: 0f 0b 88 05 a6 be 29 40 0f b6 57 18 f6 c2 04 75 0d 8b 07 8b


>>EIP; 4017659d <journal_stop+5d/200>   <=====

>>ebx; 4029c066 <large_digits.1+ad06/2f900> ecx; 47ad2000 
>><_end+76d30ec/4050e0ec> esi; 717636c0 <_end+313647ac/4050e0ec> edi; 
>>41cb07c0 <_end+18b18ac/4050e0ec> ebp; 47ad3bbc <_end+76d4ca8/4050e0ec>

Trace; 4016f391 <ext3_dirty_inode+a1/140> Trace; 40157a3a
<__mark_inode_dirty+ba/c0> Trace; 40174b60 <ext3_follow_link+0/20> Trace;
40158cbb <update_atime+6b/70> Trace; 4014ca2f <link_path_walk+4ef/700>
Trace; 4014ce3a <path_lookup+3a/40> Trace; 40149be1 <open_exec+21/e0> Trace;
40149cfa <kernel_read+5a/70> Trace; 40160400 <load_elf_binary+bf0/ca0>
Trace; 4023ca4c <netif_rx+8c/1b0> Trace; 4023ce55 <netif_receive_skb+d5/1a0>
Trace; 4023d105 <net_rx_action+b5/170> Trace; 4010b553 <do_IRQ+e3/f0> Trace;
402852c1 <strnlen_user+31/4c> Trace; 4015f810 <load_elf_binary+0/ca0> Trace;
4014a7c3 <search_binary_handler+133/1d0> Trace; 4014a9a3 <do_execve+143/1d0>
Trace; 40107d2f <sys_execve+3f/70> Trace; 4010961f <system_call+33/38>

Code;  4017659d <journal_stop+5d/200>
00000000 <_EIP>:
Code;  4017659d <journal_stop+5d/200>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  4017659f <journal_stop+5f/200>
   2:   88 05 a6 be 29 40         mov    %al,0x4029bea6
Code;  401765a5 <journal_stop+65/200>
   8:   0f b6 57 18               movzbl 0x18(%edi),%edx
Code;  401765a9 <journal_stop+69/200>
   c:   f6 c2 04                  test   $0x4,%dl
Code;  401765ac <journal_stop+6c/200>
   f:   75 0d                     jne    1e <_EIP+0x1e> 401765bb
<journal_stop+7b/200>
Code;  401765ae <journal_stop+6e/200>
  11:   8b 07                     mov    (%edi),%eax
Code;  401765b0 <journal_stop+70/200>
  13:   8b 00                     mov    (%eax),%eax

dump: Dump: Rebooting in 5 seconds ...NMI Watchdog detected LOCKUP on CPU0,
eip 40284f86, registers:
CPU:    0
EIP:    0010:[<40284f86>]    Tainted: PF
EFLAGS: 00000012
eax: 0000e952   ebx: 000f1874   ecx: af4bf9df   edx: 00006151
esi: 40292a7f   edi: 4010a0f0   ebp: 47ad3a60   esp: 47ad3a5c
ds: 0018   es: 0018   ss: 0018
Process dLogPurger (pid: 2871, stackpage=47ad3000)
Stack: 00000017 47ad3a74 40228fad 000f1874 00000005 00000001 47ad3a90
40229a42
       40366a88 00000002 4038c100 00000000 47ad3b60 47ad3aac 40109f8b
40292a7f
       47ad3b60 00000000 47ad2000 00000000 47ad3b50 4010a14d 40292a7f
47ad3b60
Call Trace:    [<40228fad>] [<40229a42>] [<40109f8b>] [<4010a14d>]
[<4017659d>]
  [<401b17f1>] [<40109710>] [<4017659d>] [<4016f391>] [<40157a3a>]
[<40174b60>]
  [<40158cbb>] [<4014ca2f>] [<4014ce3a>] [<40149be1>] [<40149cfa>]
[<40160400>]
  [<4023ca4c>] [<4023ce55>] [<4023d105>] [<4010b553>] [<402852c1>]
[<4015f810>]
  [<4014a7c3>] [<4014a9a3>] [<40107d2f>] [<4010961f>]
Code: 39 d8 72 f6 5b 5d c3 8d 76 00 55 89 e5 8b 45 08 eb 08 90 8d


>>EIP; 40284f86 <__rdtsc_delay+16/20>   <=====

>>esi; 40292a7f <large_digits.1+171f/2f900> edi; 4010a0f0 
>><do_invalid_op+0/70> ebp; 47ad3a60 <_end+76d4b4c/4050e0ec> esp; 
>>47ad3a5c <_end+76d4b48/4050e0ec>

Trace; 40228fad <dump_resume_system+cd/e0> Trace; 40229a42
<dump_execute+82/1f0> Trace; 40109f8b <die+9b/a0> Trace; 4010a14d
<do_invalid_op+5d/70> Trace; 4017659d <journal_stop+5d/200> Trace; 401b17f1
<serial_console_write+121/220> Trace; 40109710 <error_code+34/3c> Trace;
4017659d <journal_stop+5d/200> Trace; 4016f391 <ext3_dirty_inode+a1/140>
Trace; 40157a3a <__mark_inode_dirty+ba/c0> Trace; 40174b60
<ext3_follow_link+0/20> Trace; 40158cbb <update_atime+6b/70> Trace; 4014ca2f
<link_path_walk+4ef/700> Trace; 4014ce3a <path_lookup+3a/40> Trace; 40149be1
<open_exec+21/e0> Trace; 40149cfa <kernel_read+5a/70> Trace; 40160400
<load_elf_binary+bf0/ca0> Trace; 4023ca4c <netif_rx+8c/1b0> Trace; 4023ce55
<netif_receive_skb+d5/1a0> Trace; 4023d105 <net_rx_action+b5/170> Trace;
4010b553 <do_IRQ+e3/f0> Trace; 402852c1 <strnlen_user+31/4c> Trace; 4015f810
<load_elf_binary+0/ca0> Trace; 4014a7c3 <search_binary_handler+133/1d0>
Trace; 4014a9a3 <do_execve+143/1d0> Trace; 40107d2f <sys_execve+3f/70>
Trace; 4010961f <system_call+33/38>

Code;  40284f86 <__rdtsc_delay+16/20>
00000000 <_EIP>:
Code;  40284f86 <__rdtsc_delay+16/20>   <=====
   0:   39 d8                     cmp    %ebx,%eax   <=====
Code;  40284f88 <__rdtsc_delay+18/20>
   2:   72 f6                     jb     fffffffa <_EIP+0xfffffffa> 40284f80
<__rdtsc_delay+10/20>
Code;  40284f8a <__rdtsc_delay+1a/20>
   4:   5b                        pop    %ebx
Code;  40284f8b <__rdtsc_delay+1b/20>
   5:   5d                        pop    %ebp
Code;  40284f8c <__rdtsc_delay+1c/20>
   6:   c3                        ret
Code;  40284f8d <__rdtsc_delay+1d/20>
   7:   8d 76 00                  lea    0x0(%esi),%esi
Code;  40284f90 <__loop_delay+0/30>
   a:   55                        push   %ebp
Code;  40284f91 <__loop_delay+1/30>
   b:   89 e5                     mov    %esp,%ebp
Code;  40284f93 <__loop_delay+3/30>
   d:   8b 45 08                  mov    0x8(%ebp),%eax
Code;  40284f96 <__loop_delay+6/30>
  10:   eb 08                     jmp    1a <_EIP+0x1a> 40284fa0
<__loop_delay+10/30>
Code;  40284f98 <__loop_delay+8/30>
  12:   90                        nop
Code;  40284f99 <__loop_delay+9/30>
  13:   8d 00                     lea    (%eax),%eax


2 warnings issued.  Results may not be reliable.

------=_NextPart_000_00A0_01C42E15.34FE79E0
Content-Type: application/x-pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIKCDCCAy0w
ggKWoAMCAQICAQAwDQYJKoZIhvcNAQEEBQAwgdExCzAJBgNVBAYTAlpBMRUwEwYDVQQIEwxXZXN0
ZXJuIENhcGUxEjAQBgNVBAcTCUNhcGUgVG93bjEaMBgGA1UEChMRVGhhd3RlIENvbnN1bHRpbmcx
KDAmBgNVBAsTH0NlcnRpZmljYXRpb24gU2VydmljZXMgRGl2aXNpb24xJDAiBgNVBAMTG1RoYXd0
ZSBQZXJzb25hbCBGcmVlbWFpbCBDQTErMCkGCSqGSIb3DQEJARYccGVyc29uYWwtZnJlZW1haWxA
dGhhd3RlLmNvbTAeFw05NjAxMDEwMDAwMDBaFw0yMDEyMzEyMzU5NTlaMIHRMQswCQYDVQQGEwJa
QTEVMBMGA1UECBMMV2VzdGVybiBDYXBlMRIwEAYDVQQHEwlDYXBlIFRvd24xGjAYBgNVBAoTEVRo
YXd0ZSBDb25zdWx0aW5nMSgwJgYDVQQLEx9DZXJ0aWZpY2F0aW9uIFNlcnZpY2VzIERpdmlzaW9u
MSQwIgYDVQQDExtUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgQ0ExKzApBgkqhkiG9w0BCQEWHHBl
cnNvbmFsLWZyZWVtYWlsQHRoYXd0ZS5jb20wgZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBANRp
19SwlGRbcelH2AxRtupykbCEXn0tDY97Et+FJXUodDpCLGMnn5V7S+9+GYcdhuqj3bnOlmQawhRu
RKx85o/oTQ9xH0A4pgCjh3j2+ZSGXq3qwF5269kUo11uenwMpUtVfwYZKX+emibVars4JAhqmMex
2qOYkf152+VaxBy5AgMBAAGjEzARMA8GA1UdEwEB/wQFMAMBAf8wDQYJKoZIhvcNAQEEBQADgYEA
x+ySfk749ZalZ2IqpPBNEWDQb41gWGGsJrtSNVwIzzD7qEqWih9iQiOMFw/0umScF6xHKd+dmF7S
bGBxXKKs3Hnj524ARx+1DSjoAp3kmv0T9KbZfLH43F8jJgmRgHPQFBveQ6mDJfLmnC8Vyv6mq4oH
dYsM3VGEa+T40c53ooEwggM/MIICqKADAgECAgENMA0GCSqGSIb3DQEBBQUAMIHRMQswCQYDVQQG
EwJaQTEVMBMGA1UECBMMV2VzdGVybiBDYXBlMRIwEAYDVQQHEwlDYXBlIFRvd24xGjAYBgNVBAoT
EVRoYXd0ZSBDb25zdWx0aW5nMSgwJgYDVQQLEx9DZXJ0aWZpY2F0aW9uIFNlcnZpY2VzIERpdmlz
aW9uMSQwIgYDVQQDExtUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgQ0ExKzApBgkqhkiG9w0BCQEW
HHBlcnNvbmFsLWZyZWVtYWlsQHRoYXd0ZS5jb20wHhcNMDMwNzE3MDAwMDAwWhcNMTMwNzE2MjM1
OTU5WjBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRk
LjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0EwgZ8wDQYJKoZI
hvcNAQEBBQADgY0AMIGJAoGBAMSmPFVzVftOucqZWh5owHUEcJ3f6f+jHuy9zfVb8hp2vX8MOmHy
v1HOAdTlUAow1wJjWiyJFXCO3cnwK4Vaqj9xVsuvPAsH5/EfkTYkKhPPK9Xzgnc9A74r/rsYPge/
QIACZNenprufZdHFKlSFD0gEf6e20TxhBEAeZBlyYLf7AgMBAAGjgZQwgZEwEgYDVR0TAQH/BAgw
BgEB/wIBADBDBgNVHR8EPDA6MDigNqA0hjJodHRwOi8vY3JsLnRoYXd0ZS5jb20vVGhhd3RlUGVy
c29uYWxGcmVlbWFpbENBLmNybDALBgNVHQ8EBAMCAQYwKQYDVR0RBCIwIKQeMBwxGjAYBgNVBAMT
EVByaXZhdGVMYWJlbDItMTM4MA0GCSqGSIb3DQEBBQUAA4GBAEiM0VCD6gsuzA2jZqxnD3+vrL7C
F6FDlpSdf0whuPg2H6otnzYvwPQcUCCTcDz9reFhYsPZOhl+hLGZGwDFGguCdJ4lUJRix9sncVcl
jd2pnDmOjCBPZV+V2vf3h9bGCE6u9uo05RAaWzVNd+NWIXiC3CEZNd4ksdMdRv9dX2VPMIIDkDCC
AvmgAwIBAgIDC9lrMA0GCSqGSIb3DQEBBAUAMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3
dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1h
aWwgSXNzdWluZyBDQTAeFw0wNDAzMDUxNTQ2MzhaFw0wNTAzMDUxNTQ2MzhaMIIBETEOMAwGA1UE
BBMFTW9yZXQxDTALBgNVBCoTBEVyaWMxEzARBgNVBAMTCkVyaWMgTW9yZXQxIjAgBgkqhkiG9w0B
CQEWE2VyaWMubW9yZXRAZXBpdGEuZnIxHzAdBgkqhkiG9w0BCQEWEG1vcmV0X2VAZXBpdGEuZnIx
IzAhBgkqhkiG9w0BCQEWFEVNb3JldEBuZXRzY3JlZW4uY29tMSMwIQYJKoZIhvcNAQkBFhRlbW9y
ZXRAb25lc2VjdXJlLmNvbTEnMCUGCSqGSIb3DQEJARYYZXJpYy5tb3JldEBvbmVzZWN1cmUuY29t
MSMwIQYJKoZIhvcNAQkBFhRlcmljX21vcmV0QHlhaG9vLmNvbTCBnzANBgkqhkiG9w0BAQEFAAOB
jQAwgYkCgYEAw41hTPx+tnBF8w8bLhd5FYDOAEl7yrz0XqZzpHsmrBhNHtzZi+isgosWQHASxnrE
BcJEaQ0DYHDFXPrxE4eYB6KK6qZLmN6U7RoeVjXmfZ3y1xx/Ei3ymq6vAimvXomPzi3VzvGa4Bq6
c7e993SCKD4iDpPGdipkKmHUrul5zGcCAwEAAaOBojCBnzCBjgYDVR0RBIGGMIGDgRNlcmljLm1v
cmV0QGVwaXRhLmZygRBtb3JldF9lQGVwaXRhLmZygRRFTW9yZXRAbmV0c2NyZWVuLmNvbYEUZW1v
cmV0QG9uZXNlY3VyZS5jb22BGGVyaWMubW9yZXRAb25lc2VjdXJlLmNvbYEUZXJpY19tb3JldEB5
YWhvby5jb20wDAYDVR0TAQH/BAIwADANBgkqhkiG9w0BAQQFAAOBgQCEIGlvf/Hx514hc5ObRyG5
lAFOpfTWSIfmEIyrhZyirP9Y3rFUbiCvKX1JueaW0D1vKMSA7U31CKwagOpA2afrxTsvxBLTseZM
/UbPlni8WJMTotFzZLSYX0GrmKOjvZE6gjD9Io3dITn7QbRS+g7TulLM/2U/YH/PJFWq8WeDKDGC
As8wggLLAgEBMGkwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQ
dHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAgML
2WswCQYFKw4DAhoFAKCCAbwwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUx
DxcNMDQwNDMwMDExMDA5WjAjBgkqhkiG9w0BCQQxFgQU9FNvPkW513ssIbZ97N0CDHLbWt8wZwYJ
KoZIhvcNAQkPMVowWDAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAw
BwYFKw4DAgcwDQYIKoZIhvcNAwICASgwBwYFKw4DAhowCgYIKoZIhvcNAgUweAYJKwYBBAGCNxAE
MWswaTBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRk
LjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0ECAwvZazB6Bgsq
hkiG9w0BCRACCzFroGkwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5n
IChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENB
AgML2WswDQYJKoZIhvcNAQEBBQAEgYAebHbl378FyAJ/JSEYRUbuvM5sMTms0B5PmygQN9Jf9yRA
VKJ35JPRJV/69x+hyiChWT9khU/pTA2BwLsuti3dizSMl9bp7RDGYs+RvHUJ26iYenJ7iLZ53Up2
yexQlH9AhDWM/nc7K2KNq0W8vA/GHxBvFDZZC2PoHGKszSYmRwAAAAAAAA==

------=_NextPart_000_00A0_01C42E15.34FE79E0--
