Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135918AbREFXRk>; Sun, 6 May 2001 19:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135917AbREFXRb>; Sun, 6 May 2001 19:17:31 -0400
Received: from smtp.mountain.net ([198.77.1.35]:12812 "EHLO riker.mountain.net")
	by vger.kernel.org with ESMTP id <S135915AbREFXRY>;
	Sun, 6 May 2001 19:17:24 -0400
Message-ID: <3AF5DB4E.B5FC78E5@mountain.net>
Date: Sun, 06 May 2001 19:16:30 -0400
From: Tom Leete <tleete@mountain.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.3 i486)
X-Accept-Language: English/United, States, en-US, English/United, Kingdom, en-GB, English, en, French, fr, Spanish, es, Italian, it, German, de, , ru
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] Inconsistent constraint in asm-i386/rwsem.h
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In include/asm-i386/rwsem.h:__up_read(), the auto variable 'tmp' is
asserted to be in edx. This patch adjusts the constraint to match
the variable.

It could be argued that tmp should be declared register instead. I
didn't because the function is inlined. The compiler will know how
much register pressure there is in each instance.

Cheers,
Tom

$ diff -u linux-2.4.5-pre1/include/asm-i386/rwsem.h~
linux-2.4.5-pre1/include/asm-i386/rwsem.h
--- linux-2.4.5-pre1/include/asm-i386/rwsem.h~	Sun May  6 05:48:08 2001
+++ linux-2.4.5-pre1/include/asm-i386/rwsem.h	Sun May  6 07:17:36 2001
@@ -164,7 +164,7 @@
 		"  jmp       1b\n"
 		".previous\n"
 		"# ending __up_read\n"
-		: "+m"(sem->count), "+d"(tmp)
+		: "+m"(sem->count), "+m"(tmp)
 		: "a"(sem)
 		: "memory", "cc");
 }


-- 
The Daemons lurk and are dumb. -- Emerson
