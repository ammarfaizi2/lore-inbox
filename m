Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261867AbUCDMtZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 07:49:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261874AbUCDMtY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 07:49:24 -0500
Received: from kamikaze.scarlet-internet.nl ([213.204.195.165]:24512 "EHLO
	kamikaze.scarlet-internet.nl") by vger.kernel.org with ESMTP
	id S261867AbUCDMtV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 07:49:21 -0500
Message-ID: <1078404558.404725ceb404c@webmail.dds.nl>
Date: Thu,  4 Mar 2004 13:49:18 +0100
From: wdebruij@dds.nl
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.6.3 very small patch: libc compatibility for skbuff.h (userspace access to sk_buffs)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-MOQ107840455861b8c39926b57b3b3dbc59d412f53475"
User-Agent: Internet Messaging Program (IMP) 3.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format.

---MOQ107840455861b8c39926b57b3b3dbc59d412f53475
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

hi, 

  for a network monitoring application I needed access to sk_buff's from
userspace. The current linux/skbuff.h headerfile cannot be included from
userspace applications due to various kernel .h vs. libc .h clashes. 

I basically pruned the #include statements by inserting #ifdef _KERNEL__
statements until gcc started complaining. Therefore nothing has changed in the
kernelspace implementation. But this minor change makes it possible to include
linux/skbuff.h from userspace. 

Ideally, all the #ifdef __KERNEL__ secured headerfile references should be
removed, since it is clear that skbuff.h doesn't really rely on them. Perhaps
some .c file does, but I didn't feel like finding out which one.

cheers,

  Willem


---MOQ107840455861b8c39926b57b3b3dbc59d412f53475
Content-Type: application/octet-stream; name="linux-2.6.3-skbuff_userspace_patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux-2.6.3-skbuff_userspace_patch"

LS0tIGxpbnV4LTIuNi4zLW9yaWcvaW5jbHVkZS9saW51eC9za2J1ZmYuaAkyMDA0LTAyLTE4IDA0
OjU4OjI2LjAwMDAwMDAwMCArMDEwMAorKysgbGludXgtMi42LjMvaW5jbHVkZS9saW51eC9za2J1
ZmYuaAkyMDA0LTAzLTA0IDA5OjM2OjU1LjgyNzMxNjgwMCArMDEwMApAQCAtMTQsMTkgKzE0LDI4
IEBACiAjaWZuZGVmIF9MSU5VWF9TS0JVRkZfSAogI2RlZmluZSBfTElOVVhfU0tCVUZGX0gKIAor
I2lmZGVmIF9fS0VSTkVMX18KICNpbmNsdWRlIDxsaW51eC9jb25maWcuaD4KICNpbmNsdWRlIDxs
aW51eC9rZXJuZWwuaD4KICNpbmNsdWRlIDxsaW51eC9jb21waWxlci5oPgorI2VuZGlmCisKICNp
bmNsdWRlIDxsaW51eC90aW1lLmg+Ci0jaW5jbHVkZSA8bGludXgvY2FjaGUuaD4KIAorI2lmZGVm
IF9fS0VSTkVMX18KKyNpbmNsdWRlIDxsaW51eC9jYWNoZS5oPgogI2luY2x1ZGUgPGFzbS9hdG9t
aWMuaD4KICNpbmNsdWRlIDxhc20vdHlwZXMuaD4KKyNlbmRpZgorCiAjaW5jbHVkZSA8bGludXgv
c3BpbmxvY2suaD4KKworI2lmZGVmIF9fS0VSTkVMX18KICNpbmNsdWRlIDxsaW51eC9tbS5oPgog
I2luY2x1ZGUgPGxpbnV4L2hpZ2htZW0uaD4KICNpbmNsdWRlIDxsaW51eC9wb2xsLmg+CiAjaW5j
bHVkZSA8bGludXgvbmV0Lmg+CisjZW5kaWYKIAogI2RlZmluZSBIQVZFX0FMTE9DX1NLQgkJLyog
Rm9yIHRoZSBkcml2ZXJzIHRvIGtub3cgKi8KICNkZWZpbmUgSEFWRV9BTElHTkFCTEVfU0tCCS8q
IERpdHRvIDgpCQkgICAqLwo=

---MOQ107840455861b8c39926b57b3b3dbc59d412f53475--

