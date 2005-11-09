Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751575AbVKIXQL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751575AbVKIXQL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 18:16:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751577AbVKIXQL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 18:16:11 -0500
Received: from baldrick.bootc.net ([83.142.228.48]:2542 "EHLO
	baldrick.bootc.net") by vger.kernel.org with ESMTP id S1751575AbVKIXQJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 18:16:09 -0500
In-Reply-To: <17266.30440.930561.902428@cse.unsw.edu.au>
References: <4371FA5B.6030900@bootc.net> <17266.30440.930561.902428@cse.unsw.edu.au>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: multipart/signed; micalg=sha1; boundary=Apple-Mail-1-799618543; protocol="application/pkcs7-signature"
Message-Id: <3356B173-1C22-4C46-8CC4-1A08C303C63D@bootc.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
From: Chris Boot <bootc@bootc.net>
Subject: Re: 2.6.14-mm1 RAID-1 in D< state
Date: Wed, 9 Nov 2005 23:15:57 +0000
To: Neil Brown <neilb@suse.de>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-1-799618543
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed

On 9 Nov 2005, at 22:23, Neil Brown wrote:

> On Wednesday November 9, bootc@bootc.net wrote:
>> Hi all,
>>
>> I haven't noticed this until today...but my load average has been
>> skyrocketing past 3.00 since Monday, which is when I upgraded to
>> 2.6.14-mm1. I've got 3 Software RAID-1 arrays across 4 SATA disks,  
>> and
>> all 3 processes are locked in an uninterruptible sleep.
>>
>> What's interesting, though, is I haven't noticed a degradation of
>> performance at all, and all the arrays work absolutely fine. They  
>> aren't
>> rebuilding or doing anything strange that I can see.
>>
>> Any ideas?
>
> Can you
>   echo t > /proc/sysrq-trigger
>   dmesg > /tmp/log
> and post the log created, possibly removing everything before
>    SysRq : Show State

So that's what the sysrq-trigger is for... :-) Certainly easier that  
way when your system still works!

> If you can't find the 'Show State', then maybe your log buffer isn't
> big enough.  use 'dmesg -s ...' to make it bigger and try again

It was too small, but the serial console got it:

[4329954.200000] md2_raid1     D F7D776E0     0   809       
6           810   799 (L-TLB)
[4329954.200000] f7db7f30 f7d2ba8c c02809e0 f7d776e0 c02c14f2  
e9924580 c1b48b60 c1b8e200
[4329954.200000]        f7c5bd40 7fffffff f7db7f88 00000000 23c37e00  
000f6206 f7d6fa50 f7d6fb78
[4329954.200000]        7fffffff 7fffffff f7db7f88 f7db6000 c0338098  
c1b8e200 f7db7f94 f7db7f88
[4329954.200000] Call Trace:
[4329954.200000]  [<c02809e0>] generic_unplug_device+0x10/0x20
[4329954.200000]  [<c02c14f2>] unplug_slaves+0xd2/0xe0
[4329954.200000]  [<c0338098>] schedule_timeout+0x98/0xa0
[4329954.200000]  [<c01295a9>] finish_wait+0x39/0x50
[4329954.200000]  [<c02c9309>] md_thread+0xc9/0x100
[4329954.200000]  [<c01295c0>] autoremove_wake_function+0x0/0x50
[4329954.200000]  [<c01142d7>] __wake_up_common+0x37/0x60
[4329954.200000]  [<c01295c0>] autoremove_wake_function+0x0/0x50
[4329954.200000]  [<c02c9240>] md_thread+0x0/0x100
[4329954.200000]  [<c0129174>] kthread+0xa4/0xe0
[4329954.200000]  [<c01290d0>] kthread+0x0/0xe0
[4329954.200000]  [<c0100f35>] kernel_thread_helper+0x5/0x10
[4329954.200000] md0_raid1     D F7D774A0     0   810       
6           812   809 (L-TLB)
[4329954.200000] f7db5f30 f7d2b79c c02809e0 f7d774a0 c02c14f2  
c0383bc0 c1b48ae0 c1b8e400
[4329954.200000]        f7c5bb60 7fffffff f7db5f88 00000000 9bd42ec0  
000f6211 f7d69090 f7d691b8
[4329954.200000]        7fffffff 7fffffff f7db5f88 f7db4000 c0338098  
c1b8e400 00000002 f7db4000
[4329954.200000] Call Trace:
[4329954.200000]  [<c02809e0>] generic_unplug_device+0x10/0x20
[4329954.200000]  [<c02c14f2>] unplug_slaves+0xd2/0xe0
[4329954.200000]  [<c0338098>] schedule_timeout+0x98/0xa0
[4329954.200000]  [<c0129501>] prepare_to_wait+0x41/0x50
[4329954.200000]  [<c02c9309>] md_thread+0xc9/0x100
[4329954.200000]  [<c01295c0>] autoremove_wake_function+0x0/0x50
[4329954.200000]  [<c01142d7>] __wake_up_common+0x37/0x60
[4329954.200000]  [<c01295c0>] autoremove_wake_function+0x0/0x50
[4329954.200000]  [<c02c9240>] md_thread+0x0/0x100
[4329954.200000]  [<c0129174>] kthread+0xa4/0xe0
[4329954.200000]  [<c01290d0>] kthread+0x0/0xe0
[4329954.200000]  [<c0100f35>] kernel_thread_helper+0x5/0x10
[4329954.200000] md1_raid1     D F7D77860     0   812       
6           813   810 (L-TLB)
[4329954.200000] f7dbbf30 f7d2bc04 c02809e0 f7d77860 c02c14f2  
e9924580 c1b48a60 c1b8e000
[4329954.200000]        f7c5f920 7fffffff f7dbbf88 00000000 2358ae40  
000f6206 f7d5b5c0 f7d5b6e8
[4329954.200000]        7fffffff 7fffffff f7dbbf88 f7dba000 c0338098  
c1b8e000 f7dbbf88 f7dba000
[4329954.200000] Call Trace:
[4329954.200000]  [<c02809e0>] generic_unplug_device+0x10/0x20
[4329954.200000]  [<c02c14f2>] unplug_slaves+0xd2/0xe0
[4329954.200000]  [<c0338098>] schedule_timeout+0x98/0xa0
[4329954.200000]  [<c02c29ba>] raid1d+0x32a/0x350
[4329954.200000]  [<c02c9309>] md_thread+0xc9/0x100
[4329954.200000]  [<c01295c0>] autoremove_wake_function+0x0/0x50
[4329954.200000]  [<c01142d7>] __wake_up_common+0x37/0x60
[4329954.200000]  [<c01295c0>] autoremove_wake_function+0x0/0x50
[4329954.200000]  [<c02c9240>] md_thread+0x0/0x100
[4329954.200000]  [<c0129174>] kthread+0xa4/0xe0
[4329954.200000]  [<c01290d0>] kthread+0x0/0xe0
[4329954.200000]  [<c0100f35>] kernel_thread_helper+0x5/0x10

Let me know if you need dumps of any other processes.

> NeilBrown

Cheers,
Chris

-- 
Chris Boot
bootc@bootc.net
http://www.bootc.net/



--Apple-Mail-1-799618543
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
BgkqhkiG9w0BCQUxDxcNMDUxMTA5MjMxNTU3WjAjBgkqhkiG9w0BCQQxFgQUE4yPbdwyDcskfGfX
Lk+rSlMDNs0weAYJKwYBBAGCNxAEMWswaTBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3Rl
IENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWls
IElzc3VpbmcgQ0ECAw4IwzB6BgsqhkiG9w0BCRACCzFroGkwYjELMAkGA1UEBhMCWkExJTAjBgNV
BAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25h
bCBGcmVlbWFpbCBJc3N1aW5nIENBAgMOCMMwDQYJKoZIhvcNAQEBBQAEggEAqEYLxVojP24ZuRVf
OKazph3oT3uTgcdG9GpcL9L6JWJLBbfnACwffedhmzkQWMe4OfF61oBwprvtssABc6yAB3aP/gvw
2jx5RpXFpSO7f5pR/sNhnmWElpapOexgoGk//CZJq69b/sgHuAVUVMSW+UNy9eYWlmH77Z8UtL8v
6y8309qSZoOJGAASZIcvi1nY2BzlxaoX2IrP265SrrOz4N2c6mxhyvUFxq97dag3PBXnBqyUpk8V
eJ+i/4jAE5zkdSVp9gQzdIwOQqnxtmfISh6oEuJr8HEuvLRXvKdsYM8PMMAkvPq5dLDcIPpiIc6W
rYNkQrAZf/36Hd0g/urICAAAAAAAAA==

--Apple-Mail-1-799618543--
