Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129290AbRB0Nei>; Tue, 27 Feb 2001 08:34:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129305AbRB0Ne2>; Tue, 27 Feb 2001 08:34:28 -0500
Received: from [212.115.175.146] ([212.115.175.146]:7677 "EHLO
	ftrs1.intranet.FTR.NL") by vger.kernel.org with ESMTP
	id <S129290AbRB0NeP>; Tue, 27 Feb 2001 08:34:15 -0500
Message-ID: <27525795B28BD311B28D00500481B7601F0F2D@ftrs1.intranet.ftr.nl>
From: "Heusden, Folkert van" <f.v.heusden@ftr.nl>
To: Ivo Timmermans <irt@cistron.nl>, linux-kernel@vger.kernel.org
Subject: RE: binfmt_script and ^M
Date: Tue, 27 Feb 2001 14:42:17 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> When running a script (perl in this case) that has DOS-style newlines
> (\r\n), Linux 2.4.2 can't find an interpreter because it doesn't
> recognize the \r.  The following patch should fix this (untested).

_should_ it work with the \r in it?

There might be a problem with your patch: at the '*)': if the '\n' is the
first character on the line, the cp-1 (which should be *(cp-1) I think)
would point before the buffer which can be un-allocated memory.



--- binfmt_script.c~	Mon Feb 26 17:42:09 2001
+++ binfmt_script.c	Tue Feb 27 13:39:47 2001
@@ -36,6 +36,8 @@
 	bprm->buf[BINPRM_BUF_SIZE - 1] = '\0';
 	if ((cp = strchr(bprm->buf, '\n')) == NULL)
 		cp = bprm->buf+BINPRM_BUF_SIZE-1;
+	if (cp - 1 == '\r')				<------- *)
+	  cp--;
 	*cp = '\0';
 	while (cp > bprm->buf) {
 		cp--;


Greetings,
Folkert van Heusden
[ www.vanheusden.com ]
