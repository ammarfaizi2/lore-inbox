Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264275AbUBKNHA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 08:07:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264365AbUBKNHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 08:07:00 -0500
Received: from mx13.sac.fedex.com ([199.81.197.53]:9220 "EHLO
	mx13.sac.fedex.com") by vger.kernel.org with ESMTP id S264275AbUBKNG6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 08:06:58 -0500
Date: Wed, 11 Feb 2004 21:07:22 +0800 (SGT)
From: Jeff Chua <jchua@fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, Jeff Chua <jchua@fedex.com>,
       Jeff Chua <jeffchua@silk.corp.fedex.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] warning: `__attribute_used__' redefined
In-Reply-To: <Pine.LNX.4.58.0402100827100.2128@home.osdl.org>
Message-ID: <Pine.LNX.4.58.0402112105090.341@boston.corp.fedex.com>
References: <Pine.LNX.4.58.0402101434260.27213@boston.corp.fedex.com>
 <20040209225336.1f9bc8a8.akpm@osdl.org> <Pine.LNX.4.58.0402102150150.17289@silk.corp.fedex.com>
 <20040210082514.04afde4a.akpm@osdl.org> <Pine.LNX.4.58.0402100827100.2128@home.osdl.org>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 02/11/2004
 09:06:46 PM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 02/11/2004
 09:06:48 PM,
	Serialize complete at 02/11/2004 09:06:49 PM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 02/11/2004
 09:06:49 PM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Feb 2004, Linus Torvalds wrote:

> On Tue, 10 Feb 2004, Andrew Morton wrote:
> > ah, thanks.
> > Like this?
> That will just break. The reason for the "compiler.h" include is the
> "__user" part of fpstate, so now you'll get a parse error later if
> non-kernel code includes this.
>
> So the rule should still be: don't include kernel headers from user
> programs. But if it's needed for some reason, that #ifdef needs to be
> somewhere else (inside "compiler.h" or something).

So, what's wrong with the patch I posted earlier. I've verified that it
works with just one place to patch, and that makes all warnings went away.

Patch attached here again.

Thanks,
Jeff

--- linux-2.6.2/include/linux/compiler-gcc2.h	Wed Feb  4 11:45:02 2004
+++ linux-2.6.3-rc2/include/linux/compiler-gcc2.h	Tue Feb 10 14:30:04 2004
@@ -12,6 +12,10 @@
 # define __builtin_expect(x, expected_value) (x)
 #endif

+#ifdef __attribute_used__
+#undef __attribute_used__
+#endif
+
 #define __attribute_used__	__attribute__((__unused__))

 /*
