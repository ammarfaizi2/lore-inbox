Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135509AbRDZPEz>; Thu, 26 Apr 2001 11:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135513AbRDZPEp>; Thu, 26 Apr 2001 11:04:45 -0400
Received: from phoenix.datrix.co.za ([196.37.220.5]:10050 "EHLO
	phoenix.datrix.co.za") by vger.kernel.org with ESMTP
	id <S135509AbRDZPE3>; Thu, 26 Apr 2001 11:04:29 -0400
Content-Type: text/plain; charset=US-ASCII
From: Marcin Kowalski <kowalski@datrix.co.za>
Reply-To: kowalski@datrix.co.za
Organization: Datrix Solutions
To: troels@fast.no, linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4 diskcache pushes applications into swap?
Date: Thu, 26 Apr 2001 17:03:55 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <CKECLHEEHJOPHGPCOCKPKEEECCAA.troels@fast.no>
In-Reply-To: <CKECLHEEHJOPHGPCOCKPKEEECCAA.troels@fast.no>
MIME-Version: 1.0
Message-Id: <01042617035504.04903@webman>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Had the same problem -- even up to 2.4.3. Ed Tomlinsons Patch sorted it out .

It seems that  the dentries were not being cleared properly... hope this 
helps.. 
The explanation probably doesn't :-).. (see last weeks list archives)
------------------------------------------------
--- ./linux/fs/dcache.c Thu Apr 12 09:20:59 2001
+++ dcache.new  Thu Apr 12 09:22:38 2001
@@ -340,7 +340,7 @@
                if (dentry->d_flags & DCACHE_REFERENCED) {
                        dentry->d_flags &= ~DCACHE_REFERENCED;
                        list_add(&dentry->d_lru, &dentry_unused);
-                       goto next;
+                       continue;
                }
                dentry_stat.nr_unused--;

------------------------------
-----------------------------
     Marcin Kowalski
     Linux/Perl Developer
     Datrix Solutions
     Cel. 082-400-7603
      ***Open Source Kicks Ass***
-----------------------------
