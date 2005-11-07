Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965039AbVKGRcT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965039AbVKGRcT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 12:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965393AbVKGRcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 12:32:18 -0500
Received: from baldrick.bootc.net ([83.142.228.48]:17131 "EHLO
	baldrick.bootc.net") by vger.kernel.org with ESMTP id S965392AbVKGRcJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 12:32:09 -0500
Mime-Version: 1.0 (Apple Message framework v746.2)
To: linux-kernel@vger.kernel.org
Message-Id: <6397E994-0BC3-445F-BF2B-CD3D0ADB0E02@bootc.net>
Content-Type: multipart/signed; micalg=sha1; boundary=Apple-Mail-1-606182037; protocol="application/pkcs7-signature"
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: 2.6.14-mm1 libata pata_via
From: Chris Boot <bootc@bootc.net>
Date: Mon, 7 Nov 2005 17:32:00 +0000
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-1-606182037
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed

Hi all,

Since I've only got a DVD drive on good ol' PATA, I thought I'd try  
Alan's latest VIA PATA driver for libata, to see where I got. Well,  
the machine simply doesn't boot, preferring to get stuck after  
detecting the drive. I've tried with and without  
libata.atapi_enabled=1 and get the same result in both cases. Here's  
my log with some SysRq output that might be useful:

[4294671.089000] ACPI: PCI Interrupt Link [ALKA] BIOS reported IRQ  
11, using IRQ 20
[4294671.125000] ACPI: PCI Interrupt Link [ALKA] enabled at IRQ 20
[4294671.159000] ACPI: PCI Interrupt 0000:00:0f.0[B] -> Link [ALKA] - 
 > GSI 20 (level, low) -> IRQ 177
[4294671.196000] PCI: Via IRQ fixup for 0000:00:0f.0, from 11 to 1
[4294671.230000] sata_via 0000:00:0f.0: routed to hard irq line 1
[4294671.264000] ata3: SATA max UDMA/133 cmd 0xB800 ctl 0xBC02 bmdma  
0xC800 irq 177
[4294671.300000] ata4: SATA max UDMA/133 cmd 0xC000 ctl 0xC402 bmdma  
0xC808 irq 177
[4294671.687000] ata3: dev 0 ATA-7, max UDMA/133, 488397168 sectors:  
LBA48
[4294671.722000] ata3: dev 0 configured for UDMA/133
[4294671.754000] scsi2 : sata_via
[4294672.136000] ata4: dev 0 ATA-7, max UDMA/133, 488397168 sectors:  
LBA48
[4294672.172000] ata4: dev 0 configured for UDMA/133
[4294672.203000] scsi3 : sata_via
[4294672.232000]   Vendor: ATA       Model: ST3250823AS       Rev: 3.03
[4294672.267000]   Type:   Direct-Access                      ANSI  
SCSI revision: 05
[4294672.302000]   Vendor: ATA       Model: ST3250823AS       Rev: 3.03
[4294672.338000]   Type:   Direct-Access                      ANSI  
SCSI revision: 05
[4294672.373000] ACPI: PCI Interrupt 0000:00:0f.1[A] -> Link [ALKA] - 
 > GSI 20 (level, low) -> IRQ 177
[4294672.411000] PCI: Via IRQ fixup for 0000:00:0f.1, from 255 to 1
[4294672.446000] ata5: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma  
0xD000 irq 14
[4294672.785000] ata5: dev 0 ATAPI, max UDMA/33
[4295878.655000] SysRq : Show State
[4295878.655000]
[4295878.655000]                                                sibling
[4295878.655000]   task             PC      pid father child younger  
older
[4295878.655000] swapper       D C0374BC0     0     1      0      
2               (L-TLB)
[4295878.655000] c1921d30 0000007b 0000007b c0374bc0 c0117d2d  
00000060 00000286 00000036
[4295878.655000]        c1921d40 00325aa0 6fbe5080 00000000 78be6440  
000f41fb c18fea50 c18feb78
[4295878.655000]        c1921dc8 c1921d64 c1920000 c1921d84 c03285af  
00000000 c18fea50 c0114460
[4295878.655000] Call Trace:
[4295878.655000]  [<c0117d2d>] release_console_sem+0x1d/0xa0
[4295878.655000]  [<c03285af>] wait_for_completion+0x7f/0xd0
[4295878.655000]  [<c0114460>] default_wake_function+0x0/0x10
[4295878.655000]  [<c0215e09>] __delay+0x9/0x10
[4295878.655000]  [<c0114460>] default_wake_function+0x0/0x10
[4295878.655000]  [<c0298ecf>] ata_dev_identify+0xbf/0x560
[4295878.655000]  [<c0299463>] ata_bus_probe+0x33/0xc0
[4295878.655000]  [<c029d07a>] ata_device_add+0x1ca/0x200
[4295878.655000]  [<c029d7ae>] ata_pci_init_one+0x39e/0x3b0
[4295878.655000]  [<c02d2549>] pci_read+0x29/0x30
[4295878.655000]  [<c02a14d3>] via_init_one+0x123/0x290
[4295878.655000]  [<c021beea>] pci_call_probe+0xa/0x10
[4295878.655000]  [<c021bf3e>] __pci_device_probe+0x4e/0x60
[4295878.655000]  [<c021bf76>] pci_device_probe+0x26/0x60
[4295878.655000]  [<c027bed3>] driver_probe_device+0x33/0xc0
[4295878.655000]  [<c027c03a>] __driver_attach+0x5a/0x60
[4295878.655000]  [<c027b59a>] bus_for_each_dev+0x3a/0x60
[4295878.655000]  [<c027c056>] driver_attach+0x16/0x20
[4295878.655000]  [<c027bfe0>] __driver_attach+0x0/0x60
[4295878.655000]  [<c027ba4b>] bus_add_driver+0x7b/0xd0
[4295878.655000]  [<c027c44f>] driver_register+0x2f/0x40
[4295878.655000]  [<c021c1d5>] __pci_register_driver+0x65/0xa0
[4295878.655000]  [<c0117a27>] printk+0x17/0x20
[4295878.655000]  [<c03ca883>] do_initcalls+0x53/0xb0
[4295878.655000]  [<c03e5445>] netfilter_init+0x65/0x90
[4295878.655000]  [<c0100280>] init+0x0/0x170
[4295878.655000]  [<c0100280>] init+0x0/0x170
[4295878.655000]  [<c01002ba>] init+0x3a/0x170
[4295878.655000]  [<c0100f35>] kernel_thread_helper+0x5/0x10

I've got CONFIG_IDE=n and CONFIG_SCSI_PATA_VIA=y. ata1 and ata2 are  
two other Seagate HDDs on a sata_sil controller. I can provide a full  
dmesg and other details should they be required!

HTH,
Chris

-- 
Chris Boot
bootc@bootc.net
http://www.bootc.net/



--Apple-Mail-1-606182037
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
BgkqhkiG9w0BCQUxDxcNMDUxMTA3MTczMjAxWjAjBgkqhkiG9w0BCQQxFgQUPfKAqGNlEbP0izX/
zD8uJ3CMg+cweAYJKwYBBAGCNxAEMWswaTBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3Rl
IENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWls
IElzc3VpbmcgQ0ECAw4IwzB6BgsqhkiG9w0BCRACCzFroGkwYjELMAkGA1UEBhMCWkExJTAjBgNV
BAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25h
bCBGcmVlbWFpbCBJc3N1aW5nIENBAgMOCMMwDQYJKoZIhvcNAQEBBQAEggEAFazQh+nJNC3Ub8RG
8eiYlOsljw/+jtqTmBJFRme+lPFDl04kqIb3VXmDWqxQCnE+qDibARwFo5smQYCLCJR2+5/bSvWp
ado0v+GcfX7P7kVTF+9zrEv5KWvNUbCvAfAYCWTg4+eRnwKwAgApj00w135WHWuDgekV3xQioK51
+B0D+366QcCsveI+UDQgxA/QnywF8bRx4qpyIWztfOd73JqUc/hcbG+XWFsOttkVzDz6jF0xW0AP
bweRTUmQOXz8AyfwZncz/Zv1lfaH0XWs5lh8rOp4701G1vMsbYVtq96Q+OtlGPgKmu/oR05s3peK
a7nF4GCP6ykjQH701YfFNQAAAAAAAA==

--Apple-Mail-1-606182037--
