Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262309AbTHZILQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 04:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262856AbTHZILP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 04:11:15 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:30077 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S262309AbTHZILN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 04:11:13 -0400
Date: Tue, 26 Aug 2003 10:11:04 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: Arjan van de Ven <arjanv@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Futex non-page-pinning fix
Message-ID: <20030826101104.C1835@devserv.devel.redhat.com>
References: <20030825231449.7de28ba6.akpm@osdl.org> <Pine.LNX.4.44.0308260233550.20822-100000@devserv.devel.redhat.com> <20030826000218.2ceaea1d.akpm@osdl.org> <1061884611.2982.4.camel@laptop.fenrus.com> <20030826080759.GK13390@actcom.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030826080759.GK13390@actcom.co.il>; from mulix@mulix.org on Tue, Aug 26, 2003 at 11:08:00AM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 26, 2003 at 11:08:00AM +0300, Muli Ben-Yehuda wrote:
> On Tue, Aug 26, 2003 at 09:56:51AM +0200, Arjan van de Ven wrote:
> > On Tue, 2003-08-26 at 09:02, Andrew Morton wrote:
> > 
> > > umm, how about hashing only on offset into page?  That reduces the number of
> > > threads which need to be visited in futex_wake() by a factor of up to 1024.
> > 
> > How likely do you consider it that we then get a major collision?
> > I wouldn't be surprised if, say, glibc lays some hot futexes out in a
> > way that's the same for all processes in the system, like start of the
> > page.... Might as well not hash :)
> 
> How about combining something that's shared to all of the threads that
> share a futex but not system wide (the mm?) with something simple that
> won't change, like the page offset? Adding the mm into the mix wil
> make collisions harder, and limiting the buckets to the number of
> different futex offsets will make it simple and differentiate between
> different futexes in the same mm. 

The problem is that you can (and
want to) share futexes between different processes via shm....
glibc actualy uses this to implement cross-process posix mutexes (mutici?)
