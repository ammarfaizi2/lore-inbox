Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129227AbRB1T2N>; Wed, 28 Feb 2001 14:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129215AbRB1T2D>; Wed, 28 Feb 2001 14:28:03 -0500
Received: from ns.caldera.de ([212.34.180.1]:59666 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S129213AbRB1T1q>;
	Wed, 28 Feb 2001 14:27:46 -0500
Date: Wed, 28 Feb 2001 20:27:33 +0100
From: Christoph Hellwig <hch@ns.caldera.de>
To: Alexander Zarochentcev <zam@namesys.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Hans Reiser <reiser@namesys.com>, reiserfs-dev@namesys.com
Subject: Re: [PATCH] reiserfs patch for linux-2.4.2
Message-ID: <20010228202733.A18073@caldera.de>
Mail-Followup-To: Alexander Zarochentcev <zam@namesys.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Hans Reiser <reiser@namesys.com>, reiserfs-dev@namesys.com
In-Reply-To: <20010228222130.A3131@crimson.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <20010228222130.A3131@crimson.namesys.com>; from zam@namesys.com on Wed, Feb 28, 2001 at 10:21:30PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2001 at 10:21:30PM +0300, Alexander Zarochentcev wrote:
> 6. Using integer constants from limits.h instead of self made ones

Urgg. limits.h is a userlevel header...

The attached patch will make similar atempts fail (but not this one as
there is also a limits.h in gcc's include dir).

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.


--- linux-2.4.0/Makefile	Mon Dec 25 19:21:14 2000
+++ linux/Makefile	Mon Dec 25 23:30:03 2000
@@ -85,7 +85,8 @@
 # standard CFLAGS
 #
 
-CPPFLAGS := -D__KERNEL__ -I$(HPATH)
+GCCINCDIR = $(shell gcc -print-search-dirs | sed -ne 's/install: \(.*\)/\1include/gp')
+CPPFLAGS := -D__KERNEL__ -nostdinc -I$(HPATH) -I$(GCCINCDIR)
 
 CFLAGS := $(CPPFLAGS) -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing
 AFLAGS := -D__ASSEMBLY__ $(CPPFLAGS)
