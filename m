Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289659AbSAWDu2>; Tue, 22 Jan 2002 22:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289661AbSAWDuR>; Tue, 22 Jan 2002 22:50:17 -0500
Received: from falcon.mail.pas.earthlink.net ([207.217.120.74]:30112 "EHLO
	falcon.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S289659AbSAWDuN>; Tue, 22 Jan 2002 22:50:13 -0500
Date: Tue, 22 Jan 2002 22:53:35 -0500
To: Dave Jones <davej@suse.de>, andrea@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 1-2-3 GB
Message-ID: <20020122225335.B164@earthlink.net>
In-Reply-To: <20020115090746.B6007@earthlink.net> <20020115184843.D32088@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020115184843.D32088@suse.de>; from davej@suse.de on Tue, Jan 15, 2002 at 06:48:43PM +0100
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  > The 3 patches in this thread combined into one, with a default
>  > config option of 2GB, and help saying, if unsure, say "1GB":
> 
>  This may be confusing for some, bringing up the question
>  "I'm unsure, but why is the default at 2GB?"
> 
>  Default option should match default advice.
> 
> -- 
> | Dave Jones.        http://www.codemonkey.org.uk

Good point.  This Configure.help for 2.4.18pre4aa1 may be better:


--- linux-2.4.18pre4aa1/Documentation/Configure.help	Tue Jan 22 21:25:55 2002
+++ linux/Documentation/Configure.help	Tue Jan 22 22:51:11 2002
@@ -376,6 +376,34 @@
   Select this if you have a 32-bit processor and more than 4
   gigabytes of physical RAM.
 
+User address space size
+CONFIG_1GB
+  If you have 4 Gigabytes of physical memory or less, you can change
+  where the kernel maps high memory.  
+
+  Typically there will 128 megabytes less "user memory" mapped 
+  than the number in the configuration option.  Saying that 
+  another way, "high memory" will usually start 128 megabytes 
+  lower than the configuration option.
+
+  Selecting "05GB" results in a "3.5GB/0.5GB" kernel/user split: 
+  On a system with 1 gigabyte of physical memory, you may get 384 
+  megabytes of "user memory" and 640 megabytes of "high memory" 
+  with this selection.
+
+  Selecting "1GB" results in a "3GB/1GB" kernel/user split: 
+  On a system with 1 gigabyte of memory, you may get 896 MB of 
+  "user memory" and 128 megabytes of "high memory" with this
+  selection.  This is the usual setting.
+
+  Selecting "2GB" results in a "2GB/2GB" kernel/user split:
+  On a system with less than 1.75 gigabytes of physical memory, 
+  this option will make it so no memory is mapped as "high".
+
+  Selecting "3GB" results in a "1GB/3GB" kernel/user split:
+
+  If unsure, say "1GB".
+
 HIGHMEM I/O support
 CONFIG_HIGHIO
   If you want to be able to do I/O to high memory pages, say Y.

-- 
Randy Hron

