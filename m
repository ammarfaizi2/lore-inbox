Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbQLBQh3>; Sat, 2 Dec 2000 11:37:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129345AbQLBQhT>; Sat, 2 Dec 2000 11:37:19 -0500
Received: from adsl-151-196-236-79.baltmd.adsl.bellatlantic.net ([151.196.236.79]:42836
	"EHLO vaio.greennet") by vger.kernel.org with ESMTP
	id <S129324AbQLBQhL> convert rfc822-to-8bit; Sat, 2 Dec 2000 11:37:11 -0500
Date: Sat, 2 Dec 2000 11:09:35 -0500 (EST)
From: Donald Becker <becker@scyld.com>
To: Francois Romieu <romieu@cogenit.fr>
cc: Russell King <rmk@arm.linux.org.uk>, Chris Wedgwood <cw@f00f.org>,
        Ivan Passos <lists@cyclades.com>, linux-kernel@vger.kernel.org,
        netdev@oss.sgi.com
Subject: Re: [RFC] Configuring synchronous interfaces in Linux
In-Reply-To: <20001201140042.A8572@se1.cogenit.fr>
Message-ID: <Pine.LNX.4.10.10012021041460.16980-100000@vaio.greennet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Dec 2000, Francois Romieu wrote:

> Russell King <rmk@arm.linux.org.uk> écrit :
> [...]
> > We already have a standard interface for this, but many drivers do not
> > support it.  Its called "ifconfig eth0 media xxx":

Uhmmm, it's not a standard if "many drivers do not support it".

It is very easy to hack up code to handle one or two drivers.
But you shouldn't claim the problem is fixed until the approach is tested
with all of the driver.

Hey, I'll make it easy.  Find an approach that fully handles only the Tulip
and 3c59x drivers, and that is consistent.

I'll start you out: the possible 100baseTx configurations for the 3c59x
driver are SYM transceiver, MII transceiver, and "NWay" transceiver.  The
latter two may use autonegotiation, only speed autosensing, or a fixed
speed.  The SYM transceiver version can do static speed sensing.

[[ Note static speed sensing on the 3c595 is potentially evil.  The chip
must generate 100baseTx link beat while checking for 100baseTx link beat.
This commonly hoses a 10baseT repeater with constant collisions.  So does
"auto speed" mean "check for 100baseTx link beat, even though I sense
10baseT" or "do the safe thing and stick with 10baseT". ]]

> Ok. Hmmm... If I want to do something like 
> 'ifconfig scc0 media some_frequency up' as I hope to set scc0 as a DCE (or 
> ifconfig scc0 media auto up' for a DTE), I must teach ifconfig.c to 
> distinguish Ethernet and synchrone interface based on interface.type,
> right ?

Correct.  And just speed isn't good enough for Ethernet.  We have 1/10HPNA,
100base-Fx,Tx,T4.

We should not just give up.
My point is that the issue isn't a trivial one.
Media selection code is the most time consuming and error prone code in many
drivers.  I would have avoiding doing that work if there had been an easy
answer.

Donald Becker				becker@scyld.com
Scyld Computing Corporation		http://www.scyld.com
410 Severn Ave. Suite 210		Second Generation Beowulf Clusters
Annapolis MD 21403			410-990-9993

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
