Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268278AbUJJM22@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268278AbUJJM22 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 08:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268279AbUJJM22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 08:28:28 -0400
Received: from mail01.hpce.nec.com ([193.141.139.228]:13499 "EHLO
	mail01.hpce.nec.com") by vger.kernel.org with ESMTP id S268278AbUJJM1N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 08:27:13 -0400
From: Erich Focht <efocht@hpce.nec.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [Lse-tech] [RFC PATCH] scheduler: Dynamic sched_domains
Date: Sun, 10 Oct 2004 14:25:00 +0200
User-Agent: KMail/1.6.2
Cc: colpatch@us.ibm.com, LSE Tech <lse-tech@lists.sourceforge.net>,
       Paul Jackson <pj@sgi.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Andrew Morton <akpm@osdl.org>, ckrm-tech@lists.sourceforge.net,
       LKML <linux-kernel@vger.kernel.org>, simon.derr@bull.net,
       frankeh@watson.ibm.com
References: <1097110266.4907.187.camel@arrakis> <200410090113.40589.efocht@hpce.nec.com> <416727C6.5000000@yahoo.com.au>
In-Reply-To: <416727C6.5000000@yahoo.com.au>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410101425.00486.efocht@hpce.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 09 October 2004 01:50, Nick Piggin wrote:
> Erich Focht wrote:
> 
> >>I personally like the hierarchical idea.  Machine topologies tend to
> >>look tree-like, and every useful sched_domain layout I've ever seen has
> >>been tree-like.  I think our interface should match that.
> > 
> > 
> > I like the hierarchical idea, too. The natural way to build it would
> > be by starting from the cpus and going up. This tree stands on its
> > leafs... and I'm not sure how to express that in a filesystem.
> > 
> 
> Why would you ever want to play around with the internals of the
> thing though? Provided you have a way to create exclusive sets of
> CPUs, when would you care about doing more?

Three reasons come immediately to my mind:
- Move the sched domains setup out of the kernel into user
space. With my proposal of filesystem with directory operations only
(just moving cpuX virtual files around) the boot setup should just be:
   global/
          cpu1
          cpu2
          ...
The rest could be done very machine and load specific in user
space. This way the kernel scheduler wouldn't need to struggle keeping
up learning characteristics of new machines as they appear on the
radar.

- I sometimes want to create/ destroy isolated partitions at high rate
(through a batch scheduler) and a reasonable API enables me to keep
the domains consistent at any time.

- Flexibility of isolated partitions is a bare necessity. If you
simply divide your system into interactive and batch partition you'd
certainly want to decrease the size of the interactive partition
during the night without rebooting the machine...

Regards,
Erich



