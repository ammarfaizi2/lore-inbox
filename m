Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264040AbUDBNTU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 08:19:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264043AbUDBNTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 08:19:20 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:9609 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S264040AbUDBNTQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 08:19:16 -0500
Date: Fri, 2 Apr 2004 15:17:51 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.6.5-rc2 __WAITQUEUE_INITIALIZER
Message-ID: <20040402131751.GF13329@louise.pinerecords.com>
References: <5648.1080539353@kao2.melbourne.sgi.com> <20040328225322.05ac9f7b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040328225322.05ac9f7b.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > When struct __wait_queue is on stack or you reuse an existing
> > waitqueue, you get garbage in the flags.
> > 
> > Index: 5-rc2.1/include/linux/wait.h
> > --- 5-rc2.1/include/linux/wait.h Thu, 18 Dec 2003 16:46:13 +1100 kaos (linux-2.6/m/c/34_wait.h 1.1 644)
> > +++ 5-rc2.1(w)/include/linux/wait.h Mon, 29 Mar 2004 15:36:39 +1000 kaos (linux-2.6/m/c/34_wait.h 1.1 644)
> > @@ -40,6 +40,7 @@ typedef struct __wait_queue_head wait_qu
> >   */
> >  
> >  #define __WAITQUEUE_INITIALIZER(name, tsk) {				\
> > +	.flags		= 0,						\
> >  	.task		= tsk,						\
> >  	.func		= default_wake_function,			\
> >  	.task_list	= { NULL, NULL } }
> 
> The compiler will do this for us?

Yes, but only for statics (I believe).

-- 
Tomas Szepe <szepe@pinerecords.com>
