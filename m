Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286895AbSAIObT>; Wed, 9 Jan 2002 09:31:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286758AbSAIObJ>; Wed, 9 Jan 2002 09:31:09 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:47113 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S286904AbSAIOa6>; Wed, 9 Jan 2002 09:30:58 -0500
Date: Wed, 9 Jan 2002 17:30:56 +0300
From: Oleg Drokin <green@namesys.com>
To: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com
Subject: Re: [reiserfs-dev] [PATCH] Suppress compilation warnings on big endian platform for reiserfs
Message-ID: <20020109173056.B1161@namesys.com>
In-Reply-To: <20020109170303.A1025@namesys.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
In-Reply-To: <20020109170303.A1025@namesys.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

    Argh! Stupid typo have flipped into the previous incarnation of this patch, so here is correct one.
    Please apply this one.

Bye,
    Oleg
On Wed, Jan 09, 2002 at 05:03:03PM +0300, Oleg Drokin wrote:
>     Please apply.

--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="big-endian-const.diff"

--- linux/include/linux/reiserfs_fs.h.orig	Wed Jan  9 12:03:13 2002
+++ linux/include/linux/reiserfs_fs.h	Wed Jan  9 16:57:37 2002
@@ -244,9 +244,9 @@
     __u64 linear;
 } __attribute__ ((__packed__)) offset_v2_esafe_overlay;
 
-static inline __u16 offset_v2_k_type( struct offset_v2 *v2 )
+static inline __u16 offset_v2_k_type( const struct offset_v2 *v2 )
 {
-    offset_v2_esafe_overlay tmp = *(offset_v2_esafe_overlay *)v2;
+    offset_v2_esafe_overlay tmp = *(const offset_v2_esafe_overlay *)v2;
     tmp.linear = le64_to_cpu( tmp.linear );
     return (tmp.offset_v2.k_type <= TYPE_MAXTYPE)?tmp.offset_v2.k_type:TYPE_ANY;
 }
@@ -259,9 +259,9 @@
     tmp->linear = le64_to_cpu(tmp->linear);
 }
  
-static inline loff_t offset_v2_k_offset( struct offset_v2 *v2 )
+static inline loff_t offset_v2_k_offset( const struct offset_v2 *v2 )
 {
-    offset_v2_esafe_overlay tmp = *(offset_v2_esafe_overlay *)v2;
+    offset_v2_esafe_overlay tmp = *(const offset_v2_esafe_overlay *)v2;
     tmp.linear = le64_to_cpu( tmp.linear );
     return tmp.offset_v2.k_offset;
 }

--+HP7ph2BbKc20aGI--
