Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932521AbVHILpg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932521AbVHILpg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 07:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932525AbVHILpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 07:45:36 -0400
Received: from zproxy.gmail.com ([64.233.162.207]:44761 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932523AbVHILpf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 07:45:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=LfnpOUkXkN8idaHGhcA3dVgQDOadFKMho5Hiy9z0dmW/uianS/EEYVRv7a96qyssfi1u2pgxigJkoIkiz5lFhTCu8/2ZKZ/2BkqviK+x82kaO0lTx8xioa+1maWOCrJ74JU6JdEPrU795HfZTX4wMHceC/Fms3RPDDoGntjoCrY=
Message-ID: <9a874849050809044575466fa1@mail.gmail.com>
Date: Tue, 9 Aug 2005 13:45:32 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATHC] remove redundant variable in sys_prctl
Cc: Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_7621_2828100.1123587932732"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_7621_2828100.1123587932732
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

The `sig' variable in kernel/sys.c::sys_prctl() is completely
redundant, we might as well get rid of it.
Patch below for review (also attached since gmail's webmail interface
will most certainly mangle the inline one).

Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>=20
---

--- linux-2.6.13-rc6/kernel/sys.c~      2005-08-09 13:35:40.000000000 +0200
+++ linux-2.6.13-rc6/kernel/sys.c       2005-08-09 13:35:40.000000000 +0200
@@ -1711,7 +1711,6 @@ asmlinkage long sys_prctl(int option, un
                          unsigned long arg4, unsigned long arg5)
 {
        long error;
-       int sig;

        error =3D security_task_prctl(option, arg2, arg3, arg4, arg5);
        if (error)
@@ -1719,12 +1718,11 @@ asmlinkage long sys_prctl(int option, un

        switch (option) {
                case PR_SET_PDEATHSIG:
-                       sig =3D arg2;
-                       if (!valid_signal(sig)) {
+                       if (!valid_signal(arg2)) {
                                error =3D -EINVAL;
                                break;
                        }
-                       current->pdeath_signal =3D sig;
+                       current->pdeath_signal =3D arg2;
                        break;
                case PR_GET_PDEATHSIG:
                        error =3D put_user(current->pdeath_signal, (int
__user *)arg2);



--=20
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html

------=_Part_7621_2828100.1123587932732
Content-Type: application/octet-stream; name="sys_prctl.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="sys_prctl.patch"

ClNpZ25lZC1vZmYtYnk6IEplc3BlciBKdWhsIDxqZXNwZXIuanVobEBnbWFpbC5jb20+CgoKLS0t
IGxpbnV4LTIuNi4xMy1yYzYva2VybmVsL3N5cy5jfgkyMDA1LTA4LTA5IDEzOjM1OjQwLjAwMDAw
MDAwMCArMDIwMAorKysgbGludXgtMi42LjEzLXJjNi9rZXJuZWwvc3lzLmMJMjAwNS0wOC0wOSAx
MzozNTo0MC4wMDAwMDAwMDAgKzAyMDAKQEAgLTE3MTEsNyArMTcxMSw2IEBAIGFzbWxpbmthZ2Ug
bG9uZyBzeXNfcHJjdGwoaW50IG9wdGlvbiwgdW4KIAkJCSAgdW5zaWduZWQgbG9uZyBhcmc0LCB1
bnNpZ25lZCBsb25nIGFyZzUpCiB7CiAJbG9uZyBlcnJvcjsKLQlpbnQgc2lnOwogCiAJZXJyb3Ig
PSBzZWN1cml0eV90YXNrX3ByY3RsKG9wdGlvbiwgYXJnMiwgYXJnMywgYXJnNCwgYXJnNSk7CiAJ
aWYgKGVycm9yKQpAQCAtMTcxOSwxMiArMTcxOCwxMSBAQCBhc21saW5rYWdlIGxvbmcgc3lzX3By
Y3RsKGludCBvcHRpb24sIHVuCiAKIAlzd2l0Y2ggKG9wdGlvbikgewogCQljYXNlIFBSX1NFVF9Q
REVBVEhTSUc6Ci0JCQlzaWcgPSBhcmcyOwotCQkJaWYgKCF2YWxpZF9zaWduYWwoc2lnKSkgewor
CQkJaWYgKCF2YWxpZF9zaWduYWwoYXJnMikpIHsKIAkJCQllcnJvciA9IC1FSU5WQUw7CiAJCQkJ
YnJlYWs7CiAJCQl9Ci0JCQljdXJyZW50LT5wZGVhdGhfc2lnbmFsID0gc2lnOworCQkJY3VycmVu
dC0+cGRlYXRoX3NpZ25hbCA9IGFyZzI7CiAJCQlicmVhazsKIAkJY2FzZSBQUl9HRVRfUERFQVRI
U0lHOgogCQkJZXJyb3IgPSBwdXRfdXNlcihjdXJyZW50LT5wZGVhdGhfc2lnbmFsLCAoaW50IF9f
dXNlciAqKWFyZzIpOwo=
------=_Part_7621_2828100.1123587932732--
