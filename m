Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137071AbREKIDo>; Fri, 11 May 2001 04:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137076AbREKIDZ>; Fri, 11 May 2001 04:03:25 -0400
Received: from obelix.hrz.tu-chemnitz.de ([134.109.132.55]:20953 "EHLO
	obelix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S137071AbREKIDU>; Fri, 11 May 2001 04:03:20 -0400
Date: Fri, 11 May 2001 10:03:12 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Paul Rusty Russel <rusty@rustcorp.com.au>
Subject: Re: 2.4.4-ac6 compile error in plip.c
Message-ID: <20010511100312.V754@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <3AFA9BC3.1060207@surfbest.net> <2514.989556789@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <2514.989556789@kao2.melbourne.sgi.com>; from kaos@ocs.com.au on Fri, May 11, 2001 at 02:53:09PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 11, 2001 at 02:53:09PM +1000, Keith Owens wrote:
> The first __initdata is marked as const, the second is not, a section
> cannot contain both const and non-const data.  Against 2.4.4-ac6.

So we should also update the documentation to reflect this.

--- linux-2.4.4/include/linux/init.h.orig	Wed May  9 21:33:38 2001
+++ linux-2.4.4/include/linux/init.h	Fri May 11 09:53:57 2001
@@ -34,6 +34,8 @@
  * Don't forget to initialize data not at file scope, i.e. within a function,
  * as gcc otherwise puts the data into the bss section and not into the init
  * section.
+ * 
+ * Also note, that this data cannot be "const".
  */
 
 #ifndef MODULE
--- linux-2.4.4/Documentation/DocBook/kernel-hacking.tmpl.orig	Fri Apr  6 19:42:55 2001
+++ linux-2.4.4/Documentation/DocBook/kernel-hacking.tmpl	Fri May 11 09:58:45 2001
@@ -713,7 +713,8 @@
    </para>
    <para>
    Static data structures marked as <type>__initdata</type> must be initialised
-   (as opposed to ordinary static data which is zeroed BSS).
+   (as opposed to ordinary static data which is zeroed BSS) and cannot be 
+   <type>const</type>.
    </para> 
 
   </sect1>

Regards

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<     been there and had much fun   >>>>>>>>>>>>
