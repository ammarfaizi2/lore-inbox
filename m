Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262437AbVESBVR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262437AbVESBVR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 21:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262440AbVESBVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 21:21:17 -0400
Received: from fmr19.intel.com ([134.134.136.18]:8376 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S262437AbVESBVK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 21:21:10 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C55C11.0859DAC7"
Subject: 32bit processes at compatbility mode on x86_64 machines fail to restart syscall after processing a signal
Date: Thu, 19 May 2005 09:18:59 +0800
Message-ID: <8126E4F969BA254AB43EA03C59F44E84021E9C58@pdsmsx404>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: 32bit processes at compatbility mode on x86_64 machines fail to restart syscall after processing a signal
Thread-Index: AcVcELwcI2AK7Nv9QCuZqlKSgRbZJQ==
From: "Zhang, Yanmin" <yanmin.zhang@intel.com>
To: <discuss@x86-64.org>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 19 May 2005 01:21:07.0917 (UTC) FILETIME=[08A52FD0:01C55C11]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C55C11.0859DAC7
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

The test case at
http://cvs.sourceforge.net/viewcvs.py/posixtest/posixtestsuite/conforman
ce/interfaces/clock_nanosleep/1-5.c fails if it runs as a 32bit process
on x86_86 machines.

The root cause is the sub 32bit process fails to restart the syscall
after it is interrupted
by a signal.

The syscall number of sys_restart_syscall in table sys_call_table is=20
__NR_restart_syscall (219) while it's __NR_ia32_restart_syscall (0) in
ia32_sys_call_table. When regs->rax=3D=3D(unsigned
long)-ERESTART_RESTARTBLOCK,
function do_signal doesn't distinguish if the process is 64bit or 32bit,
and always sets
restart syscall number as __NR_restart_syscall (219).

Here is a patch against kernel 2.6.12-rc4.

Signed-off-by: Zhang Yanmin <yanmin.zhang@intel.com>



------_=_NextPart_001_01C55C11.0859DAC7
Content-Type: application/octet-stream;
	name="32bit_process_fail_restart_syscall.patch"
Content-Transfer-Encoding: base64
Content-Description: 32bit_process_fail_restart_syscall.patch
Content-Disposition: attachment;
	filename="32bit_process_fail_restart_syscall.patch"

ZGlmZiAtTnJhdXAgbGludXgtMi42LjEyLXJjNC9hcmNoL3g4Nl82NC9rZXJuZWwvc2lnbmFsLmMg
bGludXgtMi42LjEyLXJjNF9maXgvYXJjaC94ODZfNjQva2VybmVsL3NpZ25hbC5jCi0tLSBsaW51
eC0yLjYuMTItcmM0L2FyY2gveDg2XzY0L2tlcm5lbC9zaWduYWwuYwkyMDA1LTA1LTEyIDIyOjE5
OjQwLjAwMDAwMDAwMCAtMDcwMAorKysgbGludXgtMi42LjEyLXJjNF9maXgvYXJjaC94ODZfNjQv
a2VybmVsL3NpZ25hbC5jCTIwMDUtMDUtMTggMDk6NTc6MDAuMDAwMDAwMDAwIC0wNzAwCkBAIC00
NTIsNyArNDUyLDEwIEBAIGludCBkb19zaWduYWwoc3RydWN0IHB0X3JlZ3MgKnJlZ3MsIHNpZ3MK
IAkJCXJlZ3MtPnJpcCAtPSAyOwogCQl9CiAJCWlmIChyZWdzLT5yYXggPT0gKHVuc2lnbmVkIGxv
bmcpLUVSRVNUQVJUX1JFU1RBUlRCTE9DSykgewotCQkJcmVncy0+cmF4ID0gX19OUl9yZXN0YXJ0
X3N5c2NhbGw7CisJCQlpZiAodGVzdF90aHJlYWRfZmxhZyhUSUZfSUEzMikpCisJCQkJcmVncy0+
cmF4ID0gX19OUl9pYTMyX3Jlc3RhcnRfc3lzY2FsbDsKKwkJCWVsc2UKKwkJCQlyZWdzLT5yYXgg
PSBfX05SX3Jlc3RhcnRfc3lzY2FsbDsKIAkJCXJlZ3MtPnJpcCAtPSAyOwogCQl9CiAJfQo=

------_=_NextPart_001_01C55C11.0859DAC7--
