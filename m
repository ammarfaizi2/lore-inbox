Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293641AbSCATWi>; Fri, 1 Mar 2002 14:22:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293659AbSCATW3>; Fri, 1 Mar 2002 14:22:29 -0500
Received: from chaos.analogic.com ([204.178.40.224]:23936 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S293641AbSCATWT>; Fri, 1 Mar 2002 14:22:19 -0500
Date: Fri, 1 Mar 2002 14:22:46 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Torrey Hoffman <Torrey.Hoffman@myrio.com>
cc: Zwane Mwaikambo <zwane@linux.realnet.co.sz>,
        Matthew Allum <mallum@xblox.net>, linux-kernel@vger.kernel.org
Subject: RE: Multiple kernels OOPS at boot on Fujitsu pt510 ( AMD DX100 CPU ) - ksymoops output attached
In-Reply-To: <A015F722AB845E4B8458CBABDFFE63420FE3BC@mail0.myrio.com>
Message-ID: <Pine.LNX.3.95.1020301140527.5981A-200000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1678434306-425895735-1015010566=:5981"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1678434306-425895735-1015010566=:5981
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Fri, 1 Mar 2002, Torrey Hoffman wrote:

> Richard B. Johnson [mailto:root@chaos.analogic.com] wrote:
> 
> [... snipped: using 2.4.1 because... ]
> 
> > Later versions, including the current 2.4.18 fail, to mount an initrd.
> 
> I have successfully used ext2-formatted initrd's with a variety of recent 
> kernels between 2.4.16 and 2.4.18.  The only problem I've ever had is that 
> when _building_ an initrd, kernels between 2.4.10 and 2.4.18-pre-something
> had a bug in the ramdisk driver.  This has been fixed in later kernels, 
> and there is also a workaround for it.
> 
> > Once somebody makes a kernel they has both a working loop device and
> > a working initial RAM Disk, I will use that kernel. In the meantime,
> 
> My workstation is running a 2.4.18-pre? which successfully mounts CDROM
> ISO images on loopback and successfully creates and boots initrd's.
> 
> Are you sure this is not something specific to your setup or config?
> 
> Torrey Hoffman

I have gone this far; I can include SCSI in the initial build so
I can boot and mount a root file-system.

This is on 2.4.17. Once I am up, I can build an ext2 file-system ramdisk-
image. I can mount it though the loop device and I can read/write to
it the ram disk and the loop device together work.

However, I should be able to do:
mke2fs -Fq /dev/ram0 1440
# This works ... 
mount /dev/ram0 /mnt
# This fails to mount the loop-back device. If I do:
mount -o loop -t ext2 /dev/ram0 /mnt. That works.

Given that, when the kernel uncompresses initrd, and attempts to
mount the root file-system, it doesn't mount it through the loop
device. Instead, in tries to mount it directly. This is probably
what fails. Something has been broken for quite some time and
nobody else seems concerned.

If I boot 2.4.1, I can do:
mke2fs -Fq /dev/ram0 1440
mount /dev/ram0 /mnt

This all works fine.

Attached is my 'ram-disk' tester. If it works on your version
of kernel, please let me know what version it is. This makes
a bootable floppy which loads a tiny program that pretends that
it's init. It doesn't touch your hard disks or anything like
that. It is useful to make such a bootable floppy to verify that
some CPU that you might want to purchase, will boot Linux. This
is what the script was originally used for.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

        111,111,111 * 111,111,111 = 12,345,678,987,654,321

--1678434306-425895735-1015010566=:5981
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="test_ramdisk.sh"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.3.95.1020301142246.5981B@chaos.analogic.com>
Content-Description: 

IyEvYmluL3NoDQojDQojDQpleHBvcnQgVkVSPSQxDQpSQU1ESVNLX0lNQUdF
PS90bXAvUmFtSW1hZ2UtJHtWRVJ9DQpSQU1ESVNLPS90bXAvUmFtZGlzaw0K
VE1QQz0vdG1wL1RlbXAuYw0KVE1QRj0vdG1wL1RtcEV4ZQ0KRElTS1NJWkU9
MjA0OA0KU1lTPS91c3Ivc3JjL2xpbnV4LSR7VkVSfS9hcmNoL2kzODYvYm9v
dC9iekltYWdlDQppZiBbICIkMSIgPSAiIiBdIDsNCiAgIHRoZW4NCiAgICAg
ICBlY2hvICJVc2FnZToiDQogICAgICAgZWNobyAidGVzdF9yYW1kaXNrIDx2
ZXJzaW9uPiINCiAgICAgICBleGl0IDENCmZpDQppZiBbICEgLWYgJHtTWVN9
IF0gOw0KICAgdGhlbg0KICAgIGVjaG8gIkZpbGUgbm90IGZvdW5kLCAke1NZ
U30iDQogICAgZXhpdCAxDQpmaQ0KaWYgISBkZCBpZj0vZGV2L2ZkMCBvZj0v
ZGV2L251bGwgYnM9MWsgY291bnQ9MSAyPi9kZXYvbnVsbCA7DQogICAgdGhl
bg0KICAgICAgIGVjaG8gIkZsb3BweSBkcml2ZSBlcnJvciEiDQogICAgICAg
ZWNobyAiTWF5YmUgbm8gZGlza2V0dGUgaW4gdGhlIGRyaXZlPyINCiAgICAg
ICBleGl0IDENCmZpDQojDQojICBNYWtlIGEgbGl0dGxlIHByb2dyYW0gY2Fs
bGVkIG1vZHByb2JlLiBUaGlzIGp1c3QgcmV0dXJucyAwLg0KIw0KZWNobyAi
aW50IG1haW4oKXsiPiR7VE1QQ30NCmVjaG8gInJldHVybiAwO30iPj4ke1RN
UEN9DQpnY2MgLU8yIC1vIG1vZHByb2JlICR7VE1QQ30gLXN0YXRpYw0Kc3Ry
aXAgbW9kcHJvYmUgDQpybSAke1RNUEN9DQojDQojICBNYWtlIGEgbGl0dGxl
IHByb2dyYW0gY2FsbGVkIGluaXQuIFRoaXMganVzdCBwcmludHMgYSBtb3Zp
bmcgbWVzc2FnZSBhbmQNCiMgIHdhaXRzIGZvcmV2ZXIuDQojDQplY2hvICIj
aW5jbHVkZSA8c3RkaW8uaD4iPiR7VE1QQ30NCmVjaG8gIm1haW4oKXsiPj4k
e1RNUEN9DQplY2hvICJpbnQgciwgYzsiPj4ke1RNUEN9DQplY2hvICJmb3Io
OzspeyI+PiR7VE1QQ30NCmVjaG8gInI9cmFuZCgpJTI1O2M9cmFuZCgpJTY4
O3ByaW50ZihcIlwwMzNbJWQ7JWRIIFdvcmtpbmchIFwiLCByLCBjKTsiPj4k
e1RNUEN9DQplY2hvICJmZmx1c2goc3Rkb3V0KTt1c2xlZXAoNTAwMDAwKTsi
Pj4ke1RNUEN9DQplY2hvICJwcmludGYoXCJcMDMzWyVkOyVkSCAgICAgICAg
ICBcIixyLGMpO2ZmbHVzaChzdGRvdXQpOyI+PiR7VE1QQ30NCmVjaG8gIn19
Ij4+JHtUTVBDfQ0KZ2NjIC1PMiAtbyBpbml0ICR7VE1QQ30gLXN0YXRpYw0K
c3RyaXAgaW5pdA0Kcm0gJHtUTVBDfQ0KIw0KIyAgTWFrZSBhIFJBTSBEaXNr
IGZpbGUgYW5kIG1vdW50IGl0IHVzaW5nIHRoZSBsb29wIGRldmljZS4NCiMg
IFJlbW92ZSB0aGUgbG9zdCtmb3VuZCBkaXJlY3RvcnkgdG8gc2F2ZSBzcGFj
ZS4NCiMNCnVtb3VudCAke1JBTURJU0t9IDI+L2Rldi9udWxsDQpybSAtcmYg
JHtSQU1ESVNLfSAyPi9kZXYvbnVsbA0KbWtkaXIgICR7UkFNRElTS30gMj4v
ZGV2L251bGwNCmRkIGlmPS9kZXYvemVybyBvZj0ke1JBTURJU0tfSU1BR0V9
IGJzPTFrIGNvdW50PSR7RElTS1NJWkV9DQovc2Jpbi9ta2UyZnMgLUZxICR7
UkFNRElTS19JTUFHRX0gJHtESVNLU0laRX0NCm1vdW50IC1vIGxvb3AgLXQg
ZXh0MiAke1JBTURJU0tfSU1BR0V9ICR7UkFNRElTS30NCnJtZGlyICR7UkFN
RElTS30vbG9zdCtmb3VuZA0KIw0KIyAgTWFrZSB0aGUgcmVxdWlyZWQgZGly
ZWN0b3JpZXMgaW4gdGhlIFJBTSBEaXNrLg0KIw0KbWtkaXIgLW0gNzc3ICR7
UkFNRElTS30vZGV2DQpta2RpciAtbSA3NzcgJHtSQU1ESVNLfS9ldGMNCm1r
ZGlyIC1tIDc3NyAke1JBTURJU0t9L2xpYg0KbWtkaXIgLW0gNzc3ICR7UkFN
RElTS30vdXNyDQpta2RpciAtbSA3NzcgJHtSQU1ESVNLfS91c3IvbG9jYWwN
Cm1rZGlyIC1tIDc3NyAke1JBTURJU0t9L2Jpbg0KbWtkaXIgLW0gNzc3ICR7
UkFNRElTS30vc2Jpbg0KbWtkaXIgLW0gNzc3ICR7UkFNRElTS30vdG1wDQpt
a2RpciAtbSA3NzcgJHtSQU1ESVNLfS9wcm9jDQojDQojICBNYWtlIHRoZSBy
ZXF1aXJlZCBkZXZpY2VzLg0KIw0KbWtub2QgJHtSQU1ESVNLfS9kZXYvbnVs
bCAgIGMgMSAzDQpta25vZCAke1JBTURJU0t9L2Rldi9yYW0wICAgYiAxIDAg
DQpta25vZCAke1JBTURJU0t9L2Rldi9yYW0xICAgYiAxIDENCm1rbm9kICR7
UkFNRElTS30vZGV2L21lbSAgICBjIDEgMQ0KbWtub2QgJHtSQU1ESVNLfS9k
ZXYvdHR5UzAgIGMgNCA2NCANCm1rbm9kICR7UkFNRElTS30vZGV2L3R0eTAg
ICBjIDQgMA0KbWtub2QgJHtSQU1ESVNLfS9kZXYvdHR5MSAgIGMgNCAxDQpt
a25vZCAke1JBTURJU0t9L2Rldi90dHkyICAgYyA0IDINCm1rbm9kICR7UkFN
RElTS30vZGV2L3R0eTMgICBjIDQgMw0KbWtub2QgJHtSQU1ESVNLfS9kZXYv
dHR5NCAgIGMgNCA0DQpta25vZCAke1JBTURJU0t9L2Rldi90dHkgICAgYyA1
IDANCm1rbm9kICR7UkFNRElTS30vZGV2L3R0eXAwICBjIDMgMA0KbWtub2Qg
JHtSQU1ESVNLfS9kZXYvdHR5cDEgIGMgMyAxIA0KbWtub2QgJHtSQU1ESVNL
fS9kZXYvdHR5cDIgIGMgMyAyIA0KbWtub2QgJHtSQU1ESVNLfS9kZXYvdHR5
cDMgIGMgMyAzIA0KbWtub2QgJHtSQU1ESVNLfS9kZXYvdHR5cDQgIGMgMyA0
IA0KbWtub2QgJHtSQU1ESVNLfS9kZXYvdHR5cDUgIGMgMyA1IA0KbWtub2Qg
JHtSQU1ESVNLfS9kZXYvcHR5cDAgIGMgMiAwIA0KbWtub2QgJHtSQU1ESVNL
fS9kZXYvcHR5cDEgIGMgMiAxIA0KbWtub2QgJHtSQU1ESVNLfS9kZXYvcHR5
cDIgIGMgMiAyIA0KbWtub2QgJHtSQU1ESVNLfS9kZXYvcHR5cDMgIGMgMiAz
IA0KbWtub2QgJHtSQU1ESVNLfS9kZXYvcHR5cDQgIGMgMiA0IA0KbWtub2Qg
JHtSQU1ESVNLfS9kZXYvcHR5cDUgIGMgMiA1IA0KbWtub2QgJHtSQU1ESVNL
fS9kZXYvemVybyAgIGMgMSA1DQojDQojICBTZXQgc29tZSBjb21wYXRpYmls
aXR5IGxpbmtzLg0KIw0KbG4gLXMgL2Rldi90dHkwCQkJCSR7UkFNRElTS30v
ZGV2L3N5c3R0eQ0KbG4gLXMgL2Rldi90dHkwCQkJCSR7UkFNRElTS30vZGV2
L2NvbnNvbGUNCmxuIC1zIC9kZXYvcmFtMQkJCQkke1JBTURJU0t9L2Rldi9y
YW0NCmxuIC1zIC9saWIJCQkJJHtSQU1ESVNLfS91c3IvbGliDQpsbiAtcyAv
bGliCQkJCSR7UkFNRElTS30vdXNyL2xvY2FsL2xpYg0KIw0KIw0KIyAgQ29w
eSB0aGUgZmlsZXMgYW5kIGxpYnJhcmllcy4gQWxsIG9mIHRoZSBmaWxlcyBh
cmUgc3RyaXBwZWQNCiMgIHRvIHNhdmUgc3BhY2UuDQojDQpjcCBtb2Rwcm9i
ZQkJCQkke1JBTURJU0t9L3NiaW4vbW9kcHJvYmUNCmNwIGluaXQgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAke1JBTURJU0t9L3NiaW4vaW5p
dA0KIw0KIw0KIyAgVW5tb3VudCB0aGUgUkFNIERpc2suIFJlbW92ZSBpdHMg
bW91bnQtcG9pbnQgYnV0IHNhdmUgdGhlIGZpbGUgaXRzZWxmLiANCiMNCnN5
bmMNCmRmCSR7UkFNRElTS30NCnVtb3VudAkke1JBTURJU0t9DQpybWRpcgkk
e1JBTURJU0t9DQpzeW5jDQojDQojICAgTWFrZSBhbiBleHQyIGZpbGUtc3lz
dGVtIG9uIGEgZmxvcHB5IGFuZCBtb3VudCBpdC4gUmVtb3ZlIHRoZQ0KIyAg
IGxvc3QrZm91bmQgZGlyZWN0b3J5IHRvIHNhdmUgc3BhY2UuDQojDQp1bW91
bnQgL21udCAyPi9kZXYvbnVsbA0KL3NiaW4vbWtlMmZzIC1xIC9kZXYvZmQw
DQptb3VudCAtdCBleHQyIC9kZXYvZmQwIC9tbnQNCnJtZGlyIC9tbnQvbG9z
dCtmb3VuZA0KIw0KIyAgQ29tcHJlc3MgdGhlIFJBTSBEaXNrIGltYWdlIGlu
dG8gYSBmaWxlIG9uIHRoZSBtb3VudGVkIGZpbGUtc3lzdGVtLg0KIyAgUmVt
b3ZlIHRoZSBvcmlnaW5hbCBSQU0gRGlzayBpbWFnZSwgdGhlbiBjb3B5IHRo
ZSByZXF1aXJlZCBib290DQojICBmaWxlcyB0byB0aGUgbW91bnRlZCBmaWxl
LXN5c3RlbSBhbHNvLg0KIw0KZ3ppcCA8ICR7UkFNRElTS19JTUFHRX0gPi9t
bnQvaW5pdHJkLSR7VkVSfQ0Kcm0gJHtSQU1ESVNLX0lNQUdFfQ0KY3AgJHtT
WVN9IC9tbnQvdm1saW51ei0ke1ZFUn0NCmNwIC9ib290L2Jvb3QuYiAvbW50
L2Jvb3QuYg0KIw0KIyAgTm93IGV4ZWN1dGUgbGlsbyB0byBpbnN0YWxsIHRo
ZSBib290LWxvYWRlciBvbnRvIHRoZSBtb3VudGVkIGZpbGUtDQojICBzeXN0
ZW0uIExpbG8gYWxsb3dzIGl0cyBjb25maWd1cmF0aW9uIHRvIGJlIHRha2Vu
IGZyb20gc3RhbmRhcmQgaW5wdXQuDQojDQovc2Jpbi9saWxvIC1DIC0gPDxF
T0YNCiMNCiMgIExpbG8gYm9vdC1jb25maWd1cmF0aW9uIHNjcmlwdC4NCiMN
CmJvb3QgICAgPSAvZGV2L2ZkMA0KbWFwICAgICA9IC9tbnQvbWFwDQpiYWNr
dXAgID0gL2Rldi9udWxsDQpjb21wYWN0DQp2Z2EgPSBub3JtYWwJIyBmb3Jj
ZSBzYW5lIHN0YXRlDQogaW5zdGFsbCA9IC9tbnQvYm9vdC5iDQogaW1hZ2Ug
ICA9IC9tbnQvdm1saW51ei0ke1ZFUn0NCiBpbml0cmQgID0gL21udC9pbml0
cmQtJHtWRVJ9DQogcm9vdCAgICA9IC9kZXYvcmFtMCANCiBsYWJlbCAgID0g
VGVzdC1SQU1ESVNLIA0KRU9GDQojDQojICBTaG93IHRoZSByZXN1bHRzIGFu
ZCB1bm1vdW50IHRoZSBmaWxlLXN5c3RlbS4NCiMNCmRmIC9kZXYvZmQwDQp1
bW91bnQgL2Rldi9mZDANCiMNCg==
--1678434306-425895735-1015010566=:5981--
