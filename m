Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285417AbSACLGs>; Thu, 3 Jan 2002 06:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285369AbSACLGh>; Thu, 3 Jan 2002 06:06:37 -0500
Received: from [217.118.66.254] ([217.118.66.254]:2215 "EHLO
	backtop.namesys.com") by vger.kernel.org with ESMTP
	id <S285367AbSACLGd>; Thu, 3 Jan 2002 06:06:33 -0500
From: Alexander Zarochentcev <zam@namesys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15412.15079.684123.309977@backtop.namesys.com>
Date: Thu, 3 Jan 2002 14:05:11 +0300
To: "David S. Miller" <davem@redhat.com>
Cc: kernel@Expansa.sns.it, Nikita@namesys.com, linux-kernel@vger.kernel.org,
        Reiserfs-List@namesys.com
Subject: Re: [reiserfs-list] Re: reiserfs does not work with linux 2.4.17 on sparc64 CPUs
In-Reply-To: <20020102.201352.104034173.davem@redhat.com>
In-Reply-To: <15403.16930.233614.432899@laputa.namesys.com>
	<Pine.LNX.4.33.0112281058130.30085-100000@Expansa.sns.it>
	<20020102.201352.104034173.davem@redhat.com>
X-Mailer: VM 7.00 under Emacs 21.1.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It was sent to reiserfs list and lkml already.

David S. Miller writes:
 >    From: Luigi Genoni <kernel@Expansa.sns.it>
 >    Date: Fri, 28 Dec 2001 11:03:27 +0100 (CET)
 > 
 >    OK, here is my oops
 >    
 >    reiserfs: checking transaction log (device 08:14) ...
 >    Using r5 hash to sort names
 >    Unsupported unaligned load/store trap for kernel at <000000000059bae8>.
 > 
 > Looks like some change in reiserfs in 2.4.17 has caused it to start
 > doing {set,clear,change}_bit() operations on pointers which are not
 > "long" aligned.

--- linux/include/linux/reiserfs_fs_sb.h.org	Wed Jan  2 15:45:20 2002
+++ linux/include/linux/reiserfs_fs_sb.h	Wed Jan  2 15:45:36 2002
@@ -407,7 +407,7 @@
 				/* To be obsoleted soon by per buffer seals.. -Hans */
     atomic_t s_generation_counter; // increased by one every time the
     // tree gets re-balanced
-    unsigned int s_properties;    /* File system properties. Currently holds
+    unsigned long s_properties;    /* File system properties. Currently holds
 				     on-disk FS format */
     
     /* session statistics */

 > 
 > Franks a lot,
 > David S. Miller
 > davem@redhat.com

-- 
Alexander Zarochentcev, mailto:zam@namesys.com
---
"Gee, Toto, I don't think we are in Kansas anymore."
