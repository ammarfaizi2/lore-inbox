Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262780AbTCEGBo>; Wed, 5 Mar 2003 01:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262806AbTCEGBo>; Wed, 5 Mar 2003 01:01:44 -0500
Received: from adsl-67-115-104-87.dsl.sntc01.pacbell.net ([67.115.104.87]:12624
	"HELO laura.worldcontrol.com") by vger.kernel.org with SMTP
	id <S262780AbTCEGBo>; Wed, 5 Mar 2003 01:01:44 -0500
From: brian@worldcontrol.com
Date: Tue, 4 Mar 2003 22:11:02 -0800
To: Niels den Otter <otter@surfnet.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Booting 2.5.63 vs 2.4.20 I can read multicast data
Message-ID: <20030305061102.GA8473@top.worldcontrol.com>
Mail-Followup-To: Brian Litzinger <brian@top.worldcontrol.com>,
	Niels den Otter <otter@surfnet.nl>, linux-kernel@vger.kernel.org
References: <20030304073939.GA31394@top.worldcontrol.com> <20030304223953.GA3114@pangsit>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030304223953.GA3114@pangsit>
X-No-Archive: yes
X-Noarchive: yes
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Monday,  3 March 2003, brian@worldcontrol.com wrote:
> > I give the 2.5 series a try every once in a while and found the 2.5.63
> > booted and ran reasonably well.
> > 
> > I happen to working on some multicast stuff and found that I can't
> > read multicast data when running 2.5.63.

On Tue, Mar 04, 2003 at 11:39:53PM +0100, Niels den Otter wrote:
> You appear to be strugling with the same problem I have. What I find is
> that the multicast application binds to the loopback instead of ethernet
> interface (also no IGMP joins are send out on the ethernet interface).
> Can you please check the output of 'netstat -n -g' and see if the
> multicast address shows up at the correct interface?

The apps I have vlc, and mpeg2dec (with mods) cannot read
multicast data under 2.5.63, but both work under 2.4.20.

I also have some PERL tools which do multicasting stuff and
they don't work any longer either.

However, I added 'eth0' to the IO::Socket::Multicast::mcast_add() 
call and now the data is showing up.

I believe this means back in the C/C++ paradigm you can't rely on
INADDR_ANY to do the right thing.  So you may have to set the
specific IP of the interface you want your multicast data to
come from in imr_interface.s_addr of the struct ip_mreq you pass
in via setsockopt( sock, IPPROTO_IP, IP_ADD_MEMBERSHIP, ...

I'll give this a try and let you know what I find.

-- 
Brian Litzinger
