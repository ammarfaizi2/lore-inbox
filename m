Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262458AbUKDWZ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262458AbUKDWZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 17:25:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262464AbUKDWYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 17:24:18 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:10958 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262458AbUKDWIm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 17:08:42 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: John Levon <levon@movementarian.org>
Subject: Re: contention on profile_lock
Date: Thu, 4 Nov 2004 14:08:28 -0800
User-Agent: KMail/1.7
Cc: William Lee Irwin III <wli@holomorphy.com>, Jack Steiner <steiner@sgi.com>,
       linux-kernel@vger.kernel.org, edwardsg@sgi.com, dipankar@in.ibm.com
References: <200411021152.16038.jbarnes@engr.sgi.com> <200411041249.21718.jbarnes@engr.sgi.com> <20041104215113.GA54024@compsoc.man.ac.uk>
In-Reply-To: <20041104215113.GA54024@compsoc.man.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411041408.28694.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, November 4, 2004 1:51 pm, John Levon wrote:
> On Thu, Nov 04, 2004 at 12:49:21PM -0800, Jesse Barnes wrote:
> > John pointed out that this breaks modules.  Would registering and
> > unregistering a function pointer thus be module safe?  Dipankar,
> > hopefully you have something better?
> >
> > static int timer_start(void)
> > {
> >  /* Setup the callback pointer */
> >  oprofile_timer_notify = oprofile_timer;
> >  return 0;
> > }
>
> Surely something like (profile.c):
>
> funcptr_t timer_hook;
>
> static int register_timer_hook(funcptr_t hook)
> {
>  if (timer_hook)
>   return -EBUSY;
>  timer_hook = hook;
> }
>
> static void unregister_timer_hook(funcptr_t hook)
> {
>  WARN_ON(hook != timer_hook);
>  timer_hook = NULL;
>  /* make sure all CPUs see the NULL hook */
>  synchronize_kernel();
> }

Yes, that's much better.  Will post another one shortly.  Thanks.

Jesse
