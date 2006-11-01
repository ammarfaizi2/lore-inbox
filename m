Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992708AbWKATBX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992708AbWKATBX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 14:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752289AbWKATBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 14:01:23 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:30685 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1750838AbWKATBW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 14:01:22 -0500
Date: Wed, 1 Nov 2006 21:57:46 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Oleg Verych <olecom@flower.upol.cz>, Pavel Machek <pavel@ucw.cz>,
       David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>
Subject: Re: [take22 0/4] kevent: Generic event handling mechanism.
Message-ID: <20061101185745.GA12440@2ka.mipt.ru>
References: <1154985aa0591036@2ka.mipt.ru> <1162380963981@2ka.mipt.ru> <20061101130614.GB7195@atrey.karlin.mff.cuni.cz> <20061101132506.GA6433@2ka.mipt.ru> <20061101160551.GA2598@elf.ucw.cz> <20061101162403.GA29783@2ka.mipt.ru> <slrnekhpbr.2j1.olecom@flower.upol.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <slrnekhpbr.2j1.olecom@flower.upol.cz>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Wed, 01 Nov 2006 22:01:28 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2006 at 06:20:43PM +0000, Oleg Verych (olecom@flower.upol.cz) wrote:
> 
> Hallo, Evgeniy Polyakov.

Hello, Oleg.

> On 2006-11-01, you wrote:
> []
> >> Quantifying "how much more scalable" would be nice, as would be some
> >> example where it is useful. ("It makes my webserver twice as fast on
> >> monster 64-cpu box").
> >
> > Trivial kevent web-server can handle 3960+ req/sec on Xeon 2.4Ghz with
> [...]
> 
> Seriously. I'm seeing that patches also. New, shiny, always ready "for
> inclusion". But considering kernel (linux in this case) as not thing
> for itself, i want to ask following question.
> 
> Where's real-life application to do configure && make && make install?

Your real life or mine as developer?
I fortunately do not know anything about your real life, but my real life
applications can be found on project's homepage.
There is a link to archive there, where you can find plenty of sources.
You likely do not know, but it is a bit risky business to patch all
existing applications to show that approach is correct, if
implementation is not completed.
You likely do not know, but after I first time announced kevents in
February I changed interfaces 4 times - and it is just interfaces, not
including numerous features added/removed by developer's requests.

> There were some comments about laking much of such programs, answers were
> "was in prev. e-mail", "need to update them", something like that.
> "Trivial web server" sources url, mentioned in benchmark isn't pointed
> in patch advertisement. If it was, should i actually try that new
> *trivial* wheel?

Answer is trivial - there is archive where one can find a source code
(filenames are posted regulary). Should I create a rpm? For what glibc
version?

> Saying that, i want to give you some short examples, i know.
> *Linux kernel <-> userspace*:
> o Alexey Kuznetsov  networking     <-> (excellent) iproute set of utilities;

iproute documentation was way too bad when Alexey presented it first 
time :)

> o Maxim Krasnyansky tun net driver <-> vtun daemon application;
>
> *Glibc with mister Drepper* has huge set of tests, please search for
> `tst*' files in the sources.

Btw, show me splice() 'shiny' application? Does lighttpd use it?
Or move_pages().

> To make a little hint to you, Evgeniy, why don't you find a little
> animal in the open source zoo to implement little interface to
> proposed kernel subsystem and then show it to The Big Jury (not me),
> we have here? And i can not see, how you've managed to implement
> something like that having almost nothing on the test basket.
> Very *suspicious* ch.

There are always people who do not like something, what can I do with
it? I present the code, we discuss it, I ask for inclusion (since it is
the only way to get feedback), something requires changes, it is changed
and so on - it is development process.
I created 'little animal in the open source zoo' by myself to show how
simple kevents are.

> One, that comes in mind is lighthttpd <http://www.lighttpd.net/>.
> It had sub-interface for event systems like select,poll,epoll, when i
> checked its sources last time. And it is mature, btw.

As I already told several times, I changed only interfaces 4 times
already, since no one seems to know what we really want and how
interface should look like. You suggest to patch lighttpd? Well, it is
doable, but then I will be asked to change apache and nginx. And then
someone will suggest to change order of parameters. Will you help me
rewrite userspace? No, you will not. You asks for something without
providing anything back (not getting into account code, but discussion,
ideas, testing time, nothing), and you do it in ultimate manner.
Btw, kevent also support AIO notifications - do you suggest to patch
reactor/proactor for tests?
It supports network AIO - do you suggest to write support for that into
apache?
What about timers? It is possible to rewrite all POSIX timers users to
usem instead.
There is feature request for userspace events and singal delivery - what
to do with that?

I created trivial web servers, which send single static page and use
various event handling schemes, and I test new subsystem with new tools,
when tests are completed and all requested features are implemented it
is time to work on different more complex users.

So let's at least complete what we have right now, so no developer's
efforts could be wasted writing empty chars in various places.

> Cheers.
> 
> [ -*- OT -*-                                                           ]
> [ I wouldn't write all this, unless saw your opinion about the         ]
> [ reportbug (part of the Debian Bug Tracking System) this week.        ]
> [ While i'm nobody here, imho, the first thing about good programmer   ]
> [ must be, that he is excellent user.                                  ]
> ____

-- 
	Evgeniy Polyakov
