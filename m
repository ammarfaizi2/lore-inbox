Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132503AbRDQBus>; Mon, 16 Apr 2001 21:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132512AbRDQBui>; Mon, 16 Apr 2001 21:50:38 -0400
Received: from coruscant.franken.de ([193.174.159.226]:64519 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S132503AbRDQBu2>; Mon, 16 Apr 2001 21:50:28 -0400
Date: Mon, 16 Apr 2001 22:43:21 -0300
From: Harald Welte <laforge@gnumonks.org>
To: "Manfred Bartz" <md-linux-kernel@logi.cc>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IP Acounting Idea for 2.5
Message-ID: <20010416224321.O16697@corellia.laforge.distro.conectiva>
In-Reply-To: <Pine.LNX.4.33.0104152039130.1616-100000@asdf.capslock.lan> <01041708461209.00352@workshop> <20010416020732.30431.qmail@logi.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.14i
In-Reply-To: <20010416020732.30431.qmail@logi.cc>; from md-linux-kernel@logi.cc on Mon, Apr 16, 2001 at 12:07:31PM +1000
X-Operating-System: Linux corellia.laforge.distro.conectiva 2.4.3
X-Date: Today is Sweetmorn, the 33rd day of Discord in the YOLD 3167
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 16, 2001 at 12:07:31PM +1000, Manfred Bartz wrote:
> 
> If there really is a performance issue with a few hundred rules, then
> it can be overcome by grouping rules in separate custom chains.  F.e.
> if you have 1024 rules create 32 custom chains with 32 rules each.
> Then have 32 rules in your main table which jump to the appropriate
> custom chain --> maximum rules traversed by each packet = 64.

still.. if you want to log multiple class B's it's a PITA, especially
if your ruleset changes and you have to atomically replace all chains
in one table to update the ruleset from userspace->kernel.

> There is another issue with logging in general:
> 
>                 *COUNTERS MUST NOT BE RESETABLE!!!*
> 
> Resetable counters guarantee that no two programs can co-exists if
> they happen to reset the same counters.

That sounds like crap (sorry). Counters are resettable, and will be.
If you run two applications resetting counters individually, you have
a problem with your applications.

> All logging counters should be implemented with 32bit or 64bit
> unsigned integers.  Any software using correct unsigned integer

they are uint32 right now.

> arithmetic can then simply subtract a previous value from the current
> value to get the difference.  This works reliably across counter
> wrap-arounds.  There is absolutely *no need for reset* !

so why are your applications resetting counters then? Nobody forces you
to reset them right now.

> Manfred Bartz
> ---------------------------------------------------------------

-- 
Live long and prosper
- Harald Welte / laforge@gnumonks.org                http://www.gnumonks.org
============================================================================
GCS/E/IT d- s-: a-- C+++ UL++++$ P+++ L++++$ E--- W- N++ o? K- w--- O- M- 
V-- PS+ PE-- Y+ PGP++ t++ 5-- !X !R tv-- b+++ DI? !D G+ e* h+ r% y+(*)
