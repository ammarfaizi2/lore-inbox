Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264692AbUEaQ6e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264692AbUEaQ6e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 12:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264693AbUEaQ6e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 12:58:34 -0400
Received: from fw.osdl.org ([65.172.181.6]:50379 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264692AbUEaQ6d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 12:58:33 -0400
Date: Mon, 31 May 2004 09:58:30 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Peter Osterlund <petero2@telia.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, trond.myklebust@fys.uio.no
Subject: Re: Linux 2.6.7-rc2
In-Reply-To: <m3y8n93qak.fsf@telia.com>
Message-ID: <Pine.LNX.4.58.0405310955420.4573@ppc970.osdl.org>
References: <Pine.LNX.4.58.0405292349110.1632@ppc970.osdl.org>
 <m3y8n93qak.fsf@telia.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 31 May 2004, Peter Osterlund wrote:
> 
> If I put "#if 0" around the *wdata assignment in nfs_writepage_sync,
> the stack usage goes down to 36, so it looks like gcc is building a
> temporary structure on the stack and then copies the whole thing to
> *wdata.

Yeah, that's silly. But understandable. A lot of problems go away by doing 
a temporary private node..

> Does this construct save stack space for any version of gcc? Maybe the
> code should be changed to do a memset() followed by explicit
> initialization of the non-zero member variables instead.

In this case, I'd agree.

In some other cases, it's better to create a initialized static variable, 
and just use that as an initial initializer. In this case that doesn't 
much help, since none of the fields are constant.

Trond?

		Linus
