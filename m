Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315412AbSFJOE0>; Mon, 10 Jun 2002 10:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315370AbSFJODe>; Mon, 10 Jun 2002 10:03:34 -0400
Received: from mark.mielke.cc ([216.209.85.42]:40720 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S315335AbSFJODN>;
	Mon, 10 Jun 2002 10:03:13 -0400
Date: Mon, 10 Jun 2002 09:57:02 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: jamal <hadi@cyberus.ca>
Cc: "David S. Miller" <davem@redhat.com>, ltd@cisco.com,
        greearb@candelatech.com, cfriesen@nortelnetworks.com,
        linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: RFC: per-socket statistics on received/dropped packets
Message-ID: <20020610095702.A27037@mark.mielke.cc>
In-Reply-To: <20020610.051857.97850707.davem@redhat.com> <Pine.GSO.4.30.0206100821310.20296-100000@shell.cyberus.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2002 at 08:24:44AM -0400, jamal wrote:
> On Mon, 10 Jun 2002, David S. Miller wrote:
> >    From: Lincoln Dale <ltd@cisco.com>
> >    Date: Mon, 10 Jun 2002 22:03:25 +1000
> >    would you be willing to accept a patch that enables per-socket
> >    accounting with a CONFIG_ option?
> > What is the point?
> > If all the dists will enable it then everybody eats the overhead.
> > If the dists don't enable it, how useful is it and what's so wrong
> > with it being an external patch people just apply when they need to
> > diagnose something like this?
> I think i would agree with Dave for it to be an external patch. You
> really only need this during debugging. I had a similar patch when
> debugging NAPI about a year ago. I didnt find it that useful after
> a while because i could deduce the losses from SNMP/netstat output.

In your case you found that you could solve it once by debugging the
application.

This doesn't mean that other applications would not be better at
determining the code path to use at execution time.

Just because eth1 is behaving perfectly (i.e. low overall dropped UDP
packets, or low TCP/IP retransmission) does not mean that a specific
socket currently on eth1 heading to China should assume that it can
take the 'average' observation as adequate for observing the specific
socket.

There *are* applications that would benefit from making this decision
at run time on a socket-by-socket basis. It is not a common requirement
for most desktop users, but it remains a valid requirement.

Providing it as a patch, can have the effect that it becomes more trouble
than it is worth to grant other people access to the feature, especially
from a corporate environment that has signed off on being able to release
patches made to Linux back to the Linux source tree.

Seems somewhat of a loss...

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

