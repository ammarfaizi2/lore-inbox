Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265336AbSLRRL0>; Wed, 18 Dec 2002 12:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266006AbSLRRL0>; Wed, 18 Dec 2002 12:11:26 -0500
Received: from pc132.utati.net ([216.143.22.132]:39562 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S265336AbSLRRLZ> convert rfc822-to-8bit; Wed, 18 Dec 2002 12:11:25 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
To: John Bradford <john@grabjohn.com>, ptb@it.uc3m.es (Peter T. Breuer)
Subject: Re: Difference between dummy and loopback interfaces
Date: Mon, 16 Dec 2002 07:02:26 +0000
User-Agent: KMail/1.4.3
Cc: ahtraps@yahoo.com, linux-kernel@vger.kernel.org
References: <200212101031.gBAAVTjI000445@darkstar.example.net>
In-Reply-To: <200212101031.gBAAVTjI000445@darkstar.example.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212160702.26327.landley@trommello.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 December 2002 10:31, John Bradford wrote:
> > > I can't think of a condition where a dummy device is useful (other than
> > > for simulating a blackhole device which sucks every packet sent to it).
> >
> > The dummy device is conventionally used to provide a separate interface
> > that can be used to bind the hostname to when there is no real nic in
> > the box to bind it to (binding it to loopback being a no no).
>
> Slackware binds the hostname to 127.0.0.1 by default.  As pointed out
> in comments in the /etc/hosts file, it is technically incorrect, but
> it does work, and it's fine on a non-networked machine.
>
> John.

Um, random aside:

You can attach firewall rules to a dummy0 interface that you can't attach to 
and alias of lo.  I don't remember exactly what failed (it was a while ago), 
but when I tried to "ifconfig lo:1 10.0.0.1 netmask 255.255.255.0" and then 
attach a boatload of firewall rules to it, it got confused.  (It had 
something against -j DNAT in the OUTPUT table, if I recall.  I was also 
having trouble getting packets originating from the loopback interface to 
route outside of the box.  But again, this was a while ago, so I don't 
remember exactly what was wrong.  It was a roll-your-own VPN solution that 
was designed for a machine with 2 network cards acting as a gateway, but 
needed to run on a box that had just one network card yet wanted to 
participate in the VPN...)

Moving over to the dummy interface instead of loopback made it all work.  
Loopback really isn't designed to do anything but bounce packets off of 
127.0.0.1 for local delivery.  It's optimized for that.  The dummy interface 
is more generic.

Rob

(On the other hand, "ifconfig dummy0 down" doesn't actually remove its ip from 
the routing table under 2.4, last I checked.  Annoying, that.  You've got to 
ifconfig it to something else to make it stop receiving packets, even though 
it's down!  I hit that a LOT in testing, sshing to my own box when I didn't 
mean to, and then wondering what the heck was going wrong...)

-- 
penguicon.sf.net - A combination Linux Expo and Science Fiction Convention 
with GOHs Terry Pratchett, Eric Raymond, Pete Abrams, Illiad & CmdrTaco.
