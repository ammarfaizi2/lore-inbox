Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264819AbUETAx1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264819AbUETAx1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 20:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264820AbUETAx0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 20:53:26 -0400
Received: from ozlabs.org ([203.10.76.45]:9346 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264819AbUETAxZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 20:53:25 -0400
Subject: Re: [PATCH] Remove bogus WARN_ON in futex_wait
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andi Kleen <ak@suse.de>
Cc: Muli Ben-Yehuda <mulix@mulix.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20040519125001.3866f830.ak@suse.de>
References: <20040519122350.2792e050.ak@suse.de>
	 <20040519104339.GG31630@mulix.org>  <20040519125001.3866f830.ak@suse.de>
Content-Type: text/plain
Message-Id: <1085013927.7624.5.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 20 May 2004 10:52:46 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-05-19 at 20:50, Andi Kleen wrote:
> On Wed, 19 May 2004 13:43:40 +0300
> Muli Ben-Yehuda <mulix@mulix.org> wrote:
> 
> > On Wed, May 19, 2004 at 12:23:50PM +0200, Andi Kleen wrote:
> > > 
> > > futex_wait goes to an interruptible sleep, but does a WARN_ON later
> > > if it wakes up early. But waking up early is totally legal, since
> > > the sleep is interruptible and any signal can wake it up.
> > 
> > That's not what the WARN_ON is saynig, unless I'm missing
> > something. It's checking if we were woken up early and there's no
> > signal pending for us. 
> 
> True. Anyways, it seems to happen in practice.

Which we've been trying to figure out.  We return -EINTR in this case
even though it's a lie.  Don't know if it breaks anything, but I
*really* want to know who the buggy waker is before pronouncing it
harmless.

Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

