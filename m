Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262568AbUCJKsq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 05:48:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262386AbUCJKsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 05:48:46 -0500
Received: from ozlabs.org ([203.10.76.45]:34285 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262568AbUCJKsp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 05:48:45 -0500
Subject: Re: [PATCH] call_usermodehelper needs to wait longer
From: Rusty Russell <rusty@rustcorp.com.au>
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040310082416.GA5084@in.ibm.com>
References: <20040309135143.GB26645@in.ibm.com>
	 <20040309133835.2343565c.akpm@osdl.org>  <20040310082416.GA5084@in.ibm.com>
Content-Type: text/plain
Message-Id: <1078915663.23776.4.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 10 Mar 2004 21:47:43 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-03-10 at 19:24, Srivatsa Vaddagiri wrote:
> On Tue, Mar 09, 2004 at 01:38:35PM -0800, Andrew Morton wrote:
> > I'm not so sure about this.  There are deadlock potentials if the usermode
> > application wants to perform some function which requires keventd services
> > to complete - the application cannot complete because keventd is itself
> > waiting for the application.
> > 
> > Can we think of any circumstances under which keventd _should_
> > synchronously wait for the userspace app?
> 
> Honestly I don't know ..Would it be reasonable for somebody
> to call request_module from a work function (in which case the above
> bug is exposed)? I agree it is not a nice thing if we block keventd
> waiting for the app to exit. 

I think a BUG_ON(wait) is arguably right here: anyone trying it will hit
it immediately.  Perhaps a "/* keventd shouldn't block */" comment above
it would help.

Cheers,
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

