Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbUCDJUt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 04:20:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbUCDJUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 04:20:49 -0500
Received: from moutng.kundenserver.de ([212.227.126.184]:30430 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261567AbUCDJUr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 04:20:47 -0500
Date: Thu, 4 Mar 2004 10:20:41 +0100 (MET)
From: Armin Schindler <aml@melware.de>
To: Willy Tarreau <willy@w.ods.org>
cc: Armin Schindler <armin@melware.de>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4] sys_select() return error on bad file
In-Reply-To: <20040304072225.GA20915@alpha.home.local>
Message-ID: <Pine.LNX.4.31.0403041016190.16757-100000@phoenix.one.melware.de>
Organization: Cytronics & Melware
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:4f0aeee4703bc17a8237042c4702a75a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Mar 2004, Willy Tarreau wrote:
> Hi,
>
> On Wed, Mar 03, 2004 at 09:46:54AM +0100, Armin Schindler wrote:
> > --- linux/fs/select.c_orig	2004-03-02 19:06:44.000000000 +0100
> > +++ linux/fs/select.c	2004-03-03 09:25:24.000000000 +0100
> > @@ -183,6 +183,8 @@
> >  		wait = NULL;
> >  	retval = 0;
> >  	for (;;) {
> > +		int file_err = 1;
> > +
>
> Just a thought, select() is often performance-critical, and adding one more
> variable inside the loop can slow it down a bit. Wouldn't it be cheaper to
> set retval to -EBADF above and avoid using file_err ?

retval cannot be used for that, it may get changed in the loop.

Anyway, I don't see how your proposal would do better performance?
My patch just adds a new variable on the stack, which should not make any
difference in performance. And later, it is the same if the new or another
variable gets changed or checked.

Armin


