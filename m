Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262544AbTJJGvM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 02:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262546AbTJJGvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 02:51:12 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:21774 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S262544AbTJJGvI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 02:51:08 -0400
Date: Fri, 10 Oct 2003 08:50:49 +0200
From: Willy Tarreau <willy@w.ods.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Willy TARREAU <willy@w.ods.org>, marcelo.tosatti@cyclades.com,
       andersen@codepoet.org, linux-kernel@vger.kernel.org
Subject: Re: iproute2 not compiling anymore
Message-ID: <20031010065049.GA6655@alpha.home.local>
References: <20031005130044.GA8861@pcw.home.local> <Pine.LNX.4.44.0310091051240.3040-100000@logos.cnet> <20031010001352.GA2728@pcw.home.local> <20031009224535.73a936e4.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031009224535.73a936e4.davem@redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Thu, Oct 09, 2003 at 10:45:35PM -0700, David S. Miller wrote:
> On Fri, 10 Oct 2003 02:13:52 +0200
> Willy TARREAU <willy@w.ods.org> wrote:
> 
> > I'm too tired to investigate more, so I should do it tomorrow. Here is the
> > compilation output, just in case it helps David. Please ask for .config if
> > needed, but I don't think so.
> 
> I know what's wrong, linux/in.h needs to include linux/socket.h
> Duh, I'll fix this up.

You're right, it now compiles. Here's the patch :

diff -urN linux-2.4.23-pre7/include/linux/in.h linux-2.4.23-pre7-fix/include/linux/in.h
--- linux-2.4.23-pre7/include/linux/in.h	Fri Oct 10 08:47:15 2003
+++ linux-2.4.23-pre7-fix/include/linux/in.h	Fri Oct 10 08:49:20 2003
@@ -19,6 +19,7 @@
 #define _LINUX_IN_H
 
 #include <linux/types.h>
+#include <linux/socket.h>
 
 /* Standard well-defined IP protocols.  */
 enum {
