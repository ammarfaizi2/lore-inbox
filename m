Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129793AbQKVKN3>; Wed, 22 Nov 2000 05:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129996AbQKVKNT>; Wed, 22 Nov 2000 05:13:19 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:10759 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129793AbQKVKNE>;
	Wed, 22 Nov 2000 05:13:04 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Christian Gennerat <christian.gennerat@vz.cit.alcatel.fr>
cc: cooker@linux-mandrake.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Cooker] Re: [CHRPM] modutils-2.3.20-1mdk 
In-Reply-To: Your message of "Wed, 22 Nov 2000 09:57:02 BST."
             <3A1B8A5D.1869C463@vz.cit.alcatel.fr> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 22 Nov 2000 20:42:54 +1100
Message-ID: <1143.974886174@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2000 09:57:02 +0100, 
Christian Gennerat <christian.gennerat@vz.cit.alcatel.fr> wrote:
>The problem is in modules.conf
>Most users do not use "depfile" and "path" commands
>So they have not seen this problem.
>
>This was true for modutils-2.3.19, and older versions.
>With modutils-2.3.20 the syntax have changed.
>Anything in ChangeLog?
>`uname -r` has to be changed in $(uname -r)

Try this patch against modutils 2.3.20.  If it does not fix the problem
then I will need a copy of your modules.conf.  `uname -r` should work
even without this patch, it does for me.  You must have something
unusual in your modules.conf.

Index: 21.4/util/meta_expand.c
--- 21.4/util/meta_expand.c Tue, 21 Nov 2000 19:38:04 +1100 kaos (modutils-2.3/10_meta_expan 1.4.1.3 644)
+++ 21.4(w)/util/meta_expand.c Wed, 22 Nov 2000 11:14:54 +1100 kaos (modutils-2.3/10_meta_expan 1.4.1.3 644)
@@ -328,10 +328,10 @@ int meta_expand(char *pt, GLOB_LIST *g, 
 	pclose(fin);
 
 	if (line) {
-		/* Ignore result if no expansion occurred */
-		xstrcat(tmpline, "\n", sizeof(tmpline));
-		if (strcmp(tmpline, line))
-			split_line(g, line, 0);
+		/* shell used to strip one set of quotes.  Paranoia code in
+		 * 2.3.20 stops that strip so we do it ourselves.
+		 */
+		split_line(g, line, 1);
 		free(line);
 	}
 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
