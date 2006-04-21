Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932442AbWDUUyR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932442AbWDUUyR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 16:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932450AbWDUUyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 16:54:16 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:40360 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932442AbWDUUyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 16:54:16 -0400
Subject: Re: kfree(NULL)
From: Steven Rostedt <rostedt@goodmis.org>
To: Vernon Mauery <vernux@us.ibm.com>
Cc: kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <200604211330.30657.vernux@us.ibm.com>
References: <200604210703.k3L73VZ6019794@dwalker1.mvista.com>
	 <Pine.LNX.4.61.0604211643350.31515@yvahk01.tjqt.qr>
	 <20060421192217.GI19754@stusta.de>  <200604211330.30657.vernux@us.ibm.com>
Content-Type: text/plain
Date: Fri, 21 Apr 2006 16:54:13 -0400
Message-Id: <1145652853.32759.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-21 at 13:30 -0700, Vernon Mauery wrote:
> On Friday 21 April 2006 12:22, you wrote:

> > What makes you confident that the static inline version gives a time
> > saving?
> 
> A static inline wrapper would mean that it wouldn't have to make a function 
> call just to check if the pointer is NULL.  A simple NULL check is faster 
> than a function call and then a simple NULL check.  In other words, there 
> would be no pushing and popping the stack.  In almost all cases, replacing an 
> inline function with a non-inline function means a trade-off between speed 
> and size.

Andrew Morton just submitted a patch to -mm that fixes the two problem
places that called kfree(NULL) more than it calls kfree(non-NULL).

Besides the places that are now fixed, the inline doesn't save much.
Since most cases kfree(non-NULL) is called, so the NULL is really an
unlikely case.  Thus you just increased the size of the kernel, for
virtually no speed savings.

-- Steve


