Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261854AbVANCiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261854AbVANCiZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 21:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261855AbVANCiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 21:38:25 -0500
Received: from rproxy.gmail.com ([64.233.170.202]:7348 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261854AbVANCgd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 21:36:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:references;
        b=EOy3brji8+U8LPvQ5YalJmLA0Y8kwgA1xTErAII6pwvwcNiFbSzxtp6f0NhHUVAL3u/VDs9kIFq6UIvCkKuRfLaZBtnnoZPyHIj+cEKlm5a13xVf5vBDtzcrCWtyYj4jBeHBEk/x25Mg+qxAJ2qUmARuZMzBLFSiQgziBpJ3Jmg=
Message-ID: <36b714c805011318367e28ef76@mail.gmail.com>
Date: Thu, 13 Jan 2005 21:36:32 -0500
From: Brian Waite <linwoes@gmail.com>
Reply-To: Brian Waite <linwoes@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND][PATCH] ppc: fix powersave with interrupts disabled
In-Reply-To: <36b714c80501131426a91c908@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_949_27103765.1105670192748"
References: <200501120407.j0C477s1019067@hera.kernel.org>
	 <36b714c805011312586718520f@mail.gmail.com>
	 <36b714c80501131426a91c908@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_949_27103765.1105670192748
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I apologize ahead of time for my mailer corrupting the patch. Here is
the patch again attached so as to get whitespace corruption. Also, I
removed a set of excessive parens.

Signed-off-by: Brian Waite <waite@skycomputers.com>

--- 1.22/arch/ppc/kernel/idle.c Tue Jan 11 19:42:36 2005
+++ edited/arch/ppc/kernel/idle.c       Thu Jan 13 17:22:25 2005
@@ -39,8 +39,9 @@
        powersave = ppc_md.power_save;

        if (!need_resched()) {
-               if (powersave != NULL)
-                       powersave();
+               if (powersave != NULL && !irqs_disabled())
+                           powersave();
+
                else {
 #ifdef CONFIG_SMP
                        set_thread_flag(TIF_POLLING_NRFLAG);

------=_Part_949_27103765.1105670192748
Content-Type: application/octet-stream; name="powersave_idle.c.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="powersave_idle.c.patch"

PT09PT0gYXJjaC9wcGMva2VybmVsL2lkbGUuYyAxLjIyIHZzIGVkaXRlZCA9PT09PQotLS0gMS4y
Mi9hcmNoL3BwYy9rZXJuZWwvaWRsZS5jCVR1ZSBKYW4gMTEgMTk6NDI6MzYgMjAwNQorKysgZWRp
dGVkL2FyY2gvcHBjL2tlcm5lbC9pZGxlLmMJVGh1IEphbiAxMyAxNzoyMjoyNSAyMDA1CkBAIC0z
OSw4ICszOSw5IEBACiAJcG93ZXJzYXZlID0gcHBjX21kLnBvd2VyX3NhdmU7CiAKIAlpZiAoIW5l
ZWRfcmVzY2hlZCgpKSB7Ci0JCWlmIChwb3dlcnNhdmUgIT0gTlVMTCkKLQkJCXBvd2Vyc2F2ZSgp
OworCQlpZiAocG93ZXJzYXZlICE9IE5VTEwgJiYgIWlycXNfZGlzYWJsZWQoKSkKKwkJCSAgICBw
b3dlcnNhdmUoKTsKKwkJCSAgICAKIAkJZWxzZSB7CiAjaWZkZWYgQ09ORklHX1NNUAogCQkJc2V0
X3RocmVhZF9mbGFnKFRJRl9QT0xMSU5HX05SRkxBRyk7Cg==
------=_Part_949_27103765.1105670192748--
