Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317063AbSHGFXi>; Wed, 7 Aug 2002 01:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317066AbSHGFXi>; Wed, 7 Aug 2002 01:23:38 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:31459 "EHLO
	lists.samba.org") by vger.kernel.org with ESMTP id <S317063AbSHGFXh>;
	Wed, 7 Aug 2002 01:23:37 -0400
Date: Wed, 7 Aug 2002 15:24:23 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: "David S. Miller" <davem@redhat.com>
Cc: george@mvista.com, willy@debian.org, kuznet@ms2.inr.ac.ru,
       linux-kernel@vger.kernel.org
Subject: Re: softirq parameters
Message-Id: <20020807152423.3577a5cc.rusty@rustcorp.com.au>
In-Reply-To: <20020804.223746.89817190.davem@redhat.com>
References: <20020804172650.N24631@parcelfarce.linux.theplanet.co.uk>
	<3D4D668F.3A29DD10@mvista.com>
	<20020804.223746.89817190.davem@redhat.com>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 04 Aug 2002 22:37:46 -0700 (PDT)
"David S. Miller" <davem@redhat.com> wrote:

>    From: george anzinger <george@mvista.com>
>    Date: Sun, 04 Aug 2002 10:38:23 -0700
> 
>    Matthew Wilcox wrote:
>    > what do you guys think about this patch?  nobody's using the data argument
>    > to the softirq routines, but most of the routines want to know which
>    > CPU they're running on.
>    
>    I would vote no on this.  While no one is currently using
>    the data argument, it would be _hard_ to replace it if it
>    were needed.  The cpu, on the other hand, is available
>    regardless of it being passed or not and thus does not
>    _need_ to be passed.
> 
> Furthermore, this is one of the most important hot paths in
> the entire kernel, any simplification and or improvement
> in code generated to implement these paths is desirable.
> 
> I fully supporty Matthew's change.

Partially agree.  Removing all args might be worthwhile.  But all these
softirqs use the "cpu" arg to access per-cpu data, which should be
changed to use the per_cpu_data mechanism anyway, which removes the
point of the arg.

Things haven't been changed over because I haven't pushed the per-cpu
interface changes (required for some archs 8() to Linus yet.  But you'll
want them so we can save space (you only need allocate per-cpu data for
cpus where cpu_possible(i) is true).

Clear?
Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
