Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316726AbSEWORL>; Thu, 23 May 2002 10:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316729AbSEWORK>; Thu, 23 May 2002 10:17:10 -0400
Received: from chaos.analogic.com ([204.178.40.224]:2944 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S316726AbSEWORI>; Thu, 23 May 2002 10:17:08 -0400
Date: Thu, 23 May 2002 10:17:07 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Padraig Brady <padraig@antefacto.com>
cc: will fitzgerald <william.fitzgerald6@beer.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Question:kernel profiling and readprofile
In-Reply-To: <3CECF70C.1060208@antefacto.com>
Message-ID: <Pine.LNX.3.95.1020523101008.329A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 May 2002, Padraig Brady wrote:

> will fitzgerald wrote:
> > hi all,
> > 
> > i stumbled accross a command called readprofile by accident and found 
> > that by appening the line append="profile=2" to the lilo.conf file 
> > and using thread profile command you can get statistics on functions 
> > that spend a certain amount of time doing a job.
> > 
> > i done some searching on this and can't find anything other than a 
> > man page on readprofile.
> > 
> > can anyone tell me what does the line append="profile=2" actually do 
> > apart from creating the file profile in the proc directory, what is 
> > the 2 for in this line?
> 
> The level. see linux/Documentation/kernel-parameters.txt
> Also worth looking at is http://oss.sgi.com/projects/kernprof/
> 
> > next is this an accurate way to measure heady traffic load through 
> > say a linux router?
> 
> I presume you don't want to actually measure traffic throughput
> as there are obviously other ways to do this.
> 
> > will it highlight all functions say for example 
> > ip_forward, dev_queue_xmit etc etc that are being opverloaded due to 
> > huge traffic loads being passed through the router. ie will it spot 
> > bottlenecks with good accuracy?
> 
> yes that's the idea.
> 
> > any feedback is welcomed,
> > regards will.
> 
> Also note CONFIG_NET_PROFILE=Y which writes more network specific
> profile data to /proc/net/profile, which you'll have to figure
> out how to parse.
> 
> Also I think it was reported that there were some problems
> with profiling (missing symbols) around 2.5.8? I don't know
> whether it's been fixed.
> 
> Also I don't think you can profile modules, but there was a patch...
> http://marc.theaimsgroup.com/?l=linux-kernel&m=101663078100596&w=2
> 
> Padraig.

FYI, you can do a low-overhead profile on a Linux router just by
recording the network-card interrupts-per-time-unit. All done in
low-overhead user-mode. This assumes that your network-card IRQ
is not shared.

If the interrupts/time get above some level, you then alter routes,
bring other routers on-line, etc. Or in the case of Samba servers, shut
them down on heavy-beaten machines and start them up on others.
This load-balancing works. Actually, you shut-down the Samba Name server
so you don't disconnect existing clients, but new clients go to an
alternate machine.

The metering for all kinds of automatic reconfiguration can be
done on the basis of interrupts/second and it works quite well.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

