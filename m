Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261469AbSIZT5d>; Thu, 26 Sep 2002 15:57:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261470AbSIZT5d>; Thu, 26 Sep 2002 15:57:33 -0400
Received: from Morgoth.esiway.net ([193.194.16.157]:45060 "EHLO
	Morgoth.esiway.net") by vger.kernel.org with ESMTP
	id <S261469AbSIZT5a>; Thu, 26 Sep 2002 15:57:30 -0400
Date: Thu, 26 Sep 2002 22:02:41 +0200 (CEST)
From: Marco Colombo <marco@esi.it>
To: Rik van Riel <riel@conectiva.com.br>
cc: Marco Colombo <marco@esi.it>, Ernst Herzberg <earny@net4u.de>,
       Adam Goldstein <Whitewlf@Whitewlf.net>, <linux-kernel@vger.kernel.org>
Subject: Re: Very High Load, kernel 2.4.18, apache/mysql
In-Reply-To: <Pine.LNX.4.44L.0209261627000.1837-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.44.0209262141320.26363-100000@Megathlon.ESI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Sep 2002, Rik van Riel wrote:

> On Thu, 26 Sep 2002, Marco Colombo wrote:
> > On Thu, 26 Sep 2002, Ernst Herzberg wrote:
> >
> > > MaxClients 256  # absolute minimum, maybe you have to recompile apache
> > > MinSpareServers 100  # better 150 to 200
> > > MaxSpareServers 200 # bring it near MaxClients
> >
> > KeepAlive		On
> > MaxKeepAliveRequests	1000
> 
> That sounds like an extraordinarily bad idea.  You really
> don't want to have ALL your apache daemons tied up with
> keepalive requests.

[this is sliding OT]

# MaxKeepAliveRequests: The maximum number of requests to allow
# during a persistent connection. Set to -1 to allow an unlimited amount.
# We recommend you leave this number high, for maximum performance.
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

(what "high" means is the question here, I believe)

> Personally I never have MaxKeepAliveRequests set to more
> than 2/3 of MaxClient.

There's a timeout (15 sec, by default), which kicks idle clients away.

I guess it depends on the kind of load. If you're serving just static pages,
I agree. If you're serving dynamic pages via SQL queries (expecially with
authenticated connection), "session" setup cost may dominate.


Anyway, it's the "extraordinarily bad" part that I don't get.

Say we set MaxKeepAliveRequests to 190 (~2/3 of 256) instead of 1000.

How many requests does a client perform before it hits the 15 sec idle
timer?  Is it 189? The apache process is stuck in the timeout phase
anyway. Is it 191? Then the first apache process drops the keepalive
connection, the client reconnects to a second server process, which
is stuck again in the timeout phase. Or am I missing something?

> 
> Rik
> 

.TM.

