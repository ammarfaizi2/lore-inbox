Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262443AbVBYEsg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262443AbVBYEsg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 23:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262446AbVBYEsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 23:48:33 -0500
Received: from fire.osdl.org ([65.172.181.4]:7298 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262443AbVBYErp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 23:47:45 -0500
Date: Thu, 24 Feb 2005 20:46:46 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jay Lan <jlan@sgi.com>
Cc: linux-kernel@vger.kernel.org, guillaume.thouvenin@bull.net,
       tim@physik3.uni-rostock.de, kaigai@ak.jp.nec.com, jbarnes@sgi.com
Subject: Re: [PATCH 2.6.11-rc4-mm1] end-of-proces handling for acct-csa
Message-Id: <20050224204646.704680e9.akpm@osdl.org>
In-Reply-To: <421EA8FF.1050906@sgi.com>
References: <421EA8FF.1050906@sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jay Lan <jlan@sgi.com> wrote:
>
> Since my idea of providing an accounting framework was considered
>  'overkill', here i submit a tiny patch just to allow CSA to
>  handle end-of-process (eop) situation by saving off accounting
>  data before a task_struct is disposed.
> 
>  This patch is to modify the acct_process() in acct.c, which is
>  invoked from do_exit() to handle eop for BSD accounting. Now
>  the acct_process() wrapper will also take care of CSA, if it has
>  been loaded. If the CSA module has been loaded, a CSA routine
>  will be invoked to construct a CSA job record and to write the
>  record to the CSA accounting file.

I really don't want to have to (and shouldn't need to) become an accounting
person, but as there seems to be a communication problem somewhere..

Please, you guys are the subject matter experts.  Put your heads together
and come up with something.



We shouldn't be putting CSA stuff over here and ELSA stuff over there.

We should be putting our heads together and coming up with a sensible and
adequate accounting solution for Linux.  Or the kernel, at least.

The ELSA team appear to be able to do that in userspace with the existing
process accounting machinery and a single outcall from fork().  That's great.

Why is that not adequate for CSA?  What end-user features does CSA offer
that ELSA can not?  Could those features be implemented (in userspace) if
we also added an exit() outcall?

