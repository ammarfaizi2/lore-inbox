Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136679AbREASFd>; Tue, 1 May 2001 14:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136682AbREASFX>; Tue, 1 May 2001 14:05:23 -0400
Received: from fjetret.sletner.com ([195.159.2.90]:7944 "HELO mail.sletner.com")
	by vger.kernel.org with SMTP id <S136679AbREASFQ>;
	Tue, 1 May 2001 14:05:16 -0400
Date: Tue, 1 May 2001 20:04:48 +0200
From: Stian Sletner <stian@sletner.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andries.Brouwer@cwi.nl
Subject: [PATCH] Dead keys
Message-ID: <20010501200448.A8080@sletner.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I've long been bothered by the fact that 3 of the 6 "dead keys" in the
kernel are actually mapped to the wrong characters.  Now, I realize that
there might be some deliberate reason for this, since it's such an
obvious annoyance and since they all fit in US ASCII the way it is now.
Also, I've noticed that it is the same way in X11, independent from
this.  I'd like to know the reasoning, if there is one.

Normally, you wouldn't notice this too much, since the compose rules
are set up in such a way that you can use the dead keys to compose what
you would expect, anyway.  However, if you were to press a dead key and
then space, or some un-composable key (to get the dead key character by
itself), you would get the wrong character.  Instead of '�' (ISO 8859-1
decimal 168: DIAERESIS), you would get '"' (ASCII decimal 34); instead
of '�' (ISO 8859-1 decimal 180: ACUTE ACCENT), you would get '\'' (ASCII
decimal 39); and instead of '�' (ISO 8859-1 decimal 184: CEDILLA), you
would get ',' (ASCII decimal 44).

I took the liberty of creating a patch that changes this in keyboard.c,
and also adds compose rules to defkeymap.map so they can be used
properly.  If there is some reason why this shouldn't be applied, I'd
like to know what, since this makes my console life easier. :)

Thanks.

(Patched against 2.4.3, but it applies to 2.4.4 too.  Just tested it.)

diff -u linux/drivers/char/defkeymap.map linux-patched/drivers/char/defkeymap.map
--- linux/drivers/char/defkeymap.map	Fri Feb 24 20:38:27 1995
+++ linux-patched/drivers/char/defkeymap.map	Thu Apr 26 22:09:13 2001
@@ -291,12 +291,16 @@
 compose '`' 'a' to '�'
 compose '\'' 'A' to '�'
 compose '\'' 'a' to '�'
+compose '�' 'A' to '�'
+compose '�' 'a' to '�'
 compose '^' 'A' to '�'
 compose '^' 'a' to '�'
 compose '~' 'A' to '�'
 compose '~' 'a' to '�'
 compose '"' 'A' to '�'
 compose '"' 'a' to '�'
+compose '�' 'A' to '�'
+compose '�' 'a' to '�'
 compose 'O' 'A' to '�'
 compose 'o' 'a' to '�'
 compose '0' 'A' to '�'
@@ -307,22 +311,32 @@
 compose 'a' 'e' to '�'
 compose ',' 'C' to '�'
 compose ',' 'c' to '�'
+compose '�' 'C' to '�'
+compose '�' 'c' to '�'
 compose '`' 'E' to '�'
 compose '`' 'e' to '�'
 compose '\'' 'E' to '�'
 compose '\'' 'e' to '�'
+compose '�' 'E' to '�'
+compose '�' 'e' to '�'
 compose '^' 'E' to '�'
 compose '^' 'e' to '�'
 compose '"' 'E' to '�'
 compose '"' 'e' to '�'
+compose '�' 'E' to '�'
+compose '�' 'e' to '�'
 compose '`' 'I' to '�'
 compose '`' 'i' to '�'
 compose '\'' 'I' to '�'
 compose '\'' 'i' to '�'
+compose '�' 'I' to '�'
+compose '�' 'i' to '�'
 compose '^' 'I' to '�'
 compose '^' 'i' to '�'
 compose '"' 'I' to '�'
 compose '"' 'i' to '�'
+compose '�' 'I' to '�'
+compose '�' 'i' to '�'
 compose '-' 'D' to '�'
 compose '-' 'd' to '�'
 compose '~' 'N' to '�'
@@ -331,27 +345,38 @@
 compose '`' 'o' to '�'
 compose '\'' 'O' to '�'
 compose '\'' 'o' to '�'
+compose '�' 'O' to '�'
+compose '�' 'o' to '�'
 compose '^' 'O' to '�'
 compose '^' 'o' to '�'
 compose '~' 'O' to '�'
 compose '~' 'o' to '�'
 compose '"' 'O' to '�'
 compose '"' 'o' to '�'
+compose '�' 'O' to '�'
+compose '�' 'o' to '�'
 compose '/' 'O' to '�'
 compose '/' 'o' to '�'
 compose '`' 'U' to '�'
 compose '`' 'u' to '�'
 compose '\'' 'U' to '�'
 compose '\'' 'u' to '�'
+compose '�' 'U' to '�'
+compose '�' 'u' to '�'
 compose '^' 'U' to '�'
 compose '^' 'u' to '�'
 compose '"' 'U' to '�'
 compose '"' 'u' to '�'
+compose '�' 'U' to '�'
+compose '�' 'u' to '�'
 compose '\'' 'Y' to '�'
 compose '\'' 'y' to '�'
+compose '�' 'Y' to '�'
+compose '�' 'y' to '�'
 compose 'T' 'H' to '�'
 compose 't' 'h' to '�'
 compose 's' 's' to '�'
 compose '"' 'y' to '�'
+compose '�' 'y' to '�'
 compose 's' 'z' to '�'
 compose 'i' 'j' to '�'
diff -u linux/drivers/char/keyboard.c linux-patched/drivers/char/keyboard.c
--- linux/drivers/char/keyboard.c	Mon Oct 16 21:58:51 2000
+++ linux-patched/drivers/char/keyboard.c	Mon Apr 23 12:02:36 2001
@@ -557,11 +557,11 @@
 }
 
 #define A_GRAVE  '`'
-#define A_ACUTE  '\''
+#define A_ACUTE  '\264'
 #define A_CFLEX  '^'
 #define A_TILDE  '~'
-#define A_DIAER  '"'
-#define A_CEDIL  ','
+#define A_DIAER  '\250'
+#define A_CEDIL  '\270'
 static unsigned char ret_diacr[NR_DEAD] =
 	{A_GRAVE, A_ACUTE, A_CFLEX, A_TILDE, A_DIAER, A_CEDIL };

-- 
Stian Sletner
