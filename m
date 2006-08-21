Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030439AbWHUNCM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030439AbWHUNCM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 09:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751872AbWHUNCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 09:02:11 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:57804 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1751165AbWHUNCJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 09:02:09 -0400
Date: Mon, 21 Aug 2006 17:01:21 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Bernd Petrovitsch <bernd@firmix.at>
Cc: Christoph Hellwig <hch@infradead.org>, lkml <linux-kernel@vger.kernel.org>,
       David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>
Subject: Re: [take9 1/2] kevent: Core files.
Message-ID: <20060821130121.GA2602@2ka.mipt.ru>
References: <11555364962921@2ka.mipt.ru> <1155536496588@2ka.mipt.ru> <20060816134550.GA12345@infradead.org> <20060816135642.GD4314@2ka.mipt.ru> <20060818104607.GB20816@infradead.org> <20060818112336.GB11034@2ka.mipt.ru> <20060821105637.GB28759@infradead.org> <20060821111335.GA8608@2ka.mipt.ru> <1156164805.17936.132.camel@tara.firmix.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1156164805.17936.132.camel@tara.firmix.at>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Mon, 21 Aug 2006 17:01:24 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2006 at 02:53:25PM +0200, Bernd Petrovitsch (bernd@firmix.at) wrote:
> On Mon, 2006-08-21 at 15:13 +0400, Evgeniy Polyakov wrote:
> [...]
> > And what is the difference between
> 
> As others already pointed out in this thread:
> 
> These are not seen by the C compiler.
> > #define A 1
> > #define B 2
> > #define C 4
> > and
> 
> These are known by the C compiler and thus usable/viewable in a
> debugger.
> > enum {
> >  A = 1,
> >  B = 2,
> >  C = 4,
> > }
> > ?

:) And I pointed quite a few other issues about enums vs. defines.
According to this one - no one wants to watch enums in debugger.

And, ugh:

(gdb) list
1       enum {
2               A = 1,
3               B = 2,
4       };
5
6       int main()
7       {
8               printf("%x\n", A | B);
9       }
(gdb) bre 8
Breakpoint 1 at 0x4004ac: file ./test.c, line 8.
(gdb) r
Starting program: /tmp/test 

Breakpoint 1, main () at ./test.c:8
8               printf("%x\n", A | B);
(gdb) p A
No symbol "A" in current context.


Actually I completely do not care about define or enums, it is really
silly dispute, I just do not want to rewrite bunch of code _again_ and
then _again_ when someone decide that defines are better.

-- 
	Evgeniy Polyakov
