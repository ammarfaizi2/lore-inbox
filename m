Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266971AbTBHHm5>; Sat, 8 Feb 2003 02:42:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266976AbTBHHm5>; Sat, 8 Feb 2003 02:42:57 -0500
Received: from smtp.dslextreme.com ([66.51.205.17]:5317 "EHLO
	co1.dslextreme.com") by vger.kernel.org with ESMTP
	id <S266971AbTBHHm4>; Sat, 8 Feb 2003 02:42:56 -0500
Date: Fri, 7 Feb 2003 23:53:39 -0800
From: Paul Laufer <paul@laufernet.com>
To: Shawn Starr <spstarr@sh0n.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OSS Sound Blaster sb_card.c rewrite (PnP, module options, etc)
Message-ID: <20030208075339.GA13115@hal9000.laufernet.com>
Mail-Followup-To: Paul Laufer <paul@laufernet.com>,
	Shawn Starr <spstarr@sh0n.net>, linux-kernel@vger.kernel.org
References: <200302072217.24380.spstarr@sh0n.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302072217.24380.spstarr@sh0n.net>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I sent a version of sb_card.c that was what I last minute
tested minus one change. The #include for sb_card.h should be under
the #include of pnp.h. Here is the patch. It should work after you
apply this.

Thanks for testing.

Paul

--- sb_card.c.orig	2003-02-06 00:35:10.000000000 -0800
+++ sb_card.c	2003-02-07 23:46:50.000000000 -0800
@@ -19,6 +19,7 @@
  * Melo, Daniel Church, and myself.
  *
  * 02-05-2003 Original Release, Paul Laufer <paul@laufernet.com>
+ * 02-07-2003 Bug made it into first release. Take two.
  */
 
 #include <linux/config.h>
@@ -31,11 +32,10 @@
 #include "sound_config.h"
 #include "sb_mixer.h"
 #include "sb.h"
-#include "sb_card.h"
-
 #ifdef CONFIG_PNP_CARD
 #include <linux/pnp.h>
 #endif
+#include "sb_card.h"
 
 MODULE_DESCRIPTION("OSS Soundblaster ISA PnP and legacy sound driver");
 MODULE_LICENSE("GPL");




On Fri, Feb 07, 2003 at 10:17:42PM -0500 or thereabouts, Shawn Starr wrote:
> >This is a rewrite of sound/oss/sb_card.c which handles detection of
> >Soundblaster ISA cards and clones. This rewrite uses the new PnP and
> >module APIs.
> 
> >Attached are two files sb_card.c and sb_card.h that are drop in
> >replacements for sb_card.c. Verified to work with current bk.
> 
> >Please test if you have ISA Soundblaster and clone cards and provide
> >feedback.
> 
> >Thanks,
> >Paul Laufer
> 
> I do, but it doesn't compile against 2.5.59 vanilla?
> 
> In file included from sound/oss/sb_card.c:34:
> sound/oss/sb_card.h:26: elements of array `sb_pnp_card_table' have incomplete 
> type
> sound/oss/sb_card.h:28: unknown field `id' specified in initializer
> sound/oss/sb_card.h:28: warning: excess elements in struct initializer
> sound/oss/sb_card.h:28: warning: (near initialization for 
> `sb_pnp_card_table[0]')
> sound/oss/sb_card.h:28: unknown field `driver_data' specified in initializer
> sound/oss/sb_card.h:28: warning: excess elements in struct initializer
> sound/oss/sb_card.h:28: warning: (near initialization for 
> `sb_pnp_card_table[0]')
> sound/oss/sb_card.h:28: unknown field `devs' specified in initializer
> sound/oss/sb_card.h:28: extra brace group at end of initializer
> 
> etc..
> 
> either my 2.5.59 is not really a vanilla or something else. I took  a 2.5.58 
> bz2 and patched it with 2.5.59 patch it should be fine.
> 
> Or, do I need bk?
> 
> Shawn.
> 
