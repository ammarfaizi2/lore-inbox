Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269156AbUJQOxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269156AbUJQOxN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 10:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269155AbUJQOxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 10:53:13 -0400
Received: from findaloan.ca ([66.11.177.6]:60545 "EHLO vhosts.findaloan.ca")
	by vger.kernel.org with ESMTP id S269156AbUJQOxD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 10:53:03 -0400
Date: Sun, 17 Oct 2004 10:47:53 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: David Schwartz <davids@webmaster.com>
Cc: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Message-ID: <20041017144753.GA10280@mark.mielke.cc>
Mail-Followup-To: David Schwartz <davids@webmaster.com>,
	"Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
References: <20041017000626.GA27055@mark.mielke.cc> <MDEHLPKNGKAHNMBLJOLKKEOOPAAA.davids@webmaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKKEOOPAAA.davids@webmaster.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 16, 2004 at 05:30:23PM -0700, David Schwartz wrote:
> > I'm not sure that either is reasonable behaviour. The socket buffers
> > don't increase or decrease at run time, do they? If they do shrink at
> > run time, this is news to me...
> The socket buffers are not guaranteed to indicate a particular number of
> bytes in a sense that it meaningful to the application. In fact, on Linux,
> they don't mean application bytes.

I believe this also means, that it doesn't happen, correct? So why is the
subject being changed?

> In any event, we aren't talking about any particular implementation, we are
> talking about a standard. So what Linux does or doesn't do in response to
> memory pressure isn't relevant. What's relevant is what the standard
> actually guarantees and what the semantics of the protocols themselves are.

Yes, we are talking about a standard. I'm talking about POSIX, and the
related standards that describe select(), and read()/recvmsg().

> UDP is not reliable. Packets can be dropped, mangled, and lost. Nothing in
> POSIX prohibits an implementation from dropping a packet right before you
> call 'recvmsg'.

You seem to believe that the definition of UDP supercedes every and
all standards that describe select() and read()/recvmsg(). Selecting
your standards based on your preference and comfort level. Who gave
you the right to do this for Linux? Why does your comfort level allow
you to take the 'drop' freedom of UDP to the extreme, ignore POSIX, and
so on, that make the behaviour of select() on blocking file descriptors
reliable in certain specific regards (*including* this one, from the
interpretation of more than one person), and then not outright honestly
declare that *nobody* should use select() on blocking file descriptors,
because it isn't reliable under Linux? Why talk of recommendations, or
explanations? select() for blocking file descriptors under Linux leads
to programs being susceptible to DOS attacks. You don't recommend against
it. You fix it, or just say: Don't use the system calls this way - it isn't
supported under Linux.

I've said all this before, and you've said your piece before. Is there
a particular reason you want to just recommend against it's use, instead
of declaring it invalid under Linux? (blocking sockets with select())

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

