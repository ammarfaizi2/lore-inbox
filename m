Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269034AbUIXW6H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269034AbUIXW6H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 18:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269038AbUIXW6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 18:58:07 -0400
Received: from fw.osdl.org ([65.172.181.6]:56978 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269034AbUIXW56 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 18:57:58 -0400
Date: Fri, 24 Sep 2004 16:01:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: Steven Pratt <slpratt@austin.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] Simplified Readahead
Message-Id: <20040924160147.27dbc589.akpm@osdl.org>
In-Reply-To: <4154A2F7.1050909@austin.ibm.com>
References: <4152F46D.1060200@austin.ibm.com>
	<20040923194216.1f2b7b05.akpm@osdl.org>
	<41543FE2.5040807@austin.ibm.com>
	<20040924150523.4853465b.akpm@osdl.org>
	<4154A2F7.1050909@austin.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Pratt <slpratt@austin.ibm.com> wrote:
>
> >It's an application-specified readahead hint.  It should ideally be
> >asynchronous so the application can get some I/O underway while it's
> >crunching on something else.  If the queue is contested then the
> >application will accidentally block when launching the readahead, which
> >kinda defeats the purpose.
> >  
> >
> Well if the app really does this asynchronously, does it matter that we 
> block?

??  Not sure what you mean.

posix_fadvise(POSIX_FADV_WILLNEED) is used by applications to tell the
kernel that the application will need that part of the file in the future. 
Presumably, the application has something else to be going on with
meanwhile.  Hence the application doesn't want to block.

> >Yes, the application will block when it does the subsequent read() anyway,
> >but applications expect to block in read().  Seems saner this way.
> >
> Just to be sure I have this correct, the readahead code will be invoked 
> once on the POSIX_FADV_WILLNEED request, but this looks mostly like a 
> regular read, and then again for the same pages on a real read?


yup.  POSIX_FADV_WILLNEED should just populate pagecache and should launch
asynchronous I/O.
