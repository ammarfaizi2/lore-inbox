Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263121AbTHZIW4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 04:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263147AbTHZIWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 04:22:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:41177 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263121AbTHZIWy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 04:22:54 -0400
Date: Tue, 26 Aug 2003 01:25:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: arjanv@redhat.com, mingo@redhat.com, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Futex non-page-pinning fix
Message-Id: <20030826012529.7be1955f.akpm@osdl.org>
In-Reply-To: <20030826080759.GK13390@actcom.co.il>
References: <20030825231449.7de28ba6.akpm@osdl.org>
	<Pine.LNX.4.44.0308260233550.20822-100000@devserv.devel.redhat.com>
	<20030826000218.2ceaea1d.akpm@osdl.org>
	<1061884611.2982.4.camel@laptop.fenrus.com>
	<20030826080759.GK13390@actcom.co.il>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Muli Ben-Yehuda <mulix@mulix.org> wrote:
>
> > > umm, how about hashing only on offset into page?  That reduces the number of
>  > > threads which need to be visited in futex_wake() by a factor of up to 1024.
>  > 
>  > How likely do you consider it that we then get a major collision?
>  > I wouldn't be surprised if, say, glibc lays some hot futexes out in a
>  > way that's the same for all processes in the system, like start of the
>  > page.... Might as well not hash :)
> 
>  How about combining something that's shared to all of the threads that
>  share a futex but not system wide (the mm?) with something simple that
>  won't change, like the page offset?

The mm's could well be independent.

Some userspace help would be needed to avoid defeating the hash.  In the
case where a bunch of threads with a shared mm are waiting on the same
futex things should automatically be OK.

