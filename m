Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265297AbTFFEW5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 00:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265298AbTFFEW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 00:22:56 -0400
Received: from ironbark.bendigo.latrobe.edu.au ([149.144.21.60]:18385 "EHLO
	ironbark.bendigo.latrobe.edu.au") by vger.kernel.org with ESMTP
	id S265297AbTFFEWt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 00:22:49 -0400
From: Grant <grant@ironbark.bendigo.latrobe.edu.au>
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: 2.4.21-rc7-ac1: zip ppa 'device set offline...' problem in scsi_error.c?
Date: Fri, 06 Jun 2003 14:36:02 +1000
Organization: Scattered
Message-ID: <pf60evg3t6hbsbhbtram60gq0ho7dkasvc@4ax.com>
X-Mailer: Forte Agent 1.93/32.576 English (American)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="--=_ih60ev87l3jo2v5unsm47vtq3po5othseh.MFSBCHJLHS"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----=_ih60ev87l3jo2v5unsm47vtq3po5othseh.MFSBCHJLHS
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi there,

My system is AMD K6-2/400 with IDE HD & CDROM with Redhat 9 
& updates installed.  

I'm trying to track down why zip-disk ppa driver doesn't want to 
work for me on 2.4.21-rc7-ac1, while working okay on 2.4.21-rc7.

The error is reported in response to the 'insmod ppa' command, 
afterwards, 'mount /mnt/zip' or 'fdisk /dev/sda' fail with '... 
/dev/sda4 is not a valid block device'.

Using 'echo "scsi log all" > /proc/scsi/scsi', both kernels 
scan IDs 0 thru 7 and find the zip drive on ID 6.  But the 
AC kernel then takes the zip drive offline.  

2.4.21-rc7-ac1 kernel taking zip ppa offline:

Jun  6 12:51:56 two kernel: Host status for host c74db8e0:
Jun  6 12:51:56 two kernel: Device 6 c7cb8800: 
Jun  6 12:51:56 two kernel: Attached scsi removable disk sda at scsi0,
channel 0, id 6, lun 0
Jun  6 12:51:56 two kernel: scsi_do_req (host = 0, channel = 0 target = 6,
buffer =c02c4000, bufflen = 0, done = c01d3d40, timeout = 3000, retries = 5)
Jun  6 12:51:56 two kernel: command : 00  00  00  00  00  00  
Jun  6 12:51:56 two kernel: Activating command for device 6 (1)
Jun  6 12:51:56 two kernel: Leaving scsi_init_cmd_from_req()
Jun  6 12:51:56 two kernel: Adding timer for command c7cb8600 at 3000
(c01d8940)
Jun  6 12:51:57 two kernel: scsi_dispatch_cmnd (host = 0, channel = 0, target
= 6, command = c7cb8658, buffer = c02c4000, 
Jun  6 12:51:57 two kernel: bufflen = 0, done = c01d3d40)
Jun  6 12:51:57 two kernel: queuecommand : routine at c886c420
Jun  6 12:51:57 two kernel: leaving scsi_dispatch_cmnd()
Jun  6 12:51:57 two kernel: Leaving scsi_do_req()
Jun  6 12:51:57 two kernel: Clearing timer for command c7cb8600 1
Jun  6 12:51:57 two kernel: Command failed c7cb8600 2 active=1 busy=1
failed=0
Jun  6 12:51:57 two kernel: bh00:00: old sense key None
Jun  6 12:51:57 two kernel: Non-extended sense class 0 code 0x0
Jun  6 12:51:57 two kernel: Waking error handler thread (-1)
Jun  6 12:51:57 two kernel: Error handler waking up
Jun  6 12:51:57 two kernel: scsi_unjam_host: Checking to see if we need to
request sense
Jun  6 12:51:57 two kernel: scsi_unjam_host: Requesting sense for 6
Jun  6 12:51:57 two kernel: Adding timer for command c7cb8600 at 1000
(c01d8b00)
Jun  6 12:51:57 two kernel: In eh_done c7cb8600 result:0
Jun  6 12:51:57 two kernel: send_eh_cmnd: c7cb8600 eh_state:2002
Jun  6 12:51:57 two kernel: scsi_send_eh_cmnd: scsi_eh_completed_normally
2002
Jun  6 12:51:57 two kernel: Sense requested for c7cb8600 - result 2
Jun  6 12:51:57 two kernel: bh00:00: old sense key None
Jun  6 12:51:57 two kernel: Non-extended sense class 0 code 0x0
Jun  6 12:51:57 two kernel: Command to ID 6 failed
Jun  6 12:51:57 two kernel: Total of 1+0 commands on 1 devices require eh
work
Jun  6 12:51:57 two kernel: scsi_unjam_host: Checking to see if we want to
try abort
Jun  6 12:51:57 two kernel: scsi_unjam_host: Checking to see if we want to
try BDR
Jun  6 12:51:57 two kernel: scsi_unjam_host: Try hard bus reset
Jun  6 12:51:57 two kernel: Sleeping for timer tics 500
Jun  6 12:51:59 two kernel: Adding timer for command c7cb8600 at 1000
(c01d8b00)
Jun  6 12:51:59 two kernel: In eh_done c7cb8600 result:2
Jun  6 12:51:59 two kernel: send_eh_cmnd: c7cb8600 eh_state:2002
Jun  6 12:51:59 two kernel: scsi_send_eh_cmnd: scsi_eh_completed_normally
2003
Jun  6 12:51:59 two kernel: scsi_test_unit_ready: SCpnt c7cb8600 eh_state
2003
Jun  6 12:51:59 two kernel: scsi: device set offline - not ready or command
retry failed after bus reset: host 0 channel 0 id 6 lun 0


what 2.4.21-rc7 does at the same point:


Jun  6 13:37:39 two kernel: Host status for host c73aff40:
Jun  6 13:37:39 two kernel: Device 6 c1168e60: 
Jun  6 13:37:39 two kernel: Attached scsi removable disk sda at scsi0,
channel 0, id 6, lun 0
Jun  6 13:37:39 two kernel: scsi_do_req (host = 0, channel = 0 target = 6,
buffer =c02e9000, bufflen = 0, done = c01d0aa0, timeout = 3000, retries = 5)
Jun  6 13:37:39 two kernel: command : 00  00  00  00  00  00  
Jun  6 13:37:39 two kernel: Activating command for device 6 (1)
Jun  6 13:37:39 two kernel: Leaving scsi_init_cmd_from_req()
Jun  6 13:37:39 two kernel: Adding timer for command c5d6da00 at 3000
(c01d5600)
Jun  6 13:37:39 two kernel: scsi_dispatch_cmnd (host = 0, channel = 0, target
= 6, command = c5d6da58, buffer = c02e9000, 
Jun  6 13:37:39 two kernel: bufflen = 0, done = c01d0aa0)
Jun  6 13:37:39 two kernel: queuecommand : routine at c8850420
Jun  6 13:37:39 two kernel: leaving scsi_dispatch_cmnd()
Jun  6 13:37:39 two kernel: Leaving scsi_do_req()
Jun  6 13:37:39 two kernel: Clearing timer for command c5d6da00 1
Jun  6 13:37:39 two kernel: Command failed c5d6da00 2 active=1 busy=1
failed=0
Jun  6 13:37:39 two kernel: bh00:00: old sense key None
Jun  6 13:37:39 two kernel: Non-extended sense class 0 code 0x0
Jun  6 13:37:39 two kernel: Waking error handler thread (-1)
Jun  6 13:37:39 two kernel: Error handler waking up
Jun  6 13:37:39 two kernel: scsi_unjam_host: Checking to see if we need to
request sense
Jun  6 13:37:39 two kernel: scsi_unjam_host: Requesting sense for 6
Jun  6 13:37:39 two kernel: Adding timer for command c5d6da00 at 1000
(c01d57c0)
Jun  6 13:37:39 two kernel: In eh_done c5d6da00 result:0
Jun  6 13:37:39 two kernel: send_eh_cmnd: c5d6da00 eh_state:2002
Jun  6 13:37:39 two kernel: scsi_send_eh_cmnd: scsi_eh_completed_normally
2002
Jun  6 13:37:39 two kernel: Sense requested for c5d6da00 - result 2
Jun  6 13:37:39 two kernel: Current bh00:00: sense key Unit Attention
Jun  6 13:37:39 two kernel: Additional sense indicates Power on,reset,or bus
device reset occurred
Jun  6 13:37:39 two kernel: Total of 0+0 commands on 0 devices require eh
work



Attached are the full log sections in case the excerpts above 
don't give enough information.

Anybody shed some light on this?  I'm not sure what to try next.

Thanks,
Grant.



----=_ih60ev87l3jo2v5unsm47vtq3po5othseh.MFSBCHJLHS
Content-Type: application/octet-stream; name=grc_zip_ppa_logs.tar.gz
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=grc_zip_ppa_logs.tar.gz

H4sIALES4D4AA+2cW2/bOBbH+9xPwccMNkmpu2KgD5m0s5vBtM0maYvdwSBgJDrRxpE8kpzLt1+S
tmNLongR5VwMEWgdOz6HFM/hT6RC/qdTdDFGyeTdBgu0IPRd9x0kJfCrrxC6MLCDd+SDgLzxbZf8
bFm+FbwDcJONWpZZUaIcgHdXOUpLwfdkv3+jxd53921rL4+CPRRZYG8P0Gx4//73WQqADyx75Fkj
1wXlfQZucJ7iyQgUUZGASXZ1laRXYILv8AQUuARlBuDDeFGqDjy74mA6RSPwA+dFkqXA3ocB2Bln
OfgjSWcPgLbo4Re5/W/ZLI1BjO+SCANUguNPwN8Fh2WJb6clbRlpz6zA4PPJCXBscJmUcp9H2e3t
LE0iVNKWYZIal5OkuMYxuE/Ka1YF8UmdK3r9iW4wmE3BFOU4LcGeJfz25zwn3XCN0niCc1BMMJ6S
uoQmNBYQjMBxdouvEPhxcgzBDrmWX0CSljgfowhL7cnFk29m+S29sOOv//5+fPofqdFFnF3k+G+w
c50VJfgI4C6ISMvJ7+kbQAbVFV58fjkbj8n1fIy8eBzEUTj/ZIJT8mvbI0GLsxSTnyNoxU7sEosy
ucXZjJr7kLzNcZknuCBvHXFiRCR+pPdIf1g2ABCu/o3H81eh+WFUJneIJc/SE83LRY6RjrXE1f+B
0R01Zv2TpEl5Ed3GF+M8u6VdtSM2PoxjlrXk0nNW7bIJURBdhqQfaJLTlx3aT+GBC8X+5kFKiikq
o2vSEOKJH6vdSrCWtX5c1OuFqwCCVQSFVYvDK2723zM8w6s45iQNkpQN8CgM/ci1odB8sh6CytVL
ur8Su3luNyycisURqSuXhKw+3mselklGcoVRxiJJBh8selsUGn7NymT8SOueTcnYBXGe3JGXbExb
MJ1ghq9K6sp9fsJIlv7sC/gjyRJ6k8Dxx0YsHQ5cFkRZ2MxJGmUxVrpSRT41jVT5ZG2WT44ZnxwN
PlkcPjkmfHJ65hMvSHp8srryyTHgk2PGJ6crnwSx2zY+WT3wydpOPtlbwyd7+/lkD3zaLJ/crnxy
jfhkc/nkavHJVuFTc6GtzSeeCymfmkaqfHI2yyfXjE+uBp8cDp9cEz65PfOJFyQ9Pjld+eQa8Mk1
45PblU+C2LXwyX2rfHJ64JOznXxyt4ZP7vbzyX2DfPK68snT5pNnzCevK588Iz65XD55WnxyVfjk
mfOJ50LKp6aRKp+8zfLJM+OTp8Enj8MnQY7L+eT1zCdekPT45HXlk2fAJ2/g06b55PXAJ287+eRv
DZ/87eeT/wb55Hflk6/NJ9+YT74Kn8RXqMsmH4j9ybjkq3DJF3CpmEURLorxbFJhk7hVAPzAaZzl
xM23L5//eUg+AF+IIfnVf49PKG7BqpziO3Id+1YgcXn+OMX09VOS46jcO2TtAtxy+PXsGJwdkf9y
0g10o8kIQFvhqqUobRqpojTYLEp9M5T6GigNOCgVDEc5Sn0NlCIFlPKCpIfSoIFSpIZS3wCl/pai
FHVFKW8CZIbTgDvV00NqYIpUxale1cW/aMYWJSpnBWsMy+AocOPLEMOR5IIWtwIWjRDCkWT0lyWK
aBTYVr8c32Z36HKCAcmiG1DEiOYg23m2Gj3kxySmE5AJ8Su+kK7TT2hHLoRwnZlQSEwHVpHpqSJz
HZfr/wyQyZt9PhsyF7NP2h/tzAw2P/18iqCwalF4xY3WJmbQlZiBNjEDLWLyJp8Bn5hzljxZ2WDB
Jot0ZPFIXpaEEnf6NaECBUM2IcMepwUmv3okeE3rG0iDGn/TPfxQkskeXtpFE0SmZbBtoli1/4lu
aDfgytbX8jrHiCTcXmPIVI2rG2bv565mU3liz9L/odsLms+kI69xdLPYMFxgDJIxuMcgxeR6yCck
lDNMwUsvTc/x6dyUJQbrGBplX+hDaRhbq2F8CSUj4jgF+PqCDaInFzkuZpNyJI4LaXF8gefZP1rZ
kk/oLQiPbNiYTnO6o+qFfUTfze/MOL5IyVQbTSaPQOrujPXgIhp4jtanVu0trgmIfbxUji+HKkkn
toV8PiCFJudZiSZ0FmP9Ay6ToABkKmMtbigF6wuyECIhAfdZftNH0t+jlO3jL/NHgC6zvL653djp
r59O9VyeE6NrlMeUZTTIWNyks8WeeZYe81FUJlEBvMbc6qDvcXegOu7qOXpgOu4OzMadI3dXkjFH
wkKmJJTLj6Sfj6Zp2WydmrvRck5ET41k5F5P79F7IM1KwNyDtf6nk7fH5T0OjUsSnqdMGM2nwHA1
B2VTUO4MtFu4VaPd5W7O6WZ2E9yPnm6Ks+n8CtltiJ5Tqif/geBu2HJ8RFTtIiyrkOR4SiAAUAHO
vh8dfT47E/cCfw0nTlf9x2Fif708Dqu6/DYlk1GSiLM8pU7FqdXj4iY0W9xU27WaFdsef3EjWezU
RpD2Yqdqr7nY6TB8xYsdXtCeabFTrVoUbnGjtRc7VXONxY4gdLzFjj2ClhkeGx5MONVsjsJj+4aR
4WP7hj9zTjVcssfdy1trjEbAOvB9GALPsvcuH8nd+Tq+J/cFHJVZXpARSsy//Cp22SPNSCsMeNZo
2drzbTTnlTNuf77dMNfkV8Neh1/Nyg351RKm5+BXo2pxgMXN1iNYw1yVYOLgDQR7PQRj1PqZJ4RV
J3lWElKBpKC9JLRiZqYD+lPGMiJePmLYpaZ0yDyEjGOTLLqhb4VOfmPxoI7CJWeF3z9lqxv2ZwD4
sEwk8bUef/g2f1jGkgjAcESbN6/s+QM29PpL9DqYpezPMWxdiGKqLlAmbPhSwQL8/v17Zf2H6RRd
ZDfocYMSEzL9DyfwrJX+h+0x/Q/XGfQ/nqOs9D+o9gfNhJX2hzNygpHVVBVQ1v5gDpyazgbK6Z0O
jsDJ0V5RPk7Y/R4+OEEI/jw5Ojs52T0/PT47Pzz/vPv55OSvmrPqZm0dIZFWewMhkVafRkIiPK/t
QiK8b0ueBPFMdIRE2uyFu2fajLoJicQHcQxFu2cgQoq7Z3gN09g9wzPXERLh2SuvLriVi1YXKKrt
nvH89Yeb7UEyFBJBUX33zCKCwqrF4RU3W7i48OD64oJnrrS4kMausbjgWUgWFyxk4vGutHuGZ2gq
JMLzaSgk0g4X5d0zBnzqvlHa2iyfOm+U5pnrCInw7DX5pLFRGtV39/H4ZL5RuiEkghq7+/h8Ut0o
zeOTxkZpHp86HOSQxq6FT1oHORDi8KnDQQ6eoamQCM+noZBIWwpq80nzIIcpn+yt4ZP9knzCz8Kn
hpAIwgOfuvIJvx4+1YVEuvBJIiTSG580T0e0GXUTEumdT51PR/DMdYREePaafFLd6uvFfgwV+GR+
OqIqJMLqVeOT6ukIHp80Tkfw+NThdIQ0di18Uj8dsQxZnU8dTkfwDE2FRHg+DYVE2uHyuvnkbg2f
3Jfkk/0sfHIbfLIHPnXlk/16+FQXEunCJ4mQyFvlk7dZPgVmfAo0+ORx+CQ4byPnk+oZC5rsrgKf
zE9KeQ0+uWp8ajsppcInjbNSPD51OCsljV0Ln9TPSi1DVudTy1kpOZ/qJz/MhER4Pg2FRNpSUJtP
PBdSPvFSv4uQyFvmk/+SfKoLiWyGT36DTw0hkYFPqnzyu/KpXzat7+frwiXJRiU5l6RCIjwXhkIi
c5dhzWV/QiI8/4oobRq9EpSGApTacpSGhigNTVAa9oxSXpCeCaWhAUpDM5SGXVEqiF0LSkNjlIZd
UBr2jNKwf5TyoKKJ0mfmUvByXFKY4ulwKXhJLoXPwqWgwaVw4FJXLoVducRbmJmxqS5wNPepd0hW
InDEc9lpCVp10SJw5KDx2F0TOOJf0FLgyLL8EPvrAke87/cncNTWF91OzeEDocBRnZiCM3O8dmkI
HHE7TXsq1/HML7dyITJR/cwcj5l9n/llFdfPzC0iKKxaFF5xo7WJ2eHMrzR0LcRUl0RYRqxOzBY5
gYXA0dJKQeCI2+kK4i88Ox3xF569ssARz1gmcNSa2KYCR0qOJQJHnYfxSmjFCyLJiFgXWlm6aAgc
ca+mKrSytOULrbR2RzeBI547rsDRslUcgSPukJnl7HjIU66v8vw74S071JLSCYM0RvRLaLKwT9KY
HmUht5iT7J7OPdJdJsCym83VWBZ3APYZyKKItiIWVvEkbwRr8kZQKm9kklWtSeVCU3jVPOjqufB8
qJziqTdcJsHCM9Jf/Ybs5J7Yax9rYF6nvoZ5Va1duvOqmrn2vKpmrzevqlduPK/iBul55lW1qjXm
VTVL3XlVzVx9XiUKHX9e1Tua1J6QGTNC7O910yHcDB20lZcGWjwLLZrhHmjxwrToVUOB59JQLInn
skcA1bV0tBHUWSyJZ66PnI5iSdzKzZHTt1iSBnJUxZJ40NEQS+JBp4NYkjR4LdBRF0tqg46mvhHP
6A1AR65vxLPS1jfiXo2u0k5L+2nqYbJ2n1t/IC8f9M3ZiA4/MNoCRlvmoNjfAhJ4kRXrkMCFB9W/
m0WB/0pRsCUDe5GG9+RWVOY7JFIQ/Ela8Zf44p+0pUBJH17trn1Ag1dP3arqzazAF8UVHez1plW/
1w907AY+XHVFqKEMZShDGcpQhjKUoQxlKEMZylCGMpShbFP5P8AQfmcAoAAA

----=_ih60ev87l3jo2v5unsm47vtq3po5othseh.MFSBCHJLHS--
