Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264754AbTCEIPE>; Wed, 5 Mar 2003 03:15:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264756AbTCEIPE>; Wed, 5 Mar 2003 03:15:04 -0500
Received: from buitenpost.surfnet.nl ([192.87.108.12]:47028 "EHLO
	buitenpost.surfnet.nl") by vger.kernel.org with ESMTP
	id <S264754AbTCEIPD>; Wed, 5 Mar 2003 03:15:03 -0500
Date: Wed, 5 Mar 2003 09:25:20 +0100
To: Brian Litzinger <brian@top.worldcontrol.com>, linux-kernel@vger.kernel.org
Subject: Re: Booting 2.5.63 vs 2.4.20 I can read multicast data
Message-ID: <20030305082519.GA920@pangsit>
References: <20030304073939.GA31394@top.worldcontrol.com> <20030304223953.GA3114@pangsit> <20030305061102.GA8473@top.worldcontrol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030305061102.GA8473@top.worldcontrol.com>
X-Mailer: Mutt on Debian GNU/Linux sid
X-Editor: vim
X-Organisation: SURFnet bv
X-Address: Radboudburcht, P.O. Box 19035, 3501 DA Utrecht, NL
X-Phone: +31 302 305 305
X-Telefax: +31 302 305 329
User-Agent: Mutt/1.5.3i
From: Niels den Otter <otter@surfnet.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian,

On Tuesday,  4 March 2003, brian@worldcontrol.com wrote:
> The apps I have vlc, and mpeg2dec (with mods) cannot read multicast
> data under 2.5.63, but both work under 2.4.20.
> 
> I also have some PERL tools which do multicasting stuff and they don't
> work any longer either.
> 
> However, I added 'eth0' to the IO::Socket::Multicast::mcast_add() 
> call and now the data is showing up.
> 
> I believe this means back in the C/C++ paradigm you can't rely on
> INADDR_ANY to do the right thing.  So you may have to set the specific
> IP of the interface you want your multicast data to come from in
> imr_interface.s_addr of the struct ip_mreq you pass in via setsockopt(
> sock, IPPROTO_IP, IP_ADD_MEMBERSHIP, ...
> 
> I'll give this a try and let you know what I find.

But lot of multicast applications use INADDR_ANY and most don't provide
an option to choose a specific interface. So I really think that the
kernel should bind the application to an ethernet interface and not to
the loopback interface to make them work.

Can you please check if it tries to bind to the loopback interface when
using INADDR_ANY by checking 'netstat -n -g' output?


-- Niels
