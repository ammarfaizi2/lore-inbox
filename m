Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261783AbVFFXxH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261783AbVFFXxH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 19:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261720AbVFFXwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 19:52:21 -0400
Received: from zproxy.gmail.com ([64.233.162.194]:14055 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261269AbVFFXuH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 19:50:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type;
        b=G924pAhnXPlByhY1UpkOOmgYbbSeMexS25S6vQp8G0GTd7aYdQBXPy5L+FdAszyQRcH+08oQ+GGAOnaL3hMXhvMo4ij6EajQ+PwI444iRya1tnW5V+YJvknbW6EeW8THhg0SMBbqXn9Uvc51yctK9c5rd3yURy+MmNYRoHor3D4=
Message-ID: <9a8748490506061650477c8b7@mail.gmail.com>
Date: Tue, 7 Jun 2005 01:50:06 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: James Morris <jmorris@intercode.com.au>
Subject: Resend: [PATCH] crypto: don't check for NULL before kfree(), it's redundant.
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_18706_27815704.1118101806688"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_18706_27815704.1118101806688
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Here's a resend of a patch originally for 2.6.12-rc1-mm4. It still
applies to 2.6.12-rc6

The patch removes redundant checks of NULL before kfree() in crypto/ .

Patch attached as well as inline since I don't know how well gmail
handles inline patches.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---=20

 crypto/cipher.c |    3 +--
 crypto/hmac.c   |    3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff -upr linux-2.6.12-rc6-orig/crypto/cipher.c linux-2.6.12-rc6/crypto/cip=
her.c
--- linux-2.6.12-rc6-orig/crypto/cipher.c=092005-06-07 00:07:12.000000000 +=
0200
+++ linux-2.6.12-rc6/crypto/cipher.c=092005-06-07 01:49:16.000000000 +0200
@@ -336,6 +336,5 @@ out:=09
=20
 void crypto_exit_cipher_ops(struct crypto_tfm *tfm)
 {
-=09if (tfm->crt_cipher.cit_iv)
-=09=09kfree(tfm->crt_cipher.cit_iv);
+=09kfree(tfm->crt_cipher.cit_iv);
 }
diff -upr linux-2.6.12-rc6-orig/crypto/hmac.c linux-2.6.12-rc6/crypto/hmac.=
c
--- linux-2.6.12-rc6-orig/crypto/hmac.c=092005-03-02 08:38:09.000000000 +01=
00
+++ linux-2.6.12-rc6/crypto/hmac.c=092005-06-07 01:49:16.000000000 +0200
@@ -49,8 +49,7 @@ int crypto_alloc_hmac_block(struct crypt
=20
 void crypto_free_hmac_block(struct crypto_tfm *tfm)
 {
-=09if (tfm->crt_digest.dit_hmac_block)
-=09=09kfree(tfm->crt_digest.dit_hmac_block);
+=09kfree(tfm->crt_digest.dit_hmac_block);
 }
=20
 void crypto_hmac_init(struct crypto_tfm *tfm, u8 *key, unsigned int *keyle=
n)



--=20
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html

------=_Part_18706_27815704.1118101806688
Content-Type: text/x-patch; name="crypto-kfree.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="crypto-kfree.patch"

ZGlmZiAtdXByIGxpbnV4LTIuNi4xMi1yYzYtb3JpZy9jcnlwdG8vY2lwaGVyLmMgbGludXgtMi42
LjEyLXJjNi9jcnlwdG8vY2lwaGVyLmMKLS0tIGxpbnV4LTIuNi4xMi1yYzYtb3JpZy9jcnlwdG8v
Y2lwaGVyLmMJMjAwNS0wNi0wNyAwMDowNzoxMi4wMDAwMDAwMDAgKzAyMDAKKysrIGxpbnV4LTIu
Ni4xMi1yYzYvY3J5cHRvL2NpcGhlci5jCTIwMDUtMDYtMDcgMDE6NDk6MTYuMDAwMDAwMDAwICsw
MjAwCkBAIC0zMzYsNiArMzM2LDUgQEAgb3V0OgkKIAogdm9pZCBjcnlwdG9fZXhpdF9jaXBoZXJf
b3BzKHN0cnVjdCBjcnlwdG9fdGZtICp0Zm0pCiB7Ci0JaWYgKHRmbS0+Y3J0X2NpcGhlci5jaXRf
aXYpCi0JCWtmcmVlKHRmbS0+Y3J0X2NpcGhlci5jaXRfaXYpOworCWtmcmVlKHRmbS0+Y3J0X2Np
cGhlci5jaXRfaXYpOwogfQpkaWZmIC11cHIgbGludXgtMi42LjEyLXJjNi1vcmlnL2NyeXB0by9o
bWFjLmMgbGludXgtMi42LjEyLXJjNi9jcnlwdG8vaG1hYy5jCi0tLSBsaW51eC0yLjYuMTItcmM2
LW9yaWcvY3J5cHRvL2htYWMuYwkyMDA1LTAzLTAyIDA4OjM4OjA5LjAwMDAwMDAwMCArMDEwMAor
KysgbGludXgtMi42LjEyLXJjNi9jcnlwdG8vaG1hYy5jCTIwMDUtMDYtMDcgMDE6NDk6MTYuMDAw
MDAwMDAwICswMjAwCkBAIC00OSw4ICs0OSw3IEBAIGludCBjcnlwdG9fYWxsb2NfaG1hY19ibG9j
ayhzdHJ1Y3QgY3J5cHQKIAogdm9pZCBjcnlwdG9fZnJlZV9obWFjX2Jsb2NrKHN0cnVjdCBjcnlw
dG9fdGZtICp0Zm0pCiB7Ci0JaWYgKHRmbS0+Y3J0X2RpZ2VzdC5kaXRfaG1hY19ibG9jaykKLQkJ
a2ZyZWUodGZtLT5jcnRfZGlnZXN0LmRpdF9obWFjX2Jsb2NrKTsKKwlrZnJlZSh0Zm0tPmNydF9k
aWdlc3QuZGl0X2htYWNfYmxvY2spOwogfQogCiB2b2lkIGNyeXB0b19obWFjX2luaXQoc3RydWN0
IGNyeXB0b190Zm0gKnRmbSwgdTggKmtleSwgdW5zaWduZWQgaW50ICprZXlsZW4pCg==
------=_Part_18706_27815704.1118101806688--
