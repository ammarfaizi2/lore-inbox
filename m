Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265144AbUJHDB7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265144AbUJHDB7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 23:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267451AbUJHC5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 22:57:48 -0400
Received: from findaloan.ca ([66.11.177.6]:62181 "EHLO findaloan.ca")
	by vger.kernel.org with ESMTP id S267766AbUJHC4A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 22:56:00 -0400
Date: Thu, 7 Oct 2004 22:51:48 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: "David S. Miller" <davem@davemloft.net>
Cc: Chris Friesen <cfriesen@nortelnetworks.com>, martijn@entmoot.nl,
       hzhong@cisco.com, jst1@email.com, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk, davem@redhat.com
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Message-ID: <20041008025148.GA724@mark.mielke.cc>
Mail-Followup-To: "David S. Miller" <davem@davemloft.net>,
	Chris Friesen <cfriesen@nortelnetworks.com>, martijn@entmoot.nl,
	hzhong@cisco.com, jst1@email.com, linux-kernel@vger.kernel.org,
	alan@lxorguk.ukuu.org.uk, davem@redhat.com
References: <00e501c4ac9a$556797d0$b83147ab@amer.cisco.com> <41658C03.6000503@nortelnetworks.com> <015f01c4acbe$cf70dae0$161b14ac@boromir> <4165B9DD.7010603@nortelnetworks.com> <20041007150035.6e9f0e09.davem@davemloft.net> <4165C20D.8020808@nortelnetworks.com> <20041007152634.5374a774.davem@davemloft.net> <4165C58A.9030803@nortelnetworks.com> <20041007154204.44e71da6.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041007154204.44e71da6.davem@davemloft.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2004 at 03:42:04PM -0700, David S. Miller wrote:
> On Thu, 07 Oct 2004 16:39:06 -0600
> Chris Friesen <cfriesen@nortelnetworks.com> wrote:
> > However, you chopped off what I consider the interesting part of my
> > post.  I propose that if we call select() on a blocking file
> > descriptor, we verify the checksum before saying that the socket is
> > readable.  Then, at recvmsg() time, if it hasn't been checked
> > already we would check it (to allow for the case of blocking socket
> > without select()).
> So people who improperly use select() with blocking sockets get punished
> in a different way, with half the performance compared to today?

No. People who use select() and read() in the *other* documented
manner, however ill-advised, would see the expected, and at least from
the perspective of myself and a few other people around here, correct
behaviour. How much it costs to implement the correct behaviour is a
different concern, and perhaps one these people should have considered
when determining whether or not to use O_NONBLOCK...

Your position, I believe has been that the use of select() on a blocking
file descriptor is invalid. Taking this to an extreme, select() should
return EBADF or something to that effect, when passed a file descriptor
that does not have O_NONBLOCK set...

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

