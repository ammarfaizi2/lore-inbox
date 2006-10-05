Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751320AbWJEB5z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbWJEB5z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 21:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbWJEB5z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 21:57:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42464 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751320AbWJEB5y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 21:57:54 -0400
Date: Wed, 4 Oct 2006 18:57:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Cc: Reinette Chatre <reinette.chatre@linux.intel.com>,
       Joe Korty <joe.korty@ccur.com>, Paul Jackson <pj@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bitmap: separate bitmap parsing for user buffer and
 kernel buffer
Message-Id: <20061004185747.4cb64048.akpm@osdl.org>
In-Reply-To: <200610041833.40866.inaky@linux.intel.com>
References: <200610041756.30528.reinette.chatre@linux.intel.com>
	<20061004181003.6dae6065.akpm@osdl.org>
	<200610041833.40866.inaky@linux.intel.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Oct 2006 18:33:37 -0700
Inaky Perez-Gonzalez <inaky@linux.intel.com> wrote:

> On Wednesday 04 October 2006 18:10, Andrew Morton wrote:
> > On Wed, 4 Oct 2006 17:56:30 -0700
> > Reinette Chatre <reinette.chatre@linux.intel.com> wrote:
> > > +			if (is_user) {
> > > +				if (__get_user(c, buf++))
> > > +					return -EFAULT;
> > > +			}
> > > +			else
> > > +				c = *buf++;
> >
> > Is this actually needed?  __get_user(kernel_address) works OK and (believe
> > it or not, given all the stuff it involves) boils down to a single
> > instruction.
> 
> We weren't too sure if that'd be true in all kinds of arches and
> memory models. If it works for kernel space too, then we can fold
> out a lot of code...

We use __get_user() in this fashion in several places in core kernel
already, although it's usually to find out "will this address give me a
fault", rather than to actually read a value.

There's some precedent for the `is_user' approach as well - it has the
advantage of being more sparse-friendly, and perhaps clearer to read.
