Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269155AbUJQO6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269155AbUJQO6P (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 10:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269157AbUJQO6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 10:58:15 -0400
Received: from findaloan.ca ([66.11.177.6]:62849 "EHLO vhosts.findaloan.ca")
	by vger.kernel.org with ESMTP id S269155AbUJQO6J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 10:58:09 -0400
Date: Sun, 17 Oct 2004 10:52:59 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: David Schwartz <davids@webmaster.com>
Cc: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Message-ID: <20041017145259.GB10280@mark.mielke.cc>
Mail-Followup-To: David Schwartz <davids@webmaster.com>,
	"Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
References: <20041016062512.GA17971@mark.mielke.cc> <MDEHLPKNGKAHNMBLJOLKMEONPAAA.davids@webmaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKMEONPAAA.davids@webmaster.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 16, 2004 at 05:28:24PM -0700, David Schwartz wrote:
> > Sure, but this isn't about the future, remember. The kernel
> > already has the
> > information to know whether there is data, or whether there isn't. It just
> > isn't doing the work to find out.
> The kernel does not have the information yet. It could get it, but it does
> not have it.

You are wrong, David. The kernel *does* have the information. I haven't
seen anybody except you deny this.

What has been said, is that it is considered too expensive to do the check
at select() time, based on the information that *is* available.

> > Allowed by who? For select() to say data is ready, and read() to block,
> > is not allowed by all the standards that I have read. This is the first
> > time I have ever heard of a situation like this, for select(). It is *not*
> > the same as writing an arbitrary number of bytes, or accepting.
> So is it your position that a kernel cannot drop a UDP packet at any time
> after it indicated that the socket was readable because of that packet? If
> so, please cite where in POSIX you think you find this requirement.

Not after select() has stated that the packet is ready for
reading. That is correct. I would to the definition of select() that
was posted earlier in this thread. You've chosen to ignore this
definition, it seems.

> The kernel elects to drop the packet on the call to 'recvmsg'. This is its
> right -- it can drop a UDP packet at any time. POSIX is careful not to imply
> that 'select' guarantees future behavior because this is not possible in
> principle.

Not future behaviour. POSIX, based on the definition of select() would seem
to suggest that, in a delayed-drop implementation such as Linux's, that
select() should feel free to drop the corrupt packet. recvmsg() just makes
the use of select() with blocking sockets unreasonable. Don't you see this?

> > You say it will not break any application that could not already be broken
> > by other circumstances. I disagree. For example, a UDP-based server that
> > only receives, and never sends, would be perfectly happy to select() on
> > several file descriptors, and readmesg() whenever the UDP file descriptor
> > says readable. It would not break on other operating systems that
> > implement
> > select() to be useful for determining whether or not to read() from a
> > blocking file descriptor.
> 	Sure it would. It would break on any platform that dropped a UDP packet
> after having triggered a read hit on 'select' because of that packet. POSIX
> does not say that a future read will not block because it cannot guarantee
> that under at least some circumstances.

Again - we're not talking about the future. Get off that. The packet
is already in the queue. Linux already has the information to know whether
the packet will be dropped or not.

If you want to say that select() on blocking sockets is invalid, please
say it. Don't recommend against it. Say - the use of select() on blocking
sockets is invalid under Linux. Put it in documentation that people will
read.

That's all we want.

Cheers,
mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

