Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313327AbSDZHo1>; Fri, 26 Apr 2002 03:44:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313595AbSDZHo0>; Fri, 26 Apr 2002 03:44:26 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:32528 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S313327AbSDZHo0>; Fri, 26 Apr 2002 03:44:26 -0400
Date: Fri, 26 Apr 2002 09:44:16 +0200
From: Jurriaan on Alpha <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: compiling cmipci in 2.5.10 on Alpha doesn't work
Message-ID: <20020426074416.GA8415@alpha.of.nowhere>
Reply-To: thunder7@xs4all.nl
In-Reply-To: <20020426073130.GB28217@alpha.of.nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jurriaan on Alpha <thunder7@xs4all.nl>
Date: Fri, Apr 26, 2002 at 09:31:30AM +0200
> I tried to compile 2.5.10 on my Alpha, but the cmipci module won't
> compile:
> 
> cmipci.c:2479: warning: implicit declaration of function `release_resource'

Just found out that this trivial patch remedies it:

--- driver.org  Fri Apr 26 09:42:31 2002
+++ driver.h    Fri Apr 26 09:37:04 2002
@@ -50,7 +50,7 @@
  */

 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 4, 0)
-#if defined(__i386__) || defined(__ppc__)
+#if defined(__i386__) || defined(__ppc__) || defined(__alpha__)
 /*
  * Here a dirty hack for 2.4 kernels.. See kernel/memory.c.
  */

As for the why of this, or if it's the best way to solve it, I've no
idea :-)

Jurriaan
-- 
"I resent it as well," said Scharde. "I am working to keep my rage under
control."
        Jack Vance - Ecce and Old Earth
GNU/Linux 2.4.19p7 on Debian/Alpha 990 bogomips load:0.33 0.62 0.54
