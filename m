Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262363AbSJLILq>; Sat, 12 Oct 2002 04:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262376AbSJLILq>; Sat, 12 Oct 2002 04:11:46 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:42213 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262363AbSJLILo>;
	Sat, 12 Oct 2002 04:11:44 -0400
Importance: Low
Sensitivity: 
To: Adrian Bunk <bunk@fs.tum.de>
Cc: stevef@smfhome1.austin.rr.com,
       <jfs-discussion@www-124.southbury.usf.ibm.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFC6A681F2.17CB3EAC-ON87256C50.002CC29B@boulder.ibm.com>
From: "Steven French" <sfrench@us.ibm.com>
Date: Sat, 12 Oct 2002 02:16:05 -0600
Subject: Re: [PATCH] rename debug_mem function in CIFS vfs in Linux v2.5.42 
X-MIMETrack: Serialize by Router on D03NM123/03/M/IBM(Release 5.0.10 |March 22, 2002) at
 10/12/2002 02:16:08 AM
MIME-Version: 1.0
Content-type: multipart/mixed; 
	Boundary="0__=08BBE6C3DFBF440B8f9e8a93df938690918c08BBE6C3DFBF440B"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0__=08BBE6C3DFBF440B8f9e8a93df938690918c08BBE6C3DFBF440B
Content-type: text/plain; charset=us-ascii



Attached is a patch (1.749 at bk://cifs.bkbits.net/linux-2.5-with-cifs) for
renaming the cifs vfs debug function that you noted can conflict in some
cases with a jfs debug function of the same name if jfs debugging is
enabled
(See attached file: cifs-rename-internal-debug-function.patch)
 asn1.c       |    2 +-
 cifs_debug.c |    2 +-
 cifs_debug.h |    2 +-
 connect.c    |    7 ++-----
 4 files changed, 5 insertions(+), 8 deletions(-)

Also patch 1.748 which fixes 64 compiler warnings in the cifs vfs and
removes an optional debug function whose name conflicted (print_status) was
also posted to bk://cifs.bkbits.net/linux-2.5-with-cifs earlier today.

Steve French
Senior Software Engineer
Linux Technology Center - IBM Austin
phone: 512-838-2294
email: sfrench@us.ibm.com


Adrian Bunk <bunk@fs.tum.de>@vger.kernel.org on 10/12/2002 02:23:03 AM

Sent by:    linux-kernel-owner@vger.kernel.org


To:    stevef@smfhome1.austin.rr.com,
       <jfs-discussion@www-124.southbury.usf.ibm.com>
cc:    Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject:    Re: Linux v2.5.42



On Fri, 11 Oct 2002, Linus Torvalds wrote:

>...
> Summary of changes from v2.5.41 to v2.5.42
> ============================================
>...
> <stevef@smfhome1.austin.rr.com>:
>   o Initial check in of cifs filesystem version 0.54 for Linux 2.5 (to
>     clean tree as one changeset)
>...


Both jfs and cifs ship a function called `dump_mem' causing the following
compile error when both are included:

<--  snip  -->

   ld -m elf_i386  -r -o fs/built-in.o ...
fs/jfs/built-in.o: In function `dump_mem':
fs/jfs/built-in.o(.text+0xe420): multiple definition of `dump_mem'
fs/cifs/built-in.o(.text+0x3af0): first defined here
make[1]: *** [fs/built-in.o] Error 1
make: *** [fs] Error 2

<--  snip  -->

cu
Adrian

--

"Is there not promise of rain?" Ling Tan asked suddenly out
of the darkness. There had been need of rain for many days.
"Only a promise," Lao Er said.
                                Pearl S. Buck - Dragon Seed

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/




--0__=08BBE6C3DFBF440B8f9e8a93df938690918c08BBE6C3DFBF440B
Content-type: application/octet-stream; 
	name="cifs-rename-internal-debug-function.patch"
Content-Disposition: attachment; filename="cifs-rename-internal-debug-function.patch"
Content-transfer-encoding: base64

ZGlmZiAtTnJ1IGEvZnMvY2lmcy9hc24xLmMgYi9mcy9jaWZzL2FzbjEuYwotLS0gYS9mcy9jaWZz
L2FzbjEuYwlTYXQgT2N0IDEyIDAzOjA0OjQ2IDIwMDIKKysrIGIvZnMvY2lmcy9hc24xLmMJU2F0
IE9jdCAxMiAwMzowNDo0NiAyMDAyCkBAIC00NTgsNyArNDU4LDcgQEAKIAl1bnNpZ25lZCBpbnQg
Y2xzLCBjb24sIHRhZywgb2lkbGVuLCByYzsKIAlpbnQgdXNlX250bG1zc3AgPSBGQUxTRTsKIAot
CWR1bXBfbWVtKCIgUmVjZWl2ZWQgU2VjQmxvYiAiLCBzZWN1cml0eV9ibG9iLCBsZW5ndGgpOwor
CS8qIGNpZnNfZHVtcF9tZW0oIiBSZWNlaXZlZCBTZWNCbG9iICIsIHNlY3VyaXR5X2Jsb2IsIGxl
bmd0aCk7ICovCiAKIAlhc24xX29wZW4oJmN0eCwgc2VjdXJpdHlfYmxvYiwgbGVuZ3RoKTsKIApk
aWZmIC1OcnUgYS9mcy9jaWZzL2NpZnNfZGVidWcuYyBiL2ZzL2NpZnMvY2lmc19kZWJ1Zy5jCi0t
LSBhL2ZzL2NpZnMvY2lmc19kZWJ1Zy5jCVNhdCBPY3QgMTIgMDM6MDQ6NDYgMjAwMgorKysgYi9m
cy9jaWZzL2NpZnNfZGVidWcuYwlTYXQgT2N0IDEyIDAzOjA0OjQ2IDIwMDIKQEAgLTMyLDcgKzMy
LDcgQEAKICNpbmNsdWRlICJjaWZzX2RlYnVnLmgiCiAKIHZvaWQKLWR1bXBfbWVtKGNoYXIgKmxh
YmVsLCB2b2lkICpkYXRhLCBpbnQgbGVuZ3RoKQorY2lmc19kdW1wX21lbShjaGFyICpsYWJlbCwg
dm9pZCAqZGF0YSwgaW50IGxlbmd0aCkKIHsKIAlpbnQgaSwgajsKIAlpbnQgKmludHB0ciA9IGRh
dGE7CmRpZmYgLU5ydSBhL2ZzL2NpZnMvY2lmc19kZWJ1Zy5oIGIvZnMvY2lmcy9jaWZzX2RlYnVn
LmgKLS0tIGEvZnMvY2lmcy9jaWZzX2RlYnVnLmgJU2F0IE9jdCAxMiAwMzowNDo0NiAyMDAyCisr
KyBiL2ZzL2NpZnMvY2lmc19kZWJ1Zy5oCVNhdCBPY3QgMTIgMDM6MDQ6NDYgMjAwMgpAQCAtMjMs
NyArMjMsNyBAQAogI2lmbmRlZiBfSF9DSUZTX0RFQlVHCiAjZGVmaW5lIF9IX0NJRlNfREVCVUcK
IAotdm9pZCBkdW1wX21lbShjaGFyICpsYWJlbCwgdm9pZCAqZGF0YSwgaW50IGxlbmd0aCk7Cit2
b2lkIGNpZnNfZHVtcF9tZW0oY2hhciAqbGFiZWwsIHZvaWQgKmRhdGEsIGludCBsZW5ndGgpOwog
ZXh0ZXJuIGludCB0cmFjZVNNQjsJCS8qIGZsYWcgd2hpY2ggZW5hYmxlcyB0aGUgZnVuY3Rpb24g
YmVsb3cgKi8KIHZvaWQgZHVtcF9zbWIoc3RydWN0IHNtYl9oZHIgKiwgaW50KTsKIApkaWZmIC1O
cnUgYS9mcy9jaWZzL2Nvbm5lY3QuYyBiL2ZzL2NpZnMvY29ubmVjdC5jCi0tLSBhL2ZzL2NpZnMv
Y29ubmVjdC5jCVNhdCBPY3QgMTIgMDM6MDQ6NDYgMjAwMgorKysgYi9mcy9jaWZzL2Nvbm5lY3Qu
YwlTYXQgT2N0IDEyIDAzOjA0OjQ2IDIwMDIKQEAgLTE2OCw3ICsxNjgsNyBAQAogCQkJfSBlbHNl
IGlmICh0ZW1wWzBdICE9IChjaGFyKSAwKSB7CiAJCQkJY0VSUk9SKDEsCiAJCQkJICAgICAgICgi
XG5Vbmtub3duIFJGQyAxMDAxIGZyYW1lIHJlY2VpdmVkIG5vdCAweDAwIG5vciAweDg1IikpOwot
CQkJCWR1bXBfbWVtKCIgUmVjZWl2ZWQgRGF0YSBpczogIiwgdGVtcCwgbGVuZ3RoKTsKKwkJCQlj
aWZzX2R1bXBfbWVtKCIgUmVjZWl2ZWQgRGF0YSBpczogIiwgdGVtcCwgbGVuZ3RoKTsKIAkJCQli
cmVhazsKIAkJCX0gZWxzZSB7CiAJCQkJaWYgKChsZW5ndGggIT0gc2l6ZW9mIChzdHJ1Y3Qgc21i
X2hkcikgLSAxKQpAQCAtNzU3LDggKzc1Nyw3IEBACiAgICAgICAgICAgICAgICAvKiBSZW1vdmVk
IGZvbGxvd2luZyBmZXcgbGluZXMgdG8gbm90IHNlbmQgb2xkIHN0eWxlIHBhc3N3b3JkIAogICAg
ICAgICAgICAgICAgICAgaGFzaCBldmVyIC0gZm9yIGJldHRlciBzZWN1cml0eSAqLwogCQkJICAg
LyogdG9VcHBlcihjaWZzX3NiLT5sb2NhbF9ubHMsIHBhc3N3b3JkX3dpdGhfcGFkKTsKLQkJCQkg
ICBTTUJlbmNyeXB0KHBhc3N3b3JkX3dpdGhfcGFkLCBjcnlwdEtleSxzZXNzaW9uX2tleSk7IAot
CQkJCSAgIGR1bXBfbWVtKCJcbkNJRlMgKFNhbWJhIGVuY3J5cHQpOiAiLCBzZXNzaW9uX2tleSxD
SUZTX1NFU1NJT05fS0VZX1NJWkUpOyAqLworCQkJCSAgIFNNQmVuY3J5cHQocGFzc3dvcmRfd2l0
aF9wYWQsIGNyeXB0S2V5LHNlc3Npb25fa2V5KTsgKi8KIAogCQkJCXJjID0gQ0lGU1Nlc3NTZXR1
cCh4aWQsIHBTZXNJbmZvLAogCQkJCQkJICAgdm9sdW1lX2luZm8udXNlcm5hbWUsCkBAIC05ODks
NyArOTg4LDYgQEAKIAogCXJjID0gU2VuZFJlY2VpdmUoeGlkLCBzZXMsIHNtYl9idWZmZXIsIHNt
Yl9idWZmZXJfcmVzcG9uc2UsCiAJCQkgJmJ5dGVzX3JldHVybmVkLCAxKTsKLQkvKiBkdW1wX21l
bSgiXG5TZXNzU2V0dXAgcmVzcG9uc2UgaXM6ICIsIHNtYl9idWZmZXJfcmVzcG9uc2UsIDkyKTsq
LwogCWlmIChyYykgewogLyogcmMgPSBtYXBfc21iX3RvX2xpbnV4X2Vycm9yKHNtYl9idWZmZXJf
cmVzcG9uc2UpOyBub3cgZG9uZSBpbiBTZW5kUmVjZWl2ZSAqLwogCX0gZWxzZSBpZiAoKHNtYl9i
dWZmZXJfcmVzcG9uc2UtPldvcmRDb3VudCA9PSAzKQpAQCAtMTIzNSw3ICsxMjMzLDYgQEAKIAog
CXJjID0gU2VuZFJlY2VpdmUoeGlkLCBzZXMsIHNtYl9idWZmZXIsIHNtYl9idWZmZXJfcmVzcG9u
c2UsCiAJCQkgJmJ5dGVzX3JldHVybmVkLCAxKTsKLQkvKiBkdW1wX21lbSgiXG5TZXNzU2V0dXAg
cmVzcG9uc2UgaXM6ICIsIHNtYl9idWZmZXJfcmVzcG9uc2UsIDkyKTsgICovCiAJaWYgKHJjKSB7
CiAvKiAgICByYyA9IG1hcF9zbWJfdG9fbGludXhfZXJyb3Ioc21iX2J1ZmZlcl9yZXNwb25zZSk7
ICAqLy8qIGRvbmUgaW4gU2VuZFJlY2VpdmUgbm93ICovCiAJfSBlbHNlIGlmICgoc21iX2J1ZmZl
cl9yZXNwb25zZS0+V29yZENvdW50ID09IDMpCg==

--0__=08BBE6C3DFBF440B8f9e8a93df938690918c08BBE6C3DFBF440B--

