Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265987AbSKTMBo>; Wed, 20 Nov 2002 07:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266006AbSKTMBn>; Wed, 20 Nov 2002 07:01:43 -0500
Received: from cm19173.red.mundo-r.com ([213.60.19.173]:41098 "EHLO
	demo.mitica") by vger.kernel.org with ESMTP id <S265987AbSKTMBm>;
	Wed, 20 Nov 2002 07:01:42 -0500
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH]: fixing journal-api.tmpl tags
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: 20 Nov 2002 13:12:11 +0100
Message-ID: <m2zns430f8.fsf@demo.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi

        journal-API don't have the xml tags right, and make imposible
        to compile the docs.  Trivial patch included, basically you
        need to close every tag  that you open :)

Later, Juan.

diff -uNp c2/Documentation/DocBook/journal-api.tmpl.orig c2/Documentation/DocBook/journal-api.tmpl
--- c2/Documentation/DocBook/journal-api.tmpl.orig	2002-11-18 16:47:05.000000000 +0100
+++ c2/Documentation/DocBook/journal-api.tmpl	2002-11-19 10:47:05.000000000 +0100
@@ -196,6 +196,8 @@ listed against them. Ext3 does this in e
 Lock is also providing through journal_{un,}lock_updates(),
 ext3 uses this when it wants a window with a clean and stable fs for a moment.
 eg. 
+</para>
+
 <programlisting>
 
 	journal_lock_updates() //stop new stuff happening..
@@ -204,11 +206,12 @@ eg. 
 	journal_unlock_updates() // carry on with filesystem use.
 </programlisting>
 
+<para>
 The opportunities for abuse and DOS attacks with this should be obvious,
 if you allow unprivileged userspace to trigger codepaths containing these
 calls.
 
-<para>
+</para>
 </sect1>
 <sect1>
 <title>Summary</title>
@@ -216,9 +219,13 @@ calls.
 Using the journal is a matter of wrapping the different context changes,
 being each mount, each modification (transaction) and each changed buffer
 to tell the journalling layer about them.
+</para>
 
+<para>
 Here is a some pseudo code to give you an idea of how it works, as
 an example.
+</para>
+
 <programlisting>
   journal_t* my_jnrl = journal_create();
   journal_init_{dev,inode}(jnrl,...)
@@ -244,6 +251,7 @@ an example.
    }
    journal_destroy(my_jrnl);
 </programlisting>
+</sect1>
 
 </chapter>
 


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
