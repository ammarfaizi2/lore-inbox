Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273202AbRIJEyd>; Mon, 10 Sep 2001 00:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273203AbRIJEyX>; Mon, 10 Sep 2001 00:54:23 -0400
Received: from alcove.wittsend.com ([130.205.0.20]:62848 "EHLO
	alcove.wittsend.com") by vger.kernel.org with ESMTP
	id <S273201AbRIJEyO>; Mon, 10 Sep 2001 00:54:14 -0400
Date: Mon, 10 Sep 2001 00:54:31 -0400
From: "Michael H. Warfield" <mhw@wittsend.com>
To: "Trever L. Adams" <vichu@digitalme.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [OT] LDAP vs NIS+ security
Message-ID: <20010910005431.A4839@alcove.wittsend.com>
Mail-Followup-To: "Trever L. Adams" <vichu@digitalme.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3B9C204A.7070801@digitalme.com> <20010909234039.A4229@alcove.wittsend.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010909234039.A4229@alcove.wittsend.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 09, 2001 at 11:40:39PM -0400, Michael H. Warfield wrote:
> On Sun, Sep 09, 2001 at 10:07:06PM -0400, Trever L. Adams wrote:
> > I am sorry to write this off topic message.  I should probably go look 
> > in google for the answer... however -

> > Someone in arguing about implimenting directory services into the kernel 
> > said that NIS+ will always be more secure than LDAP over SSL... why is this?

> 	FIIK...  /;-(

> 	NIS (FKA Sun Yellow Pages) was so insecure it became know as
> the "Network Intruder Service".  NIS+ was suppose to address most of
> the NIS security issues and it did to a large extent, but created
> more than a few problems along the way (having had to managed a mixed
> Sun OS 4.x and Solaris 2.x environment, I have more than my share of
> horror stories).

	Oh!  Almost forgot the best one of all (and more related to
the directory service issue than problems with the password map).

	If you combine YP/NIS/NIS+ with something like the finger
service and you have a large enough user identification base, you
create this niffty DoS attack that I called "nisnuke" at the time
I published the security advisory years ago.

	Basically, if you have a sufficiently large user database and
I can get to enough finger servers, I can time finger requests into an
NIS* network in a way that crushes the INTERNAL bandwidth destructively.
With an experimental setup of only 10 finger servers and 1,000 users
in the NIS maps I was able to uses a 30 second blast from perl script to
cripple the test network for over 30 minutes.  While most Linux systems
recovered quickly, Solaris boxes took minutes to recover (most Solaris
boxes had the screen savers freeze during the resulting NIS "storm") and
some AIX boxes had to be power cycled.  Most boxes would not even toggle
the "caps lock" light on the keyboard during the meltdown period.

	Note that the storm of NIS traffic cripples the internal bandwidth
between the finger servers and the NIS[+] servers.  This takes out everyone
on that network, not just the NIS and finger servers.  The conditions
create a situation where RPC retries and failures (due to collisions)
actually exceed the input to the cable you are generating from the
finger traffic.  It's a queueing theory meltdown where the input to
the queue is higher than it's capacity.

	Sun worked for months trying to solve the problem and the best they
could come up with was to either "disable finger" or "install and open
source version of the finger service which did not do wild card expansion
on the databases".

	This was all documented in an Internet Security Systems Advisory
which I authored several years ago.  AFAIK, if you put an NIS or NIS+
network together with a large enough user base and a few finger servers,
I can cripple it with NIS traffic and tear it to it's knees and keep
it there.  And all finger is doing is "directory lookups" on users.  :-/

	See BugTraq or ISS Alert archives for more information.

	Mike
-- 
 Michael H. Warfield    |  (770) 985-6132   |  mhw@WittsEnd.com
  (The Mad Wizard)      |  (678) 463-0932   |  http://www.wittsend.com/mhw/
  NIC whois:  MHW9      |  An optimist believes we live in the best of all
 PGP Key: 0xDF1DD471    |  possible worlds.  A pessimist is sure of it!

