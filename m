Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313595AbSDPEn2>; Tue, 16 Apr 2002 00:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313596AbSDPEn2>; Tue, 16 Apr 2002 00:43:28 -0400
Received: from kknd.mweb.co.za ([196.2.45.79]:42700 "EHLO kknd.mweb.co.za")
	by vger.kernel.org with ESMTP id <S313595AbSDPEn1>;
	Tue, 16 Apr 2002 00:43:27 -0400
Subject: Re: [Patch] Compilation error on 2.5.8
From: Bongani <bonganilinux@mweb.co.za>
To: Robert Love <rml@tech9.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1018913070.3399.37.camel@phantasy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 16 Apr 2002 06:57:15 +0200
Message-Id: <1018933094.2688.443.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-04-16 at 01:24, Robert Love wrote:
> On Mon, 2002-04-15 at 19:34, Bongani wrote:
> 
> > Does this also look cleaner ?
> 
> > -static inline void setup_per_cpu_areas(void)
> > -{
> > -}
> > +
> > +#define setup_per_cpu_areas()  do { } while(0)
> > +
> 
> Personally yes, but others would disagree.
> 
> In fact, if we use a define setup_per_cpu_areas can not be used outside
> of this compilation unit.  Right now this looks to be the case, but if
> something other than init/main.c wanted to use setup_per_cpu_areas we
> would need to make the code an actual function or put the define in a
> header file.
> 
> Since either case should optimize away, maybe we should make it a static
> inline in both cases, since that is the authors original preference ...
> 
> 	Robert Love
> 

Ok, so this patch should be fine then

--- init/main.c Tue Apr 16 06:52:20 2002
+++ init/main.c_new     Tue Apr 16 06:55:17 2002
@@ -272,6 +272,10 @@
 #define smp_init()     do { } while (0)
 #endif

+static inline void setup_per_cpu_areas(void)
+{
+}
+
 #else

 #ifdef __GENERIC_PER_CPU
@@ -297,9 +301,11 @@
        }
 }
 #else
+
 static inline void setup_per_cpu_areas(void)
 {
 }
+
 #endif /* !__GENERIC_PER_CPU */

 /* Called by boot processor to activate the rest. */




