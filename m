Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265385AbSKOAZI>; Thu, 14 Nov 2002 19:25:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265400AbSKOAZI>; Thu, 14 Nov 2002 19:25:08 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:44200 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S265385AbSKOAZH>; Thu, 14 Nov 2002 19:25:07 -0500
Date: Thu, 14 Nov 2002 19:31:56 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: Tim Hockin <thockin@sun.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH 1/2] Remove NGROUPS hardlimit (resend w/o qsort)
Message-ID: <20021114193156.A2801@devserv.devel.redhat.com>
References: <mailman.1037316781.6599.linux-kernel2news@redhat.com> <200211150006.gAF06JF01621@devserv.devel.redhat.com> <3DD43C65.80103@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DD43C65.80103@sun.com>; from thockin@sun.com on Thu, Nov 14, 2002 at 04:14:29PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Thu, 14 Nov 2002 16:14:29 -0800
> From: Tim Hockin <thockin@sun.com>

> > 1. Why are arrays vmalloc-ed? This is a goochism which you have
> >    to justify.
> 
> Because they can be as large as root allows, and when we used kmalloc() 
> it would actually fail from time to time.

OK. I think in your case it's probably harmless. I thought
that two (order 1) 4K pages can hold 2000 4 byte group IDs,
and that "ought to be enough for anybody". If you envision
10,000 groups, then perhaps you are right, except that it may
be about time to think about your data structures a little more.
I'll let Andi to remind you about the performance impact (vmalloc
area is outside of the big TLB area).

> > 2. How do these changes sit with LLNL's changes to increase
> >    number of groups that NFS client can support? It's not
> >    a showstopper, but would be nice if you two cooperated.
> 
> hmm, I haven't heard anything about them - can you offer an email or URL?

http://www.uwsg.iu.edu/hypermail/linux/kernel/0010.0/0788.html

The sad part is that the patch was around since 2000, but the
effort to get it in was a little half-hearted, perhaps.
I am thinking about reviving it.

-- Pete
