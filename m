Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265264AbTIDQcL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 12:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265279AbTIDQcL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 12:32:11 -0400
Received: from fw.osdl.org ([65.172.181.6]:33174 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265264AbTIDQcF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 12:32:05 -0400
Subject: Re: IA32 - 4 New warnings
From: John Cherry <cherry@osdl.org>
To: "David S. Miller" <davem@redhat.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20030904002430.306cfa83.davem@redhat.com>
References: <13539.4.5.59.77.1062658134.squirrel@www.osdl.org>
	 <20030904002430.306cfa83.davem@redhat.com>
Content-Type: text/plain
Organization: 
Message-Id: <1062693117.9322.48.camel@cherrytest.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 04 Sep 2003 09:31:57 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David,

You are absolutely correct that these are not new warnings.  However,
they are new with respect to CLEAN_COMPILE being enabled by default.  On
Sept 2, Linus add the following patch...

-config BROKEN
-	bool "Prompt for old and known-broken drivers"
-	depends on EXPERIMENTAL
-	default n
+config CLEAN_COMPILE
+	bool "Don't select drivers known to be broken" if EXPERIMENTAL
+	default y 	help
-	  This option allows you to choose whether you want to try to
-	  compile (and fix) old drivers that haven't been updated to
-	  new infrastructure.
+	  Select this option if you don't even want to see the option
+	  to configure known-broken drivers.
+
+	  If unsure, say Y 
-	  If unsure, say N.
+config BROKEN
+	bool
+	depends on !CLEAN_COMPILE
+	default y

By default, the builds did not include known broken drivers.  The build 
yesterday picked up bunk's patch for COSA...

-	depends on WAN && ISA && m && BROKEN
+	depends on WAN && ISA && m

This allowed the driver to be built again, and the warnings reappeared.
So these ARE new warnings in the sense that bunk specifically declared
this driver NOT to be broken.  In fact, the changeset comment was "COSA
is no longer BROKEN".

Actually, to remain consistent with warning and error statistics, I will
need to over-ride the default CLEAN_COMPILE config option in the
automated builds and continue to build broken drivers.  Perhaps I will
build both.  Hey, it is just CPU time.  :)

John


On Thu, 2003-09-04 at 00:24, David S. Miller wrote:
> On Wed, 3 Sep 2003 23:48:54 -0700 (PDT)
> John Cherry <cherry@osdl.org> wrote:
> 
> > drivers/net/wan/cosa.c:516: warning: implicit declaration of function `sti'
> > drivers/net/wan/cosa.c:661: warning: `MOD_INC_USE_COUNT' is deprecated
> > (declared at include/linux/module.h:482)
> 
> There is no way these warnings were added in the past
> 24 hours, they've been there nearly the entire 2.5.x
> series.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

