Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261347AbRE3Rio>; Wed, 30 May 2001 13:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261353AbRE3Rie>; Wed, 30 May 2001 13:38:34 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:26896 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S261347AbRE3RiX>; Wed, 30 May 2001 13:38:23 -0400
Date: Wed, 30 May 2001 13:02:05 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Steve Whitehouse <Steve@ChyGwyn.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Zerocopy NBD
In-Reply-To: <200105301715.SAA21607@gw.chygwyn.com>
Message-ID: <Pine.LNX.4.21.0105301258460.5110-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 30 May 2001, Steve Whitehouse wrote:

> Hi,
> 
> > 
> > On Wed, 30 May 2001, Steve Whitehouse wrote:
> > >
> [info about NBD patch deleted] 
> > >
> > Cool. 
> > 
> > Are you seeing performance improvements with the patch ?
> >  
> 
> Yes, but my testing is not in anyway complete yet. The only network device
> I have which is supported by zerocopy is loopback and there appear to be
> problems with deadlocks when using NBD over loopback. So what I did was to
> modify the NBD server (the userland one from Pavel Machek's web site)
> so that it didn't actually do any disk I/O. It still copied the data from
> the network into a buffer on write and it returns zeroed buffers on read
> (not that thats important as only the write patch is affected in the patch).
> 
> I could then test using dd which is a bit artificial in that it creates
> large requests giving probably much more data per NBD request than would
> be usual under a filesystem load and hence also better with the zerocopy
> patch. A timed dd with 100000 blocks of 1k spent 1.2 secs of system time
> to do the write with NBD in 2.4.5 and 0.8 secs with my patch.

Copying bunchs of sequential data with 'dd' is OK for testing it ---
you're trying to measure only device speed, not fs speed. 

> Also it may well be possible to adjust the network stack's memory management
> to give better performance. I upped the values in tcp_[r|w]mem but I've
> not checked what different vaules would do to those figures.
> 
> I want to do some more testing though in case I've made an error somewhere
> in the method. I'd be particularly interested to hear from someone who
> has any results for real hardware. If I have time I'll look into whether
> the eepro100 or SysKonnect GigE cards could be made to support zerocopy
> as they are the ones I have here,


