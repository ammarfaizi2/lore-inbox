Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314193AbSDVNfh>; Mon, 22 Apr 2002 09:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314194AbSDVNfg>; Mon, 22 Apr 2002 09:35:36 -0400
Received: from ubermail.mweb.co.za ([196.2.53.169]:11538 "EHLO
	ubermail.mweb.co.za") by vger.kernel.org with ESMTP
	id <S314193AbSDVNfg>; Mon, 22 Apr 2002 09:35:36 -0400
To: dipankar@in.ibm.com, linux@hazard.jcu.cz, linux-kernel@vger.kernel.org
From: bonganilinux@mweb.co.za
Subject: Re: Kernel 2.5.8 compilation fail...
Date: Mon, 22 Apr 2002 13:34:58 GMT
X-Mailer: Endymion MailMan Standard Edition v3.0.33
Message-Id: <E16zbyq-0006y2-00@ubermail.mweb.co.za>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You can use the attached (text/plain) patch to fix this.
> 
> Thanks

Why will moving init smp_init help? Because as far as I can see
setup_per_cpu_areas() is called by  start_kernel. But it
is only defined for SMP so this should do it:

--- init/main.c Wed Apr 10 15:00:25 2002
+++ init/main.c_new     Mon Apr 22 15:33:45 2002
@@ -269,6 +269,9 @@
 }
 #else
 #define smp_init()     do { } while (0)
+static inline void setup_per_cpu_areas(void)
+{
+}
 #endif

 #else

> -- 
> Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
> Linux Technology Center, IBM Software Lab, Bangalore, India.
> 


---------------------------------------------
This message was sent using M-Web Airmail.
JUST LIKE THAT
Are you ready for 10-digit dialling on the 8th of May?
To find out how this will affect your Internet connection go to www.mweb.co.za/ten
http://airmail.mweb.co.za/


