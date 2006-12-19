Return-Path: <linux-kernel-owner+w=401wt.eu-S932940AbWLSUwp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932940AbWLSUwp (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 15:52:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932936AbWLSUwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 15:52:45 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:30414 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932940AbWLSUwo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 15:52:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type;
        b=Jo7Gk8h7qCqkDFV7Wkm/cTe+RczQlqsmR97CaySGdbOB3lpZX5ZPm60vqrDFxJJZKs9dDovwp14eBVzvXizbEuZ2H81dV5/qlrkKxH8q1uqNAMIFhuHTYprI0P2Y/8+jKZf22uBcfPjd0WZz+ON3Z0Kzl0zvyxTX5pPlgYxbHg8=
Message-ID: <3efb10970612191252m33e7b88cydca7fb488251ee35@mail.gmail.com>
Date: Tue, 19 Dec 2006 21:52:42 +0100
From: "Remy Bohmer" <l.pinguin@gmail.com>
Reply-To: linux@bohmer.net
To: "Ingo Molnar" <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: [BUG+PATCH] RT-Preempt: IRQ threads running at prio 0 SCHED_OTHER
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_9230_27233770.1166561562880"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_9230_27233770.1166561562880
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello Ingo,

I am using your yum-distributed kernel 2.6.19.1-rt15, and
unfortunately I experienced very worse latencies.
It turned out that ALL the IRQ threads were all running at prio 0, SCHED_OT=
HER.

Looking at the current code in kernel/irq/manage.c, the goal was to
put them at MAX_RT_PRIO, but the call to sys_sched_setscheduler()
fails with EINVAL. I have attached a patch to set them to
(MAX_RT_PRIO-1). This works.

Further I believe that each application of the RT-kernel requires a
different configuration of these thread-priorities and I prefer to
reconfigure these prios from userland during boot. As these
threadnames contain whitespaces in its name, they make the
shell-scripts unnecessary complex that I use to reconfigure the thread
priorities.
So, I would prefer a slight modification of the names: The attached
patch also changes the names from [IRQ nn] to [IRQ-nn]. I hope that
you agree with me here. (If not, I stick to do this patch each time
myself ;-) )

Kind Regards,

Remy B=F6hmer

------=_Part_9230_27233770.1166561562880
Content-Type: application/octet-stream; 
	name=fix-kernel-irq-thread-prio.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_evwsh4i8
Content-Disposition: attachment; filename="fix-kernel-irq-thread-prio.patch"

LS0tIGxpbnV4LTIuNi4xOS5pNjg2L2tlcm5lbC9pcnEvbWFuYWdlLmMub3JpZwkyMDA2LTEyLTE4
IDIyOjU5OjU5LjAwMDAwMDAwMCArMDEwMAorKysgbGludXgtMi42LjE5Lmk2ODYva2VybmVsL2ly
cS9tYW5hZ2UuYwkyMDA2LTEyLTE5IDIxOjIyOjA5LjAwMDAwMDAwMCArMDEwMApAQCAtNjkyLDkg
KzY5Miw5IEBACiAJY3VycmVudC0+ZmxhZ3MgfD0gUEZfTk9GUkVFWkUgfCBQRl9IQVJESVJROwog
CiAJLyoKLQkgKiBTY2FsZSBpcnEgdGhyZWFkIHByaW9yaXRpZXMgZnJvbSBwcmlvIDUwIHRvIHBy
aW8gMjUKKwkgKiBTY2FsZSBpcnEgdGhyZWFkIHByaW9yaXRpZXMgdG8gcHJpbyA5OQogCSAqLwot
CXBhcmFtLnNjaGVkX3ByaW9yaXR5ID0gTUFYX1JUX1BSSU87CisJcGFyYW0uc2NoZWRfcHJpb3Jp
dHkgPSBNQVhfUlRfUFJJTy0xOwogCiAJc3lzX3NjaGVkX3NldHNjaGVkdWxlcihjdXJyZW50LT5w
aWQsIFNDSEVEX0ZJRk8sICZwYXJhbSk7CiAKQEAgLTcyNSw3ICs3MjUsNyBAQAogCWlmIChkZXNj
LT50aHJlYWQgfHwgIW9rX3RvX2NyZWF0ZV9pcnFfdGhyZWFkcykKIAkJcmV0dXJuIDA7CiAKLQlk
ZXNjLT50aHJlYWQgPSBrdGhyZWFkX2NyZWF0ZShkb19pcnFkLCBkZXNjLCAiSVJRICVkIiwgaXJx
KTsKKwlkZXNjLT50aHJlYWQgPSBrdGhyZWFkX2NyZWF0ZShkb19pcnFkLCBkZXNjLCAiSVJRLSVk
IiwgaXJxKTsKIAlpZiAoIWRlc2MtPnRocmVhZCkgewogCQlwcmludGsoS0VSTl9FUlIgImlycWQ6
IGNvdWxkIG5vdCBjcmVhdGUgSVJRIHRocmVhZCAlZCFcbiIsIGlycSk7CiAJCXJldHVybiAtRU5P
TUVNOwo=
------=_Part_9230_27233770.1166561562880--
