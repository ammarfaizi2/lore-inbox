Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289386AbSBELtj>; Tue, 5 Feb 2002 06:49:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289466AbSBELt2>; Tue, 5 Feb 2002 06:49:28 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:40964 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S289386AbSBELtS>; Tue, 5 Feb 2002 06:49:18 -0500
Date: Tue, 5 Feb 2002 14:49:17 +0300
From: Oleg Drokin on behalf of Hans Reiser <reiser@namesys.com>
To: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com
Subject: [PATCH] reiserfs fix for incorrect key comparison
Message-ID: <20020205144917.A1142@namesys.com>
Reply-To: green@namesys.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

    This is to fix certain cases where items may get its keys to be interpreted
    wrong and cause reiserfs to panic, or to be inserted into the tree in
    wrong order. This bug was only observed live on 2.5.3, though it is
    present in 2.4, too.

Bye,
    Oleg

--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="pick_correct_key_version.diff"

--- linux-2.5.3/fs/reiserfs/stree.c.orig	Thu Jan 31 19:24:47 2002
+++ linux-2.5.3/fs/reiserfs/stree.c	Thu Jan 31 19:26:54 2002
@@ -126,19 +126,19 @@
   retval = comp_short_keys (le_key, cpu_key);
   if (retval)
       return retval;
-  if (le_key_k_offset (cpu_key->version, le_key) < cpu_key_k_offset (cpu_key))
+  if (le_key_k_offset (le_key_version(le_key), le_key) < cpu_key_k_offset (cpu_key))
       return -1;
-  if (le_key_k_offset (cpu_key->version, le_key) > cpu_key_k_offset (cpu_key))
+  if (le_key_k_offset (le_key_version(le_key), le_key) > cpu_key_k_offset (cpu_key))
       return 1;
 
   if (cpu_key->key_length == 3)
       return 0;
 
   /* this part is needed only when tail conversion is in progress */
-  if (le_key_k_type (cpu_key->version, le_key) < cpu_key_k_type (cpu_key))
+  if (le_key_k_type (le_key_version(le_key), le_key) < cpu_key_k_type (cpu_key))
     return -1;
 
-  if (le_key_k_type (cpu_key->version, le_key) > cpu_key_k_type (cpu_key))
+  if (le_key_k_type (le_key_version(le_key), le_key) > cpu_key_k_type (cpu_key))
     return 1;
 
   return 0;

--oyUTqETQ0mS9luUI--
