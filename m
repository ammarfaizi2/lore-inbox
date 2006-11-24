Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934378AbWKXMOF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934378AbWKXMOF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 07:14:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934477AbWKXMOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 07:14:05 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:5316 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S934378AbWKXMOC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 07:14:02 -0500
Date: Fri, 24 Nov 2006 15:13:12 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Ulrich Drepper <drepper@redhat.com>
Cc: David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>
Subject: Re: [take25 1/6] kevent: Description.
Message-ID: <20061124121312.GD32545@2ka.mipt.ru>
References: <11641265982190@2ka.mipt.ru> <456621AC.7000009@redhat.com> <20061124120531.GC32545@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20061124120531.GC32545@2ka.mipt.ru>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Fri, 24 Nov 2006 15:13:13 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2006 at 03:05:31PM +0300, Evgeniy Polyakov (johnpol@2ka.mipt.ru) wrote:
> On Thu, Nov 23, 2006 at 02:33:16PM -0800, Ulrich Drepper (drepper@redhat.com) wrote:
> > Evgeniy Polyakov wrote:
> > >+ int kevent_commit(int ctl_fd, unsigned int start, 
> > >+ 	unsigned int num, unsigned int over);
> > 
> > I think we can simplify this interface:
> > 
> >    int kevent_commit(int ctl_fd, unsigned int new_tail,
> >                      unsigned int over);
> > 
> > The kernel sets the ring_uidx value to the 'new_tail' value if the tail 
> > pointer would be incremented (module wrap around) and is not higher then 
> > the current front pointer.  The test will be a bit complicated but not 
> > more so than what the current code has to do to check for mistakes.
> > 
> > This approach has the advantage that the commit calls don't have to be 
> > synchronized.  If one thread sets the tail pointer to, say, 10 and 
> > another to 12, then it does not matter whether the first thread is 
> > delayed.  If it will eventually be executed the result is simply a no-op 
> > and since second thread's action supersedes it.
> > 
> > Maybe the current form is even impossible to use with explicit locking 
> > at userlevel.  What if one thread, which is about to call kevent_commit, 
> > if indefinitely delayed.  Then this commit request's value is never 
> > taken into account and the tail pointer is always short of what it 
> > should be.
> 
> I like this interface, although current one does not allow special

...does not require...

> synchronization in userspace, since it calculates if new commit is in
> the area where previous commit was.
> Will change for the next release.

-- 
	Evgeniy Polyakov
