Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130485AbQKOWFT>; Wed, 15 Nov 2000 17:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130569AbQKOWFK>; Wed, 15 Nov 2000 17:05:10 -0500
Received: from mail11.voicenet.com ([207.103.0.37]:59858 "HELO voicenet.com")
	by vger.kernel.org with SMTP id <S130485AbQKOWE4>;
	Wed, 15 Nov 2000 17:04:56 -0500
Date: Wed, 15 Nov 2000 16:34:50 -0500
From: safemode <safemode@voicenet.com>
To: Guus Sliepen <guus@warande3094.warande.uu.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: (iptables) ip_conntrack bug?
Message-ID: <20001115163450.E4089@psuedomode>
In-Reply-To: <20001115154603.D4089@psuedomode> <20001115221922.L13682@sliepen.warande.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20001115221922.L13682@sliepen.warande.net>; from guus@sliepen.warande.net on Wed, Nov 15, 2000 at 16:19:23 -0500
X-Mailer: Balsa 1.0.pre2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 15 Nov 2000 16:19:23 Guus Sliepen wrote:
> On Wed, Nov 15, 2000 at 03:46:03PM -0500, safemode wrote:
> 
> > I was DDoS'd today while away and came home to find the firewall unable
> to
> > do anything network related (although my connection to irc was still
> > working oddly).  a quick dmesg showed the problem.
> > ip_conntrack: maximum limit of 2048 entries exceeded
> [...]
> 
> I have also seen this happen on a box which ran test9. Apparently because
> of
> it's long uptime, because the logs should no signs of an attack.
> 
> I guess conntrack forgets to flush some entries? Or maybe there is no way
> it can
> recover from a full conntrack table? Is it maybe necessary to make the
> maximum
> size a configurable option? Or a userspace conntrack daemon like the
> arpd?

	I think something is wrong if the ip_conntrack module does not
flush it's table after the connections and all that stop. I understand why
it does this during the attack...but it doesn't make sense why these tables
are kept long after.  A userspace tool is not something i think is needed,
this piece of code should be in the module, it is either not correctly
coded or missing entirely.


> I also see a lot of messages like this (on all 2.4 test kernels):
> 
> NAT: 0 dropping untracked packet c00643f0 1 131.211.122.89 -> 224.0.0.2
> NAT: 0 dropping untracked packet c05468e0 1 131.211.122.89 -> 224.0.0.2
> NAT: 0 dropping untracked packet c0064760 1 131.211.122.31 -> 224.0.0.2
> 
> Turning of multicast on the respective network interface does not stop
> these
> messages, but anyway they seem rather annoying to me :)


Everyone has seen that :)   ... that's not exactly what i was talking about
the main error message i was worried about was the "ip_conntrack: maximum
limit of 2048 entries exceeded" when there was absolutely not traffic
coming in and the attack was long since over.  I think this is a fairly
major bug with the module since it made the firewall inoperable until i
reloaded the module..  this DDoS could be repeated on any linux box that is
not babysat 24/7 it seems.  My firewall drops everything so all the
attacker needs to do is get a bunch of sources to send packets (specific?
not sure) rapidly enough to fill the ip_conntrack table and your site
becomes offline.   any other ideas?


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
