Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130792AbQLTBOM>; Tue, 19 Dec 2000 20:14:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130794AbQLTBNw>; Tue, 19 Dec 2000 20:13:52 -0500
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:24693 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S130792AbQLTBNq>; Tue, 19 Dec 2000 20:13:46 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: Announce: modutils 2.3.23 is available 
In-Reply-To: Your message of "Sun, 17 Dec 2000 10:45:41 +1100."
             <31418.977010341@ocs3.ocs-net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 20 Dec 2000 11:43:13 +1100
Message-ID: <3249.977272993@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

modutils 2.3.23 has a bug with empty MODULE_GENERIC_STRING entries,
depmod loops.

Index: 23.11/depmod/depmod.c
--- 23.11/depmod/depmod.c Sun, 17 Dec 2000 10:18:04 +1100 kaos (modutils-2.3/b/43_depmod.c 1.39 644)
+++ 23.11(w)/depmod/depmod.c Wed, 20 Dec 2000 08:13:18 +1100 kaos (modutils-2.3/b/43_depmod.c 1.39 644)
@@ -388,9 +388,8 @@ static void extract_generic_string(struc
 			error("unterminated generic string '%*s'", p - s, s);
 			break;
 		}
-		if (p == s)		/* empty string? */
+		if (p++ == s)		/* empty string? */
 			continue;
-		p++;	/* step over NUL */
 		mod->generic_string = xrealloc(mod->generic_string, ++(mod->n_generic_string)*sizeof(*(mod->generic_string)));
 		latest = mod->generic_string + mod->n_generic_string-1;
 		*latest = xstrdup(s);

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
