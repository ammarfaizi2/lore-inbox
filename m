Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932503AbVLONrJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932503AbVLONrJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 08:47:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932347AbVLONrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 08:47:09 -0500
Received: from razor.csbnet.se ([193.11.251.99]:21407 "EHLO razor.csbnet.se")
	by vger.kernel.org with ESMTP id S932503AbVLONrH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 08:47:07 -0500
Message-ID: <43A173C6.5040405@kjellander.com>
Date: Thu, 15 Dec 2005 14:46:46 +0100
From: Carl-Johan Kjellander <carljohan@kjellander.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Oops on bootup, 2.6.14-1.1644_FC4smp scsi_mod e1000 root over NFSv3
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms060004000809030803060407"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms060004000809030803060407
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

We are getting a repeatable Oops on boot up on an ASUS P5ND2-SLI board.
It only happens intermittently but often enough to be a serious problem.

The machines boot with root over NFS, but there is a SATA drive installed
for some logs. It only happens during boot, never later.

Here is Oops number 1:

*********************

Unable to handle kernel NULL pointer dereferenceACPI: PCI Interrupt Link [APSJ] enabled at IRQ 22
  printing eip:
*pde = 00426001
Oops: 0000 [#1]
SMP
Modules linked in: sata_nv libata scsi_mod e1000 nfs lockd nfs_acl sunrpc
CPU:    0
EIP:    0060:[<e09528e6>]    Not tainted VLI
EFLAGS: 00010286   (2.6.14-1.1644_FC4smp)
EIP is at scsi_run_queue+0x10/0xaf [scsi_mod]
eax: 00000000   ebx: dd98007c   ecx: dffef880   edx: 00000001
esi: ddc99e00   edi: 00000246   ebp: dd9071fc   esp: c042af14
ds: 007b   es: 007b   ss: 0068
Process ksoftirqd/0 (pid: 3, threadinfo=c042a000 task=dfc41ab0)
Stack: dd9071fc dd98007c ddc99e00 00000246 dd9071fc e0952a7d ddc99e00 00000000
        00000000 dd98007c e0952e88 00000001 e088260b dcd3a570 c15e3380 dcd3a570
        00000000 00000000 00040000 00000024 dd9071fc 00000000 00000000 00000292
Call Trace:
  [<e0952a7d>] scsi_end_request+0x83/0xb0 [scsi_mod]
  [<e0952e88>] scsi_io_completion+0x29e/0x4d2 [scsi_mod]
  [<e088260b>] e1000_clean_rx_irq+0x95/0x4f1 [e1000]
  [<e094dcb2>] scsi_finish_command+0x82/0xb5 [scsi_mod]
  [<e094db97>] scsi_softirq+0xc0/0x133 [scsi_mod]
  [<c02bdf4e>] net_rx_action+0xb7/0x1bb
  [<c01258c2>] __do_softirq+0x72/0xdc
  [<c0105c43>] do_softirq+0x4b/0x4f
  =======================
  [<c0125ec2>] ksoftirqd+0x9c/0xe8
  [<c0125e26>] ksoftirqd+0x0/0xe8
  [<c0133d89>] kthread+0x93/0x97
  [<c0133cf6>] kthread+0x0/0x97
  [<c0101d5d>] kernel_thread_helper+0x5/0xb
Code: c5 8f df 8b 14 24 8b 42 44 e8 37 b6 9c df 89 44 24 04 89 d8 e8 2e b6 ff ff eb b1 55 57 56 53 83 ec 04 89 04 24 8b 80 10 01 00 00 <8b> 38 80 b8 85 01 00 00 00 0f 88 86 00 00 00 8b 47 44 e8 03 b6
  <0>Kernel panic - not syncing: Fatal exception in interrupt
ata3: no device found (phy stat 00000000)
scsi2 : sata_nv
  [<c0120358>] panic+0x45/0x1c4
  [<c0104caf>] die+0x17b/0x185
  [<c031ec40>] do_page_fault+0x0/0x700
  [<c031ee49>] do_page_fault+0x209/0x700
  [<c031ec40>] do_page_fault+0x0/0x700
  [<c010457f>] error_code+0x4f/0x54
  [<e09528e6>] scsi_run_queue+0x10/0xaf [scsi_mod]
  [<e0952a7d>] scsi_end_request+0x83/0xb0 [scsi_mod]
  [<e0952e88>] scsi_io_completion+0x29e/0x4d2 [scsi_mod]
  [<e088260b>] e1000_clean_rx_irq+0x95/0x4f1 [e1000]
  [<e094dcb2>] scsi_finish_command+0x82/0xb5 [scsi_mod]
  [<e094db97>] scsi_softirq+0xc0/0x133 [scsi_mod]
  [<c02bdf4e>] net_rx_action+0xb7/0x1bb
  [<c01258c2>] __do_softirq+0x72/0xdc
  [<c0105c43>] do_softirq+0x4b/0x4f
  =======================
  [<c0125ec2>] ksoftirqd+0x9c/0xe8
  [<c0125e26>] ksoftirqd+0x0/0xe8
  [<c0133d89>] kthread+0x93/0x97
  [<c0133cf6>] kthread+0x0/0x97
  [<c0101d5d>] kernel_thread_helper+0x5/0xb

And here is Oops number 2:

*********************

Unable to handle kernel NULL pointer dereference at virtual address 00000000
  printing eip:
*pde = 00426001
Oops: 0000 [#1]
SMP
Modules linked in: sata_nv libata scsi_mod e1000 nfs lockd nfs_acl sunrpc
CPU:    0
EIP:    0060:[<e09528e6>]    Not tainted VLI
EFLAGS: 00010286   (2.6.14-1.1644_FC4smp)
EIP is at scsi_run_queue+0x10/0xaf [scsi_mod]
eax: 00000000   ebx: dd9acb1c   ecx: dffef880   edx: 00000001
esi: dd50fc80   edi: 00000246   ebp: dd49a3b8   esp: c042af14
ds: 007b   es: 007b   ss: 0068
Process ksoftirqd/0 (pid: 3, threadinfo=c042a000 task=dfc41ab0)
Stack: dd49a3b8 dd9acb1c dd50fc80 00000246 dd49a3b8 e0952a7d dd50fc80 00000000
        00000000 dd9acb1c e0952e88 00000001 e088260b c04ac408 ded6b380 c1407fe0
        00000000 00000000 00040000 00000024 dd49a3b8 00000000 00000000 00000292
Call Trace:
  [<e0952a7d>] scsi_end_request+0x83/0xb0 [scsi_mod]
  [<e0952e88>] scsi_io_completion+0x29e/0x4d2 [scsi_mod]
  [<e088260b>] e1000_clean_rx_irq+0x95/0x4f1 [e1000]
  [<e094dcb2>] scsi_finish_command+0x82/0xb5 [scsi_mod]
  [<e094db97>] scsi_softirq+0xc0/0x133 [scsi_mod]
  [<c02bdf4e>] net_rx_action+0xb7/0x1bb
  [<c01258c2>] __do_softirq+0x72/0xdc
  [<c0105c43>] do_softirq+0x4b/0x4f
  =======================
  [<c0125ec2>] ksoftirqd+0x9c/0xe8
  [<c0125e26>] ksoftirqd+0x0/0xe8
  [<c0133d89>] kthread+0x93/0x97
  [<c0133cf6>] kthread+0x0/0x97
  [<c0101d5d>] kernel_thread_helper+0x5/0xb
Code: c5 8f df 8b 14 24 8b 42 44 e8 37 b6 9c df 89 44 24 04 89 d8 e8 2e b6 ff ff eb b1 55 57 56 53 83 ec 04 89 04 24 8b 80 10 01 00 00 <8b> 38 80 b8 85 01 00 00 00 0f 88 86 00 00 00 8b 47 44 e8 03 b6
  <0>Kernel panic - not syncing: Fatal exception in interrupt
  [<c0120358>] panic+0x45/0x1c4
  [<c0104caf>] die+0x17b/0x185
  [<c031ec40>] do_page_fault+0x0/0x700
  [<c031ee49>] do_page_fault+0x209/0x700
  [<c031ec40>] do_page_fault+0x0/0x700
  [<c010457f>] error_code+0x4f/0x54
  [<e09528e6>] scsi_run_queue+0x10/0xaf [scsi_mod]
  [<e0952a7d>] scsi_end_request+0x83/0xb0 [scsi_mod]
  [<e0952e88>] scsi_io_completion+0x29e/0x4d2 [scsi_mod]
  [<e088260b>] e1000_clean_rx_irq+0x95/0x4f1 [e1000]
  [<e094dcb2>] scsi_finish_command+0x82/0xb5 [scsi_mod]
  [<e094db97>] scsi_softirq+0xc0/0x133 [scsi_mod]
  [<c02bdf4e>] net_rx_action+0xb7/0x1bb
  [<c01258c2>] __do_softirq+0x72/0xdc
  [<c0105c43>] do_softirq+0x4b/0x4f
  =======================
  [<c0125ec2>] ksoftirqd+0x9c/0xe8
  [<c0125e26>] ksoftirqd+0x0/0xe8
  [<c0133d89>] kthread+0x93/0x97
  [<c0133cf6>] kthread+0x0/0x97
  [<c0101d5d>] kernel_thread_helper+0x5/0xb


Both Oopses are at the same spot with scsi_mod and e1000 being the culprits.

Hardware:
ASUS P5ND2-SLI
P4 630+
Double Intel e1000 on motherboard
SATA Disk (only for some logs, not booted from)
XFX NVidia GeForce 6800XT (driver not loaded so not tainted)

Kernel:
2.6.14-1.1644_FC4smp standard Fedora Core 4 kernel with a custom initrd
                      to be able to boot off network.

It might be connected to when sata_nv looking for drives, but I'm not
sure.

Has anybody seen this before? Is there a patch? Workaround?

Please CC me as I'm not on the list.

/Carl-Johan Kjellander
-- 
begin 644 carljohan_at_kjellander_dot_com.gif
Y1TE&.#=A(0`F`(```````/___RP`````(0`F```"@XR/!\N<#U.;+MI`<[U(>\!UGQ9BGT%>'D2I
Y*=NX,2@OUF2&<827ILW;^822C>\7!!Z1,!K'B5(6H<SH-"E*TJ3%*/>QI6:7"A>Y?):D2^*U@NCV
R<MOQ=]V(B6>LZYD-_T1U<@3W]A4(^$-W4]A#V")W6#.R"$;IR'@).46BN7$9>5D``#L`

--------------ms060004000809030803060407
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIJVzCC
AwYwggJvoAMCAQICAw+5YTANBgkqhkiG9w0BAQQFADBiMQswCQYDVQQGEwJaQTElMCMGA1UE
ChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNv
bmFsIEZyZWVtYWlsIElzc3VpbmcgQ0EwHhcNMDUxMDI0MDkwNTA3WhcNMDYxMDI0MDkwNTA3
WjBzMRMwEQYDVQQEEwpLamVsbGFuZGVyMRMwEQYDVQQqEwpDYXJsIEpvaGFuMR4wHAYDVQQD
ExVDYXJsIEpvaGFuIEtqZWxsYW5kZXIxJzAlBgkqhkiG9w0BCQEWGGNhcmxqb2hhbkBramVs
bGFuZGVyLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALpwSrmFDp1dat5t
faOn1lGIHmMGBWEy1+C2Ew6pvqcck+W5OxX4FouskDI5AbQaBqL+DNzJ2CbIDv9Xj3fi0KLR
hgyN/bBEg+jclFiJ/jukvXo38BH+Qx/0tNenzIbl9JeSjZYa0NhLlV+YHUMUkTldhSzuzmCY
WjIIZxK2LeRob2SnjAmNZ0SbZGrQ/sZ1Hi+NAQFkv+At46n/I79isj/6O9XQyFWtcLK3/DLK
M12rdE9n/DOqp0/mdzFszm+ymCIgB0FUcYNgrsP4qhsMtw+4tB7w/FVYp4nRnIFa1P4kXkwE
98ihWFRj/ZEbE4UvXy5RO0ZaYD2xdC/MFwPuDIMCAwEAAaM1MDMwIwYDVR0RBBwwGoEYY2Fy
bGpvaGFuQGtqZWxsYW5kZXIuY29tMAwGA1UdEwEB/wQCMAAwDQYJKoZIhvcNAQEEBQADgYEA
UH79QygIr4Cdl/wonVeOwk+MB9tSG3uT3DHQnpyxVjm/rmulDPj6+V9vPqCpKvy0l6Tis/6Z
NP5lmvynnnYAcGAMsoIS73VmQsPgk2molAi9gMd8ufmFL1ta8RuRCpAnsRTtCLZYW1t9AtX/
C4wkzrjZvkhdE0TmbDaWpOhwK2kwggMGMIICb6ADAgECAgMPuWEwDQYJKoZIhvcNAQEEBQAw
YjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4x
LDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMB4XDTA1MTAy
NDA5MDUwN1oXDTA2MTAyNDA5MDUwN1owczETMBEGA1UEBBMKS2plbGxhbmRlcjETMBEGA1UE
KhMKQ2FybCBKb2hhbjEeMBwGA1UEAxMVQ2FybCBKb2hhbiBLamVsbGFuZGVyMScwJQYJKoZI
hvcNAQkBFhhjYXJsam9oYW5Aa2plbGxhbmRlci5jb20wggEiMA0GCSqGSIb3DQEBAQUAA4IB
DwAwggEKAoIBAQC6cEq5hQ6dXWrebX2jp9ZRiB5jBgVhMtfgthMOqb6nHJPluTsV+BaLrJAy
OQG0Ggai/gzcydgmyA7/V4934tCi0YYMjf2wRIPo3JRYif47pL16N/AR/kMf9LTXp8yG5fSX
ko2WGtDYS5VfmB1DFJE5XYUs7s5gmFoyCGcSti3kaG9kp4wJjWdEm2Rq0P7GdR4vjQEBZL/g
LeOp/yO/YrI/+jvV0MhVrXCyt/wyyjNdq3RPZ/wzqqdP5ncxbM5vspgiIAdBVHGDYK7D+Kob
DLcPuLQe8PxVWKeJ0ZyBWtT+JF5MBPfIoVhUY/2RGxOFL18uUTtGWmA9sXQvzBcD7gyDAgMB
AAGjNTAzMCMGA1UdEQQcMBqBGGNhcmxqb2hhbkBramVsbGFuZGVyLmNvbTAMBgNVHRMBAf8E
AjAAMA0GCSqGSIb3DQEBBAUAA4GBAFB+/UMoCK+AnZf8KJ1XjsJPjAfbUht7k9wx0J6csVY5
v65rpQz4+vlfbz6gqSr8tJek4rP+mTT+ZZr8p552AHBgDLKCEu91ZkLD4JNpqJQIvYDHfLn5
hS9bWvEbkQqQJ7EU7Qi2WFtbfQLV/wuMJM642b5IXRNE5mw2lqTocCtpMIIDPzCCAqigAwIB
AgIBDTANBgkqhkiG9w0BAQUFADCB0TELMAkGA1UEBhMCWkExFTATBgNVBAgTDFdlc3Rlcm4g
Q2FwZTESMBAGA1UEBxMJQ2FwZSBUb3duMRowGAYDVQQKExFUaGF3dGUgQ29uc3VsdGluZzEo
MCYGA1UECxMfQ2VydGlmaWNhdGlvbiBTZXJ2aWNlcyBEaXZpc2lvbjEkMCIGA1UEAxMbVGhh
d3RlIFBlcnNvbmFsIEZyZWVtYWlsIENBMSswKQYJKoZIhvcNAQkBFhxwZXJzb25hbC1mcmVl
bWFpbEB0aGF3dGUuY29tMB4XDTAzMDcxNzAwMDAwMFoXDTEzMDcxNjIzNTk1OVowYjELMAkG
A1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNV
BAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMIGfMA0GCSqGSIb3DQEB
AQUAA4GNADCBiQKBgQDEpjxVc1X7TrnKmVoeaMB1BHCd3+n/ox7svc31W/Iadr1/DDph8r9R
zgHU5VAKMNcCY1osiRVwjt3J8CuFWqo/cVbLrzwLB+fxH5E2JCoTzyvV84J3PQO+K/67GD4H
v0CAAmTXp6a7n2XRxSpUhQ9IBH+nttE8YQRAHmQZcmC3+wIDAQABo4GUMIGRMBIGA1UdEwEB
/wQIMAYBAf8CAQAwQwYDVR0fBDwwOjA4oDagNIYyaHR0cDovL2NybC50aGF3dGUuY29tL1Ro
YXd0ZVBlcnNvbmFsRnJlZW1haWxDQS5jcmwwCwYDVR0PBAQDAgEGMCkGA1UdEQQiMCCkHjAc
MRowGAYDVQQDExFQcml2YXRlTGFiZWwyLTEzODANBgkqhkiG9w0BAQUFAAOBgQBIjNFQg+oL
LswNo2asZw9/r6y+whehQ5aUnX9MIbj4Nh+qLZ82L8D0HFAgk3A8/a3hYWLD2ToZfoSxmRsA
xRoLgnSeJVCUYsfbJ3FXJY3dqZw5jowgT2Vfldr394fWxghOrvbqNOUQGls1TXfjViF4gtwh
GTXeJLHTHUb/XV9lTzGCAzswggM3AgEBMGkwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRo
YXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBG
cmVlbWFpbCBJc3N1aW5nIENBAgMPuWEwCQYFKw4DAhoFAKCCAacwGAYJKoZIhvcNAQkDMQsG
CSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMDUxMjE1MTM0NjQ2WjAjBgkqhkiG9w0BCQQx
FgQUgN97fd+drl9JJM7Dmu31Ip6D98cwUgYJKoZIhvcNAQkPMUUwQzAKBggqhkiG9w0DBzAO
BggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYFKw4DAgcwDQYIKoZIhvcNAwICASgw
eAYJKwYBBAGCNxAEMWswaTBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1
bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElz
c3VpbmcgQ0ECAw+5YTB6BgsqhkiG9w0BCRACCzFroGkwYjELMAkGA1UEBhMCWkExJTAjBgNV
BAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJz
b25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAgMPuWEwDQYJKoZIhvcNAQEBBQAEggEAcjSvkxh0
HiY+wtk+rP/vhYYYMnWYJw5/a29XfXkCiaIWhYh3yw+XgLlx9yHhTFgp/aqsESqcMQS7uFeA
g0b3bazDDtLMrVKB2eFN1byaWoOAyVBtS0jy5TtZhPvplbxDATLtSvi6KvFqZv9RKh/fjsx8
14uKNZx/9XAQdyM2/4SdB6bxxlt7/vnMd75cY6v3XNmHFQCEly8o6cDhuvJ3Nlaz5/uL/A8j
K6Xa6HhhkZ5lysHs2L7oKCaXS5oeEB97o+c15bqsKyiI9dAjJDfR5lIbFIvtRtJTbcNftkmI
zObMlIX1E6VbFbxeE4DI/ptbsLXhXQssS+LOu4JZLx5rLwAAAAAAAA==
--------------ms060004000809030803060407--
