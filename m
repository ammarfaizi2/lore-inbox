Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965098AbVKHInB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965098AbVKHInB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 03:43:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932494AbVKHInA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 03:43:00 -0500
Received: from baldrick.bootc.net ([83.142.228.48]:55431 "EHLO
	baldrick.bootc.net") by vger.kernel.org with ESMTP id S932491AbVKHInA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 03:43:00 -0500
In-Reply-To: <1131419726.19575.5.camel@localhost.localdomain>
References: <6397E994-0BC3-445F-BF2B-CD3D0ADB0E02@bootc.net> <1131419726.19575.5.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: multipart/signed; micalg=sha1; boundary=Apple-Mail-1-660836476; protocol="application/pkcs7-signature"
Message-Id: <53BB7006-124E-4AE0-8A0B-AED3167D0E63@bootc.net>
Cc: linux-kernel@vger.kernel.org
From: Chris Boot <bootc@bootc.net>
Subject: Re: 2.6.14-mm1 libata pata_via
Date: Tue, 8 Nov 2005 08:42:55 +0000
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-1-660836476
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed


On 8 Nov 2005, at 3:15, Alan Cox wrote:

> On Llu, 2005-11-07 at 17:32 +0000, Chris Boot wrote:
>> Hi all,
>>
>> Since I've only got a DVD drive on good ol' PATA, I thought I'd try
>> Alan's latest VIA PATA driver for libata, to see where I got. Well,
>> the machine simply doesn't boot, preferring to get stuck after
>> detecting the drive. I've tried with and without
>> libata.atapi_enabled=1 and get the same result in both cases. Here's
>> my log with some SysRq output that might be useful:
>
> Thanks for giving it a try. Can you also give me an lspci -v for
> reference

Relevant parts of lspci:

0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400/KT600  
AGP] Host Bridge
         Subsystem: VIA Technologies, Inc. VT8377 [KT400/KT600 AGP]  
Host Bridge
         Flags: bus master, 66Mhz, medium devsel, latency 8
         Memory at e0000000 (32-bit, prefetchable) [size=64M]
         Capabilities: [80] AGP version 3.5
         Capabilities: [c0] Power Management version 2

0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8235 PCI Bridge  
(prog-if 00 [Normal decode])
         Flags: bus master, 66Mhz, medium devsel, latency 0
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
         Memory behind bridge: e4000000-e6ffffff
         Prefetchable memory behind bridge: d0000000-dfffffff
         Capabilities: [80] Power Management version 2

[...]

0000:00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420  
SATA RAID Controller (rev 80)
         Subsystem: VIA Technologies, Inc. VIA VT6420 SATA RAID  
Controller
         Flags: bus master, medium devsel, latency 32, IRQ 169
         I/O ports at b800 [size=8]
         I/O ports at bc00 [size=4]
         I/O ports at c000 [size=8]
         I/O ports at c400 [size=4]
         I/O ports at c800 [size=16]
         I/O ports at cc00 [size=256]
         Capabilities: [c0] Power Management version 2

0000:00:0f.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/ 
VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-if 8a  
[Master SecP PriP])
         Subsystem: VIA Technologies, Inc. VT82C586/B/VT82C686/A/B/ 
VT8233/A/C/VT8235 PIPC Bus Master IDE
         Flags: bus master, medium devsel, latency 32, IRQ 169
         I/O ports at d000 [size=16]
         Capabilities: [c0] Power Management version 2

[...]

>> [4294672.373000] ACPI: PCI Interrupt 0000:00:0f.1[A] -> Link [ALKA] -
>>> GSI 20 (level, low) -> IRQ 177
>> [4294672.411000] PCI: Via IRQ fixup for 0000:00:0f.1, from 255 to 1
>
> Thats suspicious in itself. I take it the VIA drivers/ide driver works
> fine and reports IRQ 1 however ?

[4294669.230000] Uniform Multi-Platform E-IDE driver Revision:  
7.00alpha2
[4294669.263000] ide: Assuming 33MHz system bus speed for PIO modes;  
override with idebus=xx
[4294669.298000] VP_IDE: IDE controller at PCI slot 0000:00:0f.1
[4294669.331000] ACPI: PCI Interrupt Link [ALKA] BIOS reported IRQ  
11, using IRQ 20
[4294669.366000] ACPI: PCI Interrupt Link [ALKA] enabled at IRQ 20
[4294669.399000] ACPI: PCI Interrupt 0000:00:0f.1[A] -> Link [ALKA] - 
 > GSI 20 (level, low) -> IRQ 169
[4294669.436000] PCI: Via IRQ fixup for 0000:00:0f.1, from 255 to 9
[4294669.469000] VP_IDE: chipset revision 6
[4294669.500000] VP_IDE: not 100% native mode: will probe irqs later
[4294669.534000] VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller  
on pci0000:00:0f.1
[4294669.570000]     ide0: BM-DMA at 0xd000-0xd007, BIOS settings:  
hda:DMA, hdb:pio
[4294669.606000]     ide1: BM-DMA at 0xd008-0xd00f, BIOS settings:  
hdc:pio, hdd:pio
[4294669.642000] Probing IDE interface ide0...
[4294669.688000] input: AT Translated Set 2 keyboard as /class/input/ 
input0
[4294669.725000] atkbd.c: Spurious ACK on isa0060/serio0. Some  
program, like XFree86, might be trying access hardware directly.
[4294669.944000] input: AT Translated Set 2 keyboard as /class/input/ 
input1
[4294670.490000] hda: PHILIPS PBDV1640P, ATAPI CD/DVD-ROM drive
[4294671.137000] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[4294671.171000] Probing IDE interface ide1...
[4294671.690000] Probing IDE interface ide1...
[4294672.210000] hda: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 2048kB  
Cache, UDMA(33)
[4294672.247000] Uniform CD-ROM driver Revision: 3.20

>> [4294672.446000] ata5: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma
>> 0xD000 irq 14
>

HTH,
Chris

-- 
Chris Boot
bootc@bootc.net
http://www.bootc.net/



--Apple-Mail-1-660836476
Content-Transfer-Encoding: base64
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Disposition: attachment;
	filename=smime.p7s

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIGEjCCAssw
ggI0oAMCAQICAw4IwzANBgkqhkiG9w0BAQQFADBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhh
d3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVt
YWlsIElzc3VpbmcgQ0EwHhcNMDUwMjE0MjEyNjMzWhcNMDYwMjE0MjEyNjMzWjBBMR8wHQYDVQQD
ExZUaGF3dGUgRnJlZW1haWwgTWVtYmVyMR4wHAYJKoZIhvcNAQkBFg9ib290Y0Bib290Yy5uZXQw
ggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC6aATCjyi9z5A42up8tmL1D0gc/TvBsCIJ
ehXpdQJ1gGC5d6MlKLpQIF8zVzOjwOkFO7hluPVVAzrSo5/jvcSCl2SYj0OMiBS3BZh7JBMb6Ld+
+I5zrKnQFA4OCtBfaDS4xpErhjCgxYo4uk0HCJyI9T/foELKVJba4iRdnmggI513ifG8eIV94y+Z
rSVgejMisnLOM9xg0LfWwJZmbnYcszvkGKmAWzzqGfZFig2AR8I/NnVqYwr42JDlFMNKsz0kNdeq
ED29yI8IGITfzk3Xc5eMfm2PPEs1drf6vfR38GBLYL8UkgAbtTBiRvte4jS+aA6kKyvN0gIDq2+S
r06HAgMBAAGjLDAqMBoGA1UdEQQTMBGBD2Jvb3RjQGJvb3RjLm5ldDAMBgNVHRMBAf8EAjAAMA0G
CSqGSIb3DQEBBAUAA4GBAID0mAm4oxd1eY6KoCmdoTGfkeaYBnP+vd00juiKXwlYfZ1/TPMCbIeD
KHINuQbIUVH3u+vga56aaiwj31EG6D/7O8GePQPDo4HSgbo6cfGM21ELowr2e/qUg1EyoWwhATak
QDYLSBEIdAsQJnUwV32LZA/PFYGu0S5i25u7d4FpMIIDPzCCAqigAwIBAgIBDTANBgkqhkiG9w0B
AQUFADCB0TELMAkGA1UEBhMCWkExFTATBgNVBAgTDFdlc3Rlcm4gQ2FwZTESMBAGA1UEBxMJQ2Fw
ZSBUb3duMRowGAYDVQQKExFUaGF3dGUgQ29uc3VsdGluZzEoMCYGA1UECxMfQ2VydGlmaWNhdGlv
biBTZXJ2aWNlcyBEaXZpc2lvbjEkMCIGA1UEAxMbVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIENB
MSswKQYJKoZIhvcNAQkBFhxwZXJzb25hbC1mcmVlbWFpbEB0aGF3dGUuY29tMB4XDTAzMDcxNzAw
MDAwMFoXDTEzMDcxNjIzNTk1OVowYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25z
dWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1
aW5nIENBMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDEpjxVc1X7TrnKmVoeaMB1BHCd3+n/
ox7svc31W/Iadr1/DDph8r9RzgHU5VAKMNcCY1osiRVwjt3J8CuFWqo/cVbLrzwLB+fxH5E2JCoT
zyvV84J3PQO+K/67GD4Hv0CAAmTXp6a7n2XRxSpUhQ9IBH+nttE8YQRAHmQZcmC3+wIDAQABo4GU
MIGRMBIGA1UdEwEB/wQIMAYBAf8CAQAwQwYDVR0fBDwwOjA4oDagNIYyaHR0cDovL2NybC50aGF3
dGUuY29tL1RoYXd0ZVBlcnNvbmFsRnJlZW1haWxDQS5jcmwwCwYDVR0PBAQDAgEGMCkGA1UdEQQi
MCCkHjAcMRowGAYDVQQDExFQcml2YXRlTGFiZWwyLTEzODANBgkqhkiG9w0BAQUFAAOBgQBIjNFQ
g+oLLswNo2asZw9/r6y+whehQ5aUnX9MIbj4Nh+qLZ82L8D0HFAgk3A8/a3hYWLD2ToZfoSxmRsA
xRoLgnSeJVCUYsfbJ3FXJY3dqZw5jowgT2Vfldr394fWxghOrvbqNOUQGls1TXfjViF4gtwhGTXe
JLHTHUb/XV9lTzGCAucwggLjAgEBMGkwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBD
b25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJ
c3N1aW5nIENBAgMOCMMwCQYFKw4DAhoFAKCCAVMwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAc
BgkqhkiG9w0BCQUxDxcNMDUxMTA4MDg0MjU1WjAjBgkqhkiG9w0BCQQxFgQUxqjG7QNcY8BODQlJ
MYP4ejjH/YkweAYJKwYBBAGCNxAEMWswaTBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3Rl
IENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWls
IElzc3VpbmcgQ0ECAw4IwzB6BgsqhkiG9w0BCRACCzFroGkwYjELMAkGA1UEBhMCWkExJTAjBgNV
BAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25h
bCBGcmVlbWFpbCBJc3N1aW5nIENBAgMOCMMwDQYJKoZIhvcNAQEBBQAEggEAoVZw6z41rxEy5J6g
XiyWxqVohADFIUv/+PQRMmE5Kotdg1yygXAKrArVKdbbQGUyzrqALnjdrvRJEsixv5FhvMjSaoPL
/XyaU0UUHb0WtG5tQa8+CEpz5OcptQEUS24vc4wVOHMswSXeuVoA291pHhfsM088/ohcCu1oCl+U
qSc1AcoQINRjff45/DIeaIylMRcCRdJ5rNJJmHyn6vYq1xk7LHEHxJP8bGmuX0ipLwojV0LLXdPA
BZxyEpGUhVtY/drqIspALKdGCxCJ67loMZZgqIQc6hSNuTOtNVqIzKi9EyIx/GRPTOl6kA42qpOj
2FTwS2Qh8jgl4CVnuRw5bQAAAAAAAA==

--Apple-Mail-1-660836476--
