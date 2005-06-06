Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261752AbVFFXWY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261752AbVFFXWY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 19:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261772AbVFFXVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 19:21:18 -0400
Received: from zproxy.gmail.com ([64.233.162.192]:62505 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261752AbVFFXUo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 19:20:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type;
        b=Y7W4J0Wd0N1AEz3eq6pDYxYc4QZaP9TafbLObw18v1Xihr6S1X5BD/uV6+1MZ27/DFTaMxm/03AAj/HXMpdsKbrRlI4Y/KzK/McNmyrJwfbl3vyMokC31vNvEuoCPYU5lnXhXyN4g1JLZIEgc+qUv5lQ1x60Y2sEOJ8Nr2V0pXg=
Message-ID: <9a874849050606162048ee149f@mail.gmail.com>
Date: Tue, 7 Jun 2005 01:20:31 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: Eric Youngdale <ericy@cais.com>
Subject: [PATCH] remove meaningless <0 comparison in binfmt_elf
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_18613_2961871.1118100031160"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_18613_2961871.1118100031160
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

'i' is clearly defined at the start of the function to be unsigned, so
comparing it to be less than zero is meaningless.
This patch removes the meaningless comparison.

Since I'm away from home I can't use my usual pine to send the email,
but have to use gmail, and I don't know how gmail will treat the
inline patch, so I'm also attaching it.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---=20

 fs/binfmt_elf.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.12-rc6-orig/fs/binfmt_elf.c=092005-06-07 00:07:40.000000000 +=
0200
+++ linux-2.6.12-rc6/fs/binfmt_elf.c=092005-06-07 01:12:37.000000000 +0200
@@ -1324,7 +1324,7 @@ static int fill_psinfo(struct elf_prpsin
=20
 =09i =3D p->state ? ffz(~p->state) + 1 : 0;
 =09psinfo->pr_state =3D i;
-=09psinfo->pr_sname =3D (i < 0 || i > 5) ? '.' : "RSDTZW"[i];
+=09psinfo->pr_sname =3D i > 5 ? '.' : "RSDTZW"[i];
 =09psinfo->pr_zomb =3D psinfo->pr_sname =3D=3D 'Z';
 =09psinfo->pr_nice =3D task_nice(p);
 =09psinfo->pr_flag =3D p->flags;



--=20
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html

------=_Part_18613_2961871.1118100031160
Content-Type: text/x-patch; 
	name=binfmt_elf-unsigned-checked-for-less-than-zero.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="binfmt_elf-unsigned-checked-for-less-than-zero.patch"

--- linux-2.6.12-rc6-orig/fs/binfmt_elf.c	2005-06-07 00:07:40.000000000 +0200
+++ linux-2.6.12-rc6/fs/binfmt_elf.c	2005-06-07 01:12:37.000000000 +0200
@@ -1324,7 +1324,7 @@ static int fill_psinfo(struct elf_prpsin
 
 	i = p->state ? ffz(~p->state) + 1 : 0;
 	psinfo->pr_state = i;
-	psinfo->pr_sname = (i < 0 || i > 5) ? '.' : "RSDTZW"[i];
+	psinfo->pr_sname = i > 5 ? '.' : "RSDTZW"[i];
 	psinfo->pr_zomb = psinfo->pr_sname == 'Z';
 	psinfo->pr_nice = task_nice(p);
 	psinfo->pr_flag = p->flags;

------=_Part_18613_2961871.1118100031160--
