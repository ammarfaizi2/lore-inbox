Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267954AbTCFJjw>; Thu, 6 Mar 2003 04:39:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267956AbTCFJjw>; Thu, 6 Mar 2003 04:39:52 -0500
Received: from adsl-67-115-104-87.dsl.sntc01.pacbell.net ([67.115.104.87]:33104
	"HELO laura.worldcontrol.com") by vger.kernel.org with SMTP
	id <S267954AbTCFJjv>; Thu, 6 Mar 2003 04:39:51 -0500
From: brian@worldcontrol.com
Date: Thu, 6 Mar 2003 01:49:11 -0800
To: Niels den Otter <otter@surfnet.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Booting 2.5.63 vs 2.4.20 I can read multicast data
Message-ID: <20030306094911.GA3398@top.worldcontrol.com>
Mail-Followup-To: Brian Litzinger <brian@top.worldcontrol.com>,
	Niels den Otter <otter@surfnet.nl>, linux-kernel@vger.kernel.org
References: <20030304073939.GA31394@top.worldcontrol.com> <20030304223953.GA3114@pangsit> <20030305061102.GA8473@top.worldcontrol.com> <20030305082519.GA920@pangsit>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030305082519.GA920@pangsit>
X-No-Archive: yes
X-Noarchive: yes
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tuesday,  4 March 2003, brian@worldcontrol.com wrote:
> > The apps I have vlc, and mpeg2dec (with mods) cannot read multicast
> > data under 2.5.63, but both work under 2.4.20.
> > 
> > I also have some PERL tools which do multicasting stuff and they don't
> > work any longer either.
> > 
> > However, I added 'eth0' to the IO::Socket::Multicast::mcast_add() 
> > call and now the data is showing up.
> > 
> > I believe this means back in the C/C++ paradigm you can't rely on
> > INADDR_ANY to do the right thing.  So you may have to set the specific
> > IP of the interface you want your multicast data to come from in
> > imr_interface.s_addr of the struct ip_mreq you pass in via setsockopt(
> > sock, IPPROTO_IP, IP_ADD_MEMBERSHIP, ...
> > 
> > I'll give this a try and let you know what I find.
> 
On Wed, Mar 05, 2003 at 09:25:20AM +0100, Niels den Otter wrote:
> But lot of multicast applications use INADDR_ANY and most don't provide
> an option to choose a specific interface. So I really think that the
> kernel should bind the application to an ethernet interface and not to
> the loopback interface to make them work.

I have to agree that the kernel is broke.  After further reading
the expected behavior looks well defined, and the apps along
with my code are designed properly.

> Can you please check if it tries to bind to the loopback interface when
> using INADDR_ANY by checking 'netstat -n -g' output?

I will do my best to give it a try. 

-- 
Brian Litzinger
