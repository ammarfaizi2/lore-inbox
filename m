Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266815AbUHISUl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266815AbUHISUl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 14:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266816AbUHISRd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 14:17:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:61416 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266815AbUHISOs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 14:14:48 -0400
Date: Mon, 9 Aug 2004 11:13:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: josha@sgi.com, linux-kernel@vger.kernel.org, steiner@sgi.com
Subject: Re: [PATCH] Reduce bkl usage in do_coredump
Message-Id: <20040809111306.2091858a.akpm@osdl.org>
In-Reply-To: <1092072631.6496.14553.camel@nighthawk>
References: <41178C49.3080305@sgi.com>
	<1092072631.6496.14553.camel@nighthawk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <haveblue@us.ibm.com> wrote:
>
>  > -       format_corename(corename, core_pattern, signr);
>  > +       /* 
>  > +        * lock_kernel() because format_corename() is controlled by sysctl, which
>  > +        * uses lock_kernel()
>  > +        */
>  > +       lock_kernel();
>  > +       format_corename(corename, core_pattern, signr);
>  > +       unlock_kernel();
> 
>  Might be nicer to just put the locking inside of format_corename() if it
>  is the function itself that really needs the locking.

Nope.  format_corename() just takes a char *.  It has no knowledge about
what that char*'s locking rules are.  It's the caller who chose to use a
char* which is protected by lock_kernel().
