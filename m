Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267470AbUHECdb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267470AbUHECdb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 22:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267473AbUHECdb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 22:33:31 -0400
Received: from mx1.redhat.com ([66.187.233.31]:28857 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267470AbUHECd0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 22:33:26 -0400
Date: Wed, 4 Aug 2004 19:32:43 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: zaitcev@redhat.com, spot@redhat.com, akpm@osdl.org
Subject: Make MAX_INIT_ARGS 25
Message-Id: <20040804193243.36009baa@lembas.zaitcev.lan>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, everyone:

We at Red Hat shipped a larger number of arguments for quite some time,
it was required for installations on IBM mainframe (s390), which doesn't
have a good way to pass arguments. I tried to submit it before, but only
half-heartedly, because I saw it as not benefitting folks at large, so
why bloat, right?

I really hate carrying divergent patches in Red Hat tree, even small
ones like this one, but there wasn't enough pull to integrate.
Recently I saw patches which try to make the MAX_INIT_ARGS and
MAX_INIT_ENVS configurable. Apparently, it's needed for someone else
besides mainframe now. This is an example (from Mike McLean):

> There are a number of reasonable situations that go past the current 
> limits of 8.  One that comes to mind is when you want to perform a 
> manual vnc install on a headless machine using anaconda.  This requires 
> passing in a number of parameters to get anaconda past the initial 
> (no-gui) loader screens.

I thought about it and decided that making this configurable is more
trouble than it's worth. We'd need a new entry, all to save a few words.
There would be a need to document it, and to ask users "are you sure you
configured your MAX_INIT_FOO to 20?" OTOH, if we just bump it, any
software can just look at version and magically know if the kernel
supports larger number of arguments, at the moment of kernel installation.
Say, if Linus takes it now, 2.6.8 and above would be "ok for jumpstart".

I'd like to ask (Andrew? Linus?) simply to bump the value somewhat,
without any complications. The value of 25 is specifically selected
to show that it's arbitrary. Mike wanted 32, but that just looked too
meaningful.

-- Pete

--- linux-2.6.7/init/main.c	2004-06-16 16:54:07.000000000 -0700
+++ linux-2.6.7-usb/init/main.c	2004-08-04 19:16:22.566593218 -0700
@@ -102,8 +102,8 @@
 /*
  * Boot command-line arguments
  */
-#define MAX_INIT_ARGS 8
-#define MAX_INIT_ENVS 8
+#define MAX_INIT_ARGS 25
+#define MAX_INIT_ENVS 25
 
 extern void time_init(void);
 /* Default late time init is NULL. archs can override this later. */
