Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266168AbTGDUvE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 16:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266177AbTGDUvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 16:51:04 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:48019
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S266168AbTGDUvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 16:51:00 -0400
Message-ID: <3F05EC0C.2040809@redhat.com>
Date: Fri, 04 Jul 2003 14:05:16 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030703 Thunderbird/0.1a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: wrong pid in siginfo_t
X-Enigmail-Version: 0.80.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------070404090000080101080107"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070404090000080101080107
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

If a signal is sent via kill() or tkill() the kernel fills in the wrong
PID value in the siginfo_t structure (obviously only if the handler has
SA_SIGINFO set).  POSIX specifies the the si_pid field is filled with
the process ID.  The kernel currently fills in the thread ID.  The
thread IDs are not useful at all at userlevel.  They are not exposed
anywhere.

One might argue that sending up the ID of the thread as well is a good
thing but I don't agree.  This is what sigqueue is for: one can attach
arbitrary data to the signal and get it transmitted (the sigval_t
parameter).


I've attached a patch for the current 2.5 kernel and a test case.
Whoever collects kernel tests might want to add the program.

- --
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/BewL2ijCOnn/RHQRAtnYAKCmG6vX3YFo9ko8kjwzvNObxrklfACfVga3
43za5G4ljJwJD1SZEqrr+eU=
=lfde
-----END PGP SIGNATURE-----

--------------070404090000080101080107
Content-Type: text/plain;
 name="d-kernel-signal"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="d-kernel-signal"

LS0tIGtlcm5lbC9zaWduYWwuYy1zYXZlCTIwMDMtMDYtMDMgMTA6MTQ6NTUuMDAwMDAwMDAw
IC0wNzAwCisrKyBrZXJuZWwvc2lnbmFsLmMJMjAwMy0wNy0wNCAxMzo0Njo1NS4wMDAwMDAw
MDAgLTA3MDAKQEAgLTIwODEsNyArMjA4MSw3IEBAIHN5c19raWxsKGludCBwaWQsIGludCBz
aWcpCiAJaW5mby5zaV9zaWdubyA9IHNpZzsKIAlpbmZvLnNpX2Vycm5vID0gMDsKIAlpbmZv
LnNpX2NvZGUgPSBTSV9VU0VSOwotCWluZm8uc2lfcGlkID0gY3VycmVudC0+cGlkOworCWlu
Zm8uc2lfcGlkID0gY3VycmVudC0+dGdpZDsKIAlpbmZvLnNpX3VpZCA9IGN1cnJlbnQtPnVp
ZDsKIAogCXJldHVybiBraWxsX3NvbWV0aGluZ19pbmZvKHNpZywgJmluZm8sIHBpZCk7CkBA
IC0yMTA0LDcgKzIxMDQsNyBAQCBzeXNfdGtpbGwoaW50IHBpZCwgaW50IHNpZykKIAlpbmZv
LnNpX3NpZ25vID0gc2lnOwogCWluZm8uc2lfZXJybm8gPSAwOwogCWluZm8uc2lfY29kZSA9
IFNJX1RLSUxMOwotCWluZm8uc2lfcGlkID0gY3VycmVudC0+cGlkOworCWluZm8uc2lfcGlk
ID0gY3VycmVudC0+dGdpZDsKIAlpbmZvLnNpX3VpZCA9IGN1cnJlbnQtPnVpZDsKIAogCXJl
YWRfbG9jaygmdGFza2xpc3RfbG9jayk7Cg==
--------------070404090000080101080107
Content-Type: text/plain;
 name="tst-sipid.c"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="tst-sipid.c"

I2luY2x1ZGUgPHNlbWFwaG9yZS5oPgojaW5jbHVkZSA8c2lnbmFsLmg+CiNpbmNsdWRlIDx1
bmlzdGQuaD4KCnN0YXRpYyBpbnQgZmFpbGVkOwpzdGF0aWMgcGlkX3QgcGlkOwpzdGF0aWMg
dWlkX3QgdWlkOwpzdGF0aWMgc2VtX3Qgc2VtOwpzdGF0aWMgaW50IGlzX2tpbGw7CgojZGVm
aW5lIFRIRVNJRyBTSUdSVE1JTgoKc3RhdGljIHZvaWQKc2ggKGludCBzaWcsIHNpZ2luZm9f
dCAqc2ksIHZvaWQgKmN0eCkKewogIGlmIChzaWcgIT0gc2ktPnNpX3NpZ25vKQogICAgewog
ICAgICBwcmludGYgKCJzaWcgIT0gc2ktPnNpX3NpZ25vOiAlZCB2cyAlZFxuIiwgc2lnLCAo
aW50KSBzaS0+c2lfc2lnbm8pOwogICAgICBmYWlsZWQgPSAxOwogICAgfQogIGlmIChzaS0+
c2lfY29kZSAhPSBpc19raWxsID8gU0lfVVNFUiA6IFNJX1FVRVVFKQogICAgewogICAgICBw
cmludGYgKCJzaS0+c2lfY29kZSB3cm9uZzogJWRcbiIsIHNpLT5zaV9jb2RlKTsKICAgICAg
ZmFpbGVkID0gMTsKICAgIH0KICBpZiAoc2ktPnNpX3BpZCAhPSBwaWQpCiAgICB7CiAgICAg
IHByaW50ZiAoInNpLT5zaV9waWQgd3Jvbmc6ICVkIHZzICVkXG4iLCAoaW50KSBzaS0+c2lf
cGlkLCAoaW50KSBwaWQpOwogICAgICBmYWlsZWQgPSAxOwogICAgfQogIGlmIChzaS0+c2lf
dWlkICE9IHVpZCkKICAgIHsKICAgICAgcHJpbnRmICgic2ktPnNpX3VpZCB3cm9uZzogJWQg
dnMgJWRcbiIsIChpbnQpIHNpLT5zaV91aWQsIChpbnQpIHVpZCk7CiAgICAgIGZhaWxlZCA9
IDE7CiAgICB9CiAgc2VtX3Bvc3QgKCZzZW0pOwp9CgoKc3RhdGljIHZvaWQgKgp0ZiAodm9p
ZCAqYXJnKQp7CiAgcHV0cyAoInRyeWluZyBraWxsIik7CiAgaXNfa2lsbCA9IDE7CiAga2ls
bCAocGlkLCBUSEVTSUcpOwogIHNlbV93YWl0ICgmc2VtKTsKCiAgcHV0cyAoInRyeWluZyBz
aWdxdWV1ZSIpOwogIHNpZ3ZhbF90IHN2OwogIHN2LnNpdmFsX2ludCA9IDQyOwogIGlzX2tp
bGwgPSAwOwogIHNpZ3F1ZXVlIChwaWQsIFRIRVNJRywgc3YpOwogIHNlbV93YWl0ICgmc2Vt
KTsKfQoKCmludAptYWluICh2b2lkKQp7CiAgcGlkID0gZ2V0cGlkICgpOwogIHVpZCA9IGdl
dHVpZCAoKTsKCiAgc3RydWN0IHNpZ2FjdGlvbiBzYTsKICBzYS5zYV9zaWdhY3Rpb24gPSBz
aDsKICBzYS5zYV9mbGFncyA9IFNBX1NJR0lORk87CiAgc2lnZW1wdHlzZXQgKCZzYS5zYV9t
YXNrKTsKICBzaWdhY3Rpb24gKFRIRVNJRywgJnNhLCBOVUxMKTsKCiAgc2VtX2luaXQgKCZz
ZW0sIDAsIDApOwoKICBwdGhyZWFkX3QgdGg7CiAgcHV0cyAoInN0YXJ0aW5nIDFzdCB0aHJl
YWQiKTsKICBwdGhyZWFkX2NyZWF0ZSAoJnRoLCBOVUxMLCB0ZiwgTlVMTCk7CiAgcHRocmVh
ZF9qb2luICh0aCwgTlVMTCk7CiAgcHV0cyAoInN0YXJ0aW5nIDJuZCB0aHJlYWQiKTsKICBw
dGhyZWFkX2NyZWF0ZSAoJnRoLCBOVUxMLCB0ZiwgTlVMTCk7CiAgcHRocmVhZF9qb2luICh0
aCwgTlVMTCk7CgogIHJldHVybiBmYWlsZWQ7Cn0K
--------------070404090000080101080107--

