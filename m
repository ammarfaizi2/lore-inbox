Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965041AbVHZBa2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965041AbVHZBa2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 21:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965042AbVHZBa1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 21:30:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15800 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965041AbVHZBa1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 21:30:27 -0400
Date: Thu, 25 Aug 2005 18:28:55 -0700
From: Andrew Morton <akpm@osdl.org>
To: jerome lacoste <jerome.lacoste@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cache regresions with 2.6.1x ?
Message-Id: <20050825182855.439a9c2e.akpm@osdl.org>
In-Reply-To: <5a2cf1f60508240319256ba61@mail.gmail.com>
References: <5a2cf1f60508220421d0914f8@mail.gmail.com>
	<20050822215356.5f6a30fd.akpm@osdl.org>
	<5a2cf1f60508240319256ba61@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jerome lacoste <jerome.lacoste@gmail.com> wrote:
>
> On 8/23/05, Andrew Morton <akpm@osdl.org> wrote:
>  > jerome lacoste <jerome.lacoste@gmail.com> wrote:
>  > >
>  > > I am on a Dell Inspiron 8100 laptop with 512 M and 1G disk cache. I
>  > >  usually have at least 4 big applications running simultaneously: a
>  > >  Java IDE, firefox, firefox and X. All that under the Gnome desktop.
>  > >
>  > >  I've sometimes seen periods where my laptop goes kind of nuts. While
>  > >  the cpu is still at 0%, the workload goes to 100% (as shown in the
>  > >  gnome process monitor) (I haven't checked in other means, e.g. top or
>  > >  /proc info as my machine is unusable).
>  > >
>  > >  But with my latest upgrade to 2.6.12 from 2.6.10, the hanging happens
>  > >  much more often. It lasts for over 30 seconds.
>  > >
>  > >  Could this hanging be related to swapping?
>  > >  Are there any VM regression lately that would make a kernel less
>  > >  appropriate for desktop use?
>  > >  How can I investigate that further?
>  > 
>  > 10-20 lines of `vmstat 1' output while it's happening would help.
> 
>  Here it goes. Maybe just some bad swapping?

Maybe.  There's certainly a ton of swapping happening.

>  jerome@expresso> vmstat 1
>  procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
>   r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
>   1  7 588164   7424  18612 106908   13    7    34    44   10    12  8  2 85  5
>   2  4 587996   6152  18624 108092  404  664   540  2892 1201  2631 70  9  0 21
>   0 12 588276   5160  18620 109188  664 1244   860  1244 1195   615 46  5  0 50
>   0 13 588140   4912  18628 109188  216    0   216     8 1156   245  0  0  0 100
>   0 17 588536   4892  18628 109972  132  576   132   576 1172   353 32  4  0 64
>   0 16 589096   5016  18628 110192    0  608     4   628 1169   247  7  2  0 91
>   0 16 589780   5636  18632 110136    0  716     0   808 1181   261  1  0  0 99

But maybe a memory leak.  Can you take a copy of /proc/meminfo and
/proc/slabinfo when this is happening?

