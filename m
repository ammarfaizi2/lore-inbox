Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318269AbSIOVtZ>; Sun, 15 Sep 2002 17:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318270AbSIOVtZ>; Sun, 15 Sep 2002 17:49:25 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14344 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318269AbSIOVtX>;
	Sun, 15 Sep 2002 17:49:23 -0400
Date: Sun, 15 Sep 2002 22:54:19 +0100
From: Matthew Wilcox <willy@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: problem with "Use CLONE_KERNEL for the common kernel thread flags"?
Message-ID: <20020915225419.F10583@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Seems to me like you missed something in your latest changeset:

-#define CLONE_SIGNAL   (CLONE_SIGHAND | CLONE_THREAD)
+#define CLONE_KERNEL   (CLONE_FS | CLONE_FILES | CLONE_SIGHAND)
-       kernel_thread(init, NULL, CLONE_FS | CLONE_FILES | CLONE_SIGNAL);
+       kernel_thread(init, NULL, CLONE_KERNEL);

init used to be spawned with CLONE_THREAD and no longer is.  Was this
intentional?  The changelog entry didn't indicate it, and I haven't
been keeping track of what all the CLONE flags mean these days so I'm
not sure if this is safe.

-- 
Revolutions do not require corporate support.
