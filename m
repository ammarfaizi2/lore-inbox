Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263058AbTHVIwQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 04:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263060AbTHVIuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 04:50:51 -0400
Received: from fmr06.intel.com ([134.134.136.7]:9966 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S263065AbTHVIZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 04:25:25 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C36885.86339BC0"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: Is it a bug (about share memory)?
Date: Fri, 22 Aug 2003 16:15:18 +0800
Message-ID: <37FBBA5F3A361C41AB7CE44558C3448E011958E9@pdsmsx403.ccr.corp.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: Is it a bug (about share memory)?
Thread-Index: AcNohYRpnEIdEybpQhaxVxAbwm7JEw==
From: "Zheng, Jeff" <jeff.zheng@intel.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 22 Aug 2003 08:15:18.0964 (UTC) FILETIME=[864D0740:01C36885]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C36885.86339BC0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable

Hi,

I tried to use share memory to check vm overcommit by check Committed_AS =
in /proc/meminfo. It seems that attach of share momory will add the =
value of Committed_AS but detach of share memory does not reduce the =
value of Committed_AS. Below is the result (attached file is source of =
the command)
[root@hpi overcommit_basic]# ./shm 5000000 m
The value of Committed_AS is 100436 KB before attach
The value of Committed_AS is 105384 KB After attach
[root@hpi overcommit_basic]# ./shm 5000000 m
The value of Committed_AS is 105520 KB before attach
The value of Committed_AS is 105520 KB After attach
[root@hpi overcommit_basic]# ./shm 5000000 n
The value of Committed_AS is 105416 KB before attach
The value of Committed_AS is 110364 KB After attach

the first parm is size of share memory, the second parm is proj of API =
ftok. When I allocate 5M, Committed_AS add 5M. The issue is: when I =
detach the share memory, and there is no other process attach to the =
share memory, Committed_AS does not reduce 5M.

Inactive of /proc/meminfo also changed.

My kernel is 2.5.70. And it seems that all kernel is the same.


Thanks
Jeff                        Jeff.Zheng@intel.com
BTW, I speak for myself, not for Intel Corp.

------_=_NextPart_001_01C36885.86339BC0
Content-Type: application/octet-stream;
	name="shm.c"
Content-Transfer-Encoding: base64
Content-Description: shm.c
Content-Disposition: attachment;
	filename="shm.c"

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzdGRsaWIuaD4KI2luY2x1ZGUgPHN0cmluZy5o
PgojaW5jbHVkZSA8c3lzL3R5cGVzLmg+CiNpbmNsdWRlIDxzeXMvaXBjLmg+CiNpbmNsdWRlIDxz
eXMvc2htLmg+CgojZGVmaW5lIFNITV9TSVpFIDEwMjQgIC8qIG1ha2UgaXQgYSAxSyBzaGFyZWQg
bWVtb3J5IHNlZ21lbnQgKi8KCmludCBHZXRWYWx1ZShjaGFyICpuKSB7CiAgIGNoYXIgc1syMDBd
LCpwOwogICBGSUxFICpmOwogICBpbnQgdmFsdWUsbGVuOwogICBmPWZvcGVuKCIvcHJvYy9tZW1p
bmZvIiwgInIiKTsKICAgd2hpbGUgKChwPWZnZXRzKHMsIDIwMCwgZikpICE9IE5VTEwpIHsKCSAg
IGxlbj1zdHJsZW4obik7CgkgICBpZiAoc3RybmNtcChuLCBwLCBsZW4pPT0wKSB7CgkJICAgcCs9
bGVuKzE7CgkJICAgd2hpbGUgKGlzc3BhY2UoKnApKSBwKys7CgkJICAgdmFsdWU9YXRvbChwKTsK
CQkgICBmY2xvc2UoZik7CgkJICAgcmV0dXJuKHZhbHVlKTsKCSAgIH0KICAgfQogICBmY2xvc2Uo
Zik7CiAgIHJldHVybiAwOwp9CgppbnQgbWFpbihpbnQgYXJnYywgY2hhciAqYXJndltdKQp7CiAg
ICBrZXlfdCBrZXk7CiAgICBpbnQgc2htaWQ7CiAgICBjaGFyICpkYXRhLCpwOwogICAgaW50IG1v
ZGU7CiAgICBpbnQgbWVtc2l6ZSxjb21taXR0ZWRfYXM7CiAgICBpbnQgaTsKCiAgICBpZiAoYXJn
YyA+IDMpIHsKICAgICAgICBmcHJpbnRmKHN0ZGVyciwgInVzYWdlOiBzaG1kZW1vIFtkYXRhX3Rv
X3dyaXRlXSBbcHJval9vZl9mdG9rXVxuIik7CiAgICAgICAgZXhpdCgxKTsKICAgIH0KICAgIAog
ICAgY29tbWl0dGVkX2FzPUdldFZhbHVlKCJDb21taXR0ZWRfQVMiKTsKICAgIHByaW50ZigiVGhl
IHZhbHVlIG9mIENvbW1pdHRlZF9BUyBpcyAlZCBLQiBiZWZvcmUgYXR0YWNoXG4iLCBjb21taXR0
ZWRfYXMpOwogICAgbWVtc2l6ZSA9IGF0b2woYXJndlsxXSk7CiAgICAvKiBtYWtlIHRoZSBrZXk6
ICovCiAgICBpZiAoKGtleSA9IGZ0b2soIi90bXAvc2htLnRtcCIsICphcmd2WzJdKSkgPT0gLTEp
IHsKICAgICAgICBwZXJyb3IoImZ0b2siKTsKICAgICAgICBleGl0KDEpOwogICAgfQoKICAgIC8q
IGNvbm5lY3QgdG8gKGFuZCBwb3NzaWJseSBjcmVhdGUpIHRoZSBzZWdtZW50OiAqLwogICAgaWYg
KChzaG1pZCA9IHNobWdldChrZXksIG1lbXNpemUsIDA2NDQgfCBJUENfQ1JFQVQpKSA9PSAtMSkg
ewogICAgICAgIHBlcnJvcigic2htZ2V0Iik7CiAgICAgICAgZXhpdCgxKTsKICAgIH0KCiAgICAv
KiBhdHRhY2ggdG8gdGhlIHNlZ21lbnQgdG8gZ2V0IGEgcG9pbnRlciB0byBpdDogKi8KICAgIHAg
PSBkYXRhID0gc2htYXQoc2htaWQsICh2b2lkICopMCwgMCk7CiAgICBpZiAoZGF0YSA9PSAoY2hh
ciAqKSgtMSkpIHsKICAgICAgICBwZXJyb3IoInNobWF0Iik7CiAgICAgICAgZXhpdCgxKTsKICAg
IH0KICAgIGZvciAoaT0wOyBpPCBtZW1zaXplLTEwOyBpKyspCgkgICAgKnArKyA9ICdhJzsKCiAg
ICBjb21taXR0ZWRfYXM9R2V0VmFsdWUoIkNvbW1pdHRlZF9BUyIpOwogICAgcHJpbnRmKCJUaGUg
dmFsdWUgb2YgQ29tbWl0dGVkX0FTIGlzICVkIEtCIEFmdGVyIGF0dGFjaFxuIiwgY29tbWl0dGVk
X2FzKTsKICAgIC8qIGRldGFjaCBmcm9tIHRoZSBzZWdtZW50OiAqLwogICAgaWYgKHNobWR0KGRh
dGEpID09IC0xKSB7CiAgICAgICAgcGVycm9yKCJzaG1kdCIpOwogICAgICAgIGV4aXQoMSk7CiAg
ICB9CgogICAgcmV0dXJuIDA7Cn0KCgo=

------_=_NextPart_001_01C36885.86339BC0--
