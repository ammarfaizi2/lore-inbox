Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315536AbSHDRYU>; Sun, 4 Aug 2002 13:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316185AbSHDRYU>; Sun, 4 Aug 2002 13:24:20 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:3797 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S315536AbSHDRYT>;
	Sun, 4 Aug 2002 13:24:19 -0400
Content-Type: text/plain; charset=US-ASCII
From: Hubertus Franke <frankeh@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
Organization: IBM Research
To: "David S. Miller" <davem@redhat.com>, davidm@hpl.hp.com,
       davidm@napali.hpl.hp.com
Subject: Re: large page patch (fwd) (fwd)
Date: Sun, 4 Aug 2002 13:25:42 -0400
User-Agent: KMail/1.4.1
Cc: torvalds@transmeta.com, gh@us.ibm.com, Martin.Bligh@us.ibm.com,
       wli@holomorpy.com, linux-kernel@vger.kernel.org
References: <15691.24200.512998.875390@napali.hpl.hp.com> <15692.12781.344389.519591@napali.hpl.hp.com> <20020803.173111.78037842.davem@redhat.com>
In-Reply-To: <20020803.173111.78037842.davem@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208041325.42210.frankeh@watson.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 03 August 2002 08:31 pm, David S. Miller wrote:
>    From: David Mosberger <davidm@napali.hpl.hp.com>
>    Date: Sat, 3 Aug 2002 12:41:33 -0700
>
>    It appears that Juan Navarro, the primary author behind the Rice
>    project, is working on breaking down the superpage benefits they
>    observed.  That would tell us how much benefit is due to page-coloring
>    and how much is due to TLB effects.  Here in our lab, we do have some
>    (weak) empirical evidence that some of the SPECint benchmarks benefit
>    primarily from page-coloring, but clearly there are others that are
>    TLB limited.
>
> There was some comparison done between large-page vs. plain
> page coloring for a bunch of scientific number crunchers.
>
> Only one benefitted from page coloring and not from TLB
> superpage use.
>

I would expect that from scientific apps, which often go through their
dataset in a fairy regular pattern. If sequential, then page coloring
is at its best, because your cache can become the limiting factor, if
you can't squeeze data into the cache due to false sharing in the same
cache class.

The way I see page coloring is that any hard work done in virtual space
(either by compiler or by app writer [ latter holds for numerical apps ])
to be cache friendly, is not circumvented by a <stupid> physical page 
assignment by the OS that leads to less than complete cache utilization.
That's why the cache index bits from the address are carried over or
are kept the same in virtual and physical address. That's the purpose of
page coloring.....

This regular access pattern is not necessarily true in apps like JVM or other 
object oriented code where data accesses can be less predictive. There page 
coloring might not help you at all.

> The ones that benefitted from both coloring and superpages, the
> superpage gain was about equal to the coloring gain.  Basically,
> superpages ended up giving the necessary coloring :-)
>
> Search for the topic "Areas for superpage discussion" in the
> sparclinux@vger.kernel.org list archives, it has pointers to
> all the patches and test programs involved.


-- 
-- Hubertus Franke  (frankeh@watson.ibm.com)
