Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267553AbTACPZl>; Fri, 3 Jan 2003 10:25:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267550AbTACPZl>; Fri, 3 Jan 2003 10:25:41 -0500
Received: from ligur.expressz.com ([212.24.178.154]:40654 "EHLO expressz.com")
	by vger.kernel.org with ESMTP id <S267547AbTACPZh>;
	Fri, 3 Jan 2003 10:25:37 -0500
Date: Fri, 3 Jan 2003 16:34:07 +0100 (CET)
From: "BODA Karoly jr." <woockie@expressz.com>
To: sparclinux@vger.kernel.org
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.5.54-sparc64 compile errors
In-Reply-To: <Mutt.LNX.4.44.0301040101070.17638-100000@blackbird.intercode.com.au>
Message-ID: <Pine.LNX.3.96.1030103155904.5497A-200000@ligur.expressz.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="416586418-12483141-1041608047=:5497"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--416586418-12483141-1041608047=:5497
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Sat, 4 Jan 2003, James Morris wrote:

> kernel.h.  A patch below resolves this for sparc64 by not including some

	Thank you, it worked. Here is my "patch" which makes almost
compile the source... (I've tried only sparc64) But linking is not
correct, here is the errormessage:

        ld -m elf64_sparc -T arch/sparc64/vmlinux.lds.s
arch/sparc64/kernel/head.o arch/sparc64/kernel/init_task.o
init/built-in.o --start-group  usr/built-in.o
arch/sparc64/kernel/built-in.o  arch/sparc64/mm/built-in.o
arch/sparc64/solaris/built-in.o
arch/sparc64/math-emu/built-in.o  kernel/built-in.o  mm/built-in.o
fs/built-in.o  ipc/built-in.o  security/built-in.o  crypto/built-in.o
lib/lib.a  arch/sparc64/prom/lib.a  arch/sparc64/lib/lib.a
drivers/built-in.o  sound/built-in.o  net/built-in.o --end-group  -o
vmlinux
arch/sparc64/solaris/built-in.o(.text+0xb4): In function `entry64_personality_patch':
: undefined reference to `TI_FLAGS'
arch/sparc64/solaris/built-in.o(.text+0xb4): In function `entry64_personality_patch':
: relocation truncated to fit: R_SPARC_13 TI_FLAGS
arch/sparc64/solaris/built-in.o(.text+0xdc): In function `entry64_personality_patch':
: undefined reference to `_TIF_SYSCALL_TRACE'
arch/sparc64/solaris/built-in.o(.text+0xdc): In function `entry64_personality_patch':
: relocation truncated to fit: R_SPARC_13 _TIF_SYSCALL_TRACE
arch/sparc64/solaris/built-in.o(.text+0xf4): In function `ret_from_solaris':
: undefined reference to `TI_FLAGS'
arch/sparc64/solaris/built-in.o(.text+0xf4): In function `ret_from_solaris':
: relocation truncated to fit: R_SPARC_13 TI_FLAGS
arch/sparc64/solaris/built-in.o(.text+0x110): In function `ret_from_solaris':
: undefined reference to `_TIF_SYSCALL_TRACE'
arch/sparc64/solaris/built-in.o(.text+0x110): In function `ret_from_solaris':
: relocation truncated to fit: R_SPARC_13 _TIF_SYSCALL_TRACE
kernel/built-in.o(.data+0x1708): undefined reference to `hugetlb_sysctl_handler'
mm/built-in.o(.text+0xc67c): In function `unmap_page_range':
: undefined reference to `unmap_hugepage_range'
mm/built-in.o(.text+0xc7a0): In function `zap_page_range':
: undefined reference to `zap_hugepage_range'
fs/built-in.o(.text+0x320f0): In function `meminfo_read_proc':
: undefined reference to `hugetlb_report_meminfo'
drivers/built-in.o(.text+0x1af90): In function `kd_nosound':
: undefined reference to `input_event'
drivers/built-in.o(.text+0x1afb4): In function `kd_nosound':
: undefined reference to `input_event'
drivers/built-in.o(.text+0x1b090): In function `kd_mksound':
: undefined reference to `input_event'
drivers/built-in.o(.text+0x1b0a8): In function `kd_mksound':
: undefined reference to `input_event'
drivers/built-in.o(.text+0x1c364): In function `kbd_bh':
: undefined reference to `input_event'
drivers/built-in.o(.text+0x1c378): more undefined references to `input_event' follow
drivers/built-in.o(.text+0x1c990): In function `kbd_connect':
: undefined reference to `input_open_device'
drivers/built-in.o(.text+0x1c9a4): In function `kbd_disconnect':
: undefined reference to `input_close_device'
drivers/built-in.o(.init.text+0x2bec): In function `kbd_init':
: undefined reference to `input_register_handler'
make: *** [vmlinux] Error 1

	And one more error, if Stack Overflow Detection Support is checked
then the following errormessage comes:
sparc64-linux-gcc: -pg and -fomit-frame-pointer are incompatible



-- 
						Woockie
..."what is there in this world that makes living worthwhile?"
Death thought about it. "CATS," he said eventually, "CATS ARE NICE."
			           (Terry Pratchett, Sourcery)

--416586418-12483141-1041608047=:5497
Content-Type: TEXT/plain; name="2.5.54-sparc64.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.3.96.1030103163407.5497B@ligur.expressz.com>
Content-Description: 

ZGlmZiAtcnVOcCBhL2FyY2gvc3BhcmM2NC9LY29uZmlnIGIvYXJjaC9zcGFy
YzY0L0tjb25maWcNCi0tLSBhL2FyY2gvc3BhcmM2NC9LY29uZmlnCTIwMDMt
MDEtMDIgMDQ6MjM6MDEuMDAwMDAwMDAwICswMTAwDQorKysgYi9hcmNoL3Nw
YXJjNjQvS2NvbmZpZwkyMDAzLTAxLTAyIDE5OjA5OjUzLjAwMDAwMDAwMCAr
MDEwMA0KQEAgLTk4Niw3ICs5ODYsOCBAQCBjaG9pY2UNCiAJb3B0aW9uYWwN
CiAJZGVwZW5kcyBvbiBTQ1NJICYmIFBDSQ0KIA0KLXNvdXJjZSAiZHJpdmVy
cy9zY3NpL2FpYzd4eHgvS2NvbmZpZyINCitzb3VyY2UgImRyaXZlcnMvc2Nz
aS9haWM3eHh4L0tjb25maWcuYWljN3h4eCINCitzb3VyY2UgImRyaXZlcnMv
c2NzaS9haWM3eHh4L0tjb25maWcuYWljNzl4eCINCiANCiBjb25maWcgU0NT
SV9BSUM3WFhYX09MRA0KIAl0cmlzdGF0ZSAiT2xkIGRyaXZlciINCmRpZmYg
LXJ1TnAgYS9hcmNoL3NwYXJjNjQvTWFrZWZpbGUgYi9hcmNoL3NwYXJjNjQv
TWFrZWZpbGUNCi0tLSBhL2FyY2gvc3BhcmM2NC9NYWtlZmlsZQkyMDAzLTAx
LTAyIDA0OjIzOjE1LjAwMDAwMDAwMCArMDEwMA0KKysrIGIvYXJjaC9zcGFy
YzY0L01ha2VmaWxlCTIwMDMtMDEtMDMgMTY6MDI6MjcuMDAwMDAwMDAwICsw
MTAwDQpAQCAtNzQsNiArNzQsMTAgQEAgZHJpdmVycy0kKENPTkZJR19PUFJP
RklMRSkJKz0gYXJjaC9zcGFyYw0KIHRmdHBib290LmltZyB2bWxpbnV4LmFv
dXQ6DQogCSQoUSkkKE1BS0UpICQoYnVpbGQpPWFyY2gvc3BhcmM2NC9ib290
IGFyY2gvc3BhcmM2NC9ib290LyRADQogDQorYXJjaG1ycHJvcGVyOg0KK2Fy
Y2hjbGVhbjoNCisgICAgICAgJChRKSQoTUFLRSkgJChjbGVhbik9YXJjaC9z
cGFyYzY0L2Jvb3QNCisNCiBkZWZpbmUgYXJjaGhlbHANCiAgIGVjaG8gICcq
IHZtbGludXggICAgICAgLSBTdGFuZGFyZCBzcGFyYzY0IGtlcm5lbCcNCiAg
IGVjaG8gICcgIHZtbGludXguYW91dCAgLSBhLm91dCBrZXJuZWwgZm9yIHNw
YXJjNjQnDQpkaWZmIC1ydU5wIGEvaW5jbHVkZS9hc20tc3BhcmM2NC9zbXAu
aCBiL2luY2x1ZGUvYXNtLXNwYXJjNjQvc21wLmgNCi0tLSBhL2luY2x1ZGUv
YXNtLXNwYXJjNjQvc21wLmgJMjAwMy0wMS0wMiAwNDoyMTo0MC4wMDAwMDAw
MDAgKzAxMDANCisrKyBiL2luY2x1ZGUvYXNtLXNwYXJjNjQvc21wLmgJMjAw
My0wMS0wMyAxNTowMjozOC4wMDAwMDAwMDAgKzAxMDANCkBAIC03LDEzICs3
LDEzIEBADQogI2RlZmluZSBfU1BBUkM2NF9TTVBfSA0KIA0KICNpbmNsdWRl
IDxsaW51eC9jb25maWcuaD4NCi0jaW5jbHVkZSA8bGludXgvdGhyZWFkcy5o
Pg0KLSNpbmNsdWRlIDxsaW51eC9jYWNoZS5oPg0KICNpbmNsdWRlIDxhc20v
YXNpLmg+DQogI2luY2x1ZGUgPGFzbS9zdGFyZmlyZS5oPg0KICNpbmNsdWRl
IDxhc20vc3BpdGZpcmUuaD4NCiANCiAjaWZuZGVmIF9fQVNTRU1CTFlfXw0K
KyNpbmNsdWRlIDxsaW51eC90aHJlYWRzLmg+DQorI2luY2x1ZGUgPGxpbnV4
L2NhY2hlLmg+DQogLyogUFJPTSBwcm92aWRlZCBwZXItcHJvY2Vzc29yIGlu
Zm9ybWF0aW9uIHdlIG5lZWQNCiAgKiB0byBzdGFydCB0aGVtIGFsbCB1cC4N
CiAgKi8NCmRpZmYgLXJ1TnAgYS9pbmNsdWRlL2xpbnV4L2ludGVycnVwdC5o
IGIvaW5jbHVkZS9saW51eC9pbnRlcnJ1cHQuaA0KLS0tIGEvaW5jbHVkZS9s
aW51eC9pbnRlcnJ1cHQuaAkyMDAzLTAxLTAyIDA0OjIyOjE3LjAwMDAwMDAw
MCArMDEwMA0KKysrIGIvaW5jbHVkZS9saW51eC9pbnRlcnJ1cHQuaAkyMDAz
LTAxLTAyIDE5OjMyOjAxLjAwMDAwMDAwMCArMDEwMA0KQEAgLTUsNiArNSw3
IEBADQogI2luY2x1ZGUgPGxpbnV4L2NvbmZpZy5oPg0KICNpbmNsdWRlIDxs
aW51eC9saW5rYWdlLmg+DQogI2luY2x1ZGUgPGxpbnV4L2JpdG9wcy5oPg0K
KyNpbmNsdWRlIDxsaW51eC9jYWNoZS5oPg0KICNpbmNsdWRlIDxhc20vYXRv
bWljLmg+DQogI2luY2x1ZGUgPGFzbS9oYXJkaXJxLmg+DQogI2luY2x1ZGUg
PGFzbS9wdHJhY2UuaD4NCg==
--416586418-12483141-1041608047=:5497--
