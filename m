Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286871AbSASSiF>; Sat, 19 Jan 2002 13:38:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286893AbSASShz>; Sat, 19 Jan 2002 13:37:55 -0500
Received: from adsl-196-233.cybernet.ch ([212.90.196.233]:2536 "HELO
	mailphish.drugphish.ch") by vger.kernel.org with SMTP
	id <S286871AbSASShs>; Sat, 19 Jan 2002 13:37:48 -0500
Message-ID: <3C49BC1D.8050901@drugphish.ch>
Date: Sat, 19 Jan 2002 19:34:05 +0100
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: Stefan Rompf <srompf@isg.de>
Cc: linux-kernel@vger.kernel.org, jgarzik@mandrakesoft.com
Subject: Re: Interface operative status detection
In-Reply-To: <3C498CC9.6FAED2AF@isg.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 > interface, f.e. the ethernet link beat. This is a major show stopper

> against using Linux for "serious" IP routing.

[...]

> So what about the following idea: The network interface drivers use the
> netif_carrier_on() and netif_carrier_off() functions to update their
> interface card status (a bunch of drivers already do). To get this
> information forwarded to user mode via netlink socket, we use a kernel
> thread that goes through the device list, and everytime IFF_RUNNING
> and netif_carrier_ok() differ, IFF_RUNNING is updated and a message is
> sent via netlink.


A slightely different approach could be to use the alternative routes 
using the patch from Julian Anastasov [1] and set RTNH_F_BADSTATE. With 
the RTNH_F_DEAD we can select a new route in the multipath route setup.

You set up multiple routes and in case of link state problems you mark 
the route dead and the routeing code will not select the routes defined 
with that interface anymore. Together with an active NUD you get a 
fairly decent responsive HA system. But maybe I'm way off-topic and I 
missunderstood your concerns.

[1] http://www.linux-vs.org/~julian/01_alt_routes-2.4.12-5.diff

Cheers,
Roberto Nibali, ratz

