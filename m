Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135966AbRDTQlH>; Fri, 20 Apr 2001 12:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135970AbRDTQk7>; Fri, 20 Apr 2001 12:40:59 -0400
Received: from coruscant.franken.de ([193.174.159.226]:47120 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S135969AbRDTQkn>; Fri, 20 Apr 2001 12:40:43 -0400
Date: Fri, 20 Apr 2001 13:28:19 -0300
From: Harald Welte <laforge@gnumonks.org>
To: "Manfred Bartz" <md-linux-kernel@logi.cc>
Cc: linux-kernel@vger.kernel.org
Subject: [Counters] Re: IP Acounting Idea for 2.5
Message-ID: <20010420132819.C2461@tatooine.laforge.distro.conectiva>
In-Reply-To: <BF9651D8732ED311A61D00105A9CA3150446D9FF@berkeley.gci.com> <20010417011320.7149.qmail@logi.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.14i
In-Reply-To: <20010417011320.7149.qmail@logi.cc>; from md-linux-kernel@logi.cc on Tue, Apr 17, 2001 at 11:13:19AM +1000
X-Operating-System: Linux tatooine.laforge.distro.conectiva 2.4.2-ac20
X-Date: Today is Setting Orange, the 37th day of Discord in the YOLD 3167
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17, 2001 at 11:13:19AM +1000, Manfred Bartz wrote:

> I had a brief look at MRTG.  It seems to be a well written app and
> while it can handle counter reset (with potential loss of an unknown 
> amount of data), it does not actively reset counters.  It also doesn't
> use iptables.

Yes, that's the whole point. If you want to have some kind of per-ip / 
per-network accounting, I'd rather recommend using something else
(i.e. an accounting module attaching to the netfilter hook itself,
something using the ULOG target to do the logging in userspace, ...)

Just reading out the per-rule counters always introduces problems as soon
as your ruleset changes. And when do you have a really static ruleset?
There are always new services/... to configure.

> Agreed too.  Counters should not arbitrarily be equipped with a reset
> capability, there is hardly any benefit in that and it causes nothing
> but problems.

so what about iptables-save at shutdown time and iptables-restore at 
bootup time? Then you can have your counters persist even after kernel
upgrades / reboots / crashes / ... 

> As far as I can see, the counters in /proc/net/snmp don't have a
> reset, same with /proc/net/dev and possibly other counters elsewhere.

Yes, because it is per network device, not per some arbitrarily inserted
rule which can be changed all the time. As I've stated more than once
in this thread, and as you just continue to say: just delete and re-insert
the rule, and you have your counter reset.

> Ideally iptables would fall in line with that.  Rules can still be
> unloaded and reloaded, also causing counter reset and loss of data,
> but since that is a lot more involved, application authors would have
> an incentive to handle counters properly.

I don't think that the iptables kernel part should remove some feature
just because there are application programmers wrongly designing their
applications.


> Manfred Bartz

-- 
Live long and prosper
- Harald Welte / laforge@gnumonks.org                http://www.gnumonks.org
============================================================================
GCS/E/IT d- s-: a-- C+++ UL++++$ P+++ L++++$ E--- W- N++ o? K- w--- O- M- 
V-- PS+ PE-- Y+ PGP++ t++ 5-- !X !R tv-- b+++ DI? !D G+ e* h+ r% y+(*)
