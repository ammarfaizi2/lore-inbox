Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbTLHSzn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 13:55:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261788AbTLHSzn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 13:55:43 -0500
Received: from opersys.com ([64.40.108.71]:51215 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261784AbTLHSz1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 13:55:27 -0500
Message-ID: <3FD4C9C8.6040709@opersys.com>
Date: Mon, 08 Dec 2003 13:58:16 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: Linus Torvalds <torvalds@osdl.org>,
       Kendall Bennett <KendallB@scitechsoft.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux GPL and binary module exception clause?
References: <3FCDE5CA.2543.3E4EE6AA@localhost>	 <Pine.LNX.4.58.0312031533530.2055@home.osdl.org>	 <Pine.LNX.4.58.0312031614000.2055@home.osdl.org>	 <3FCED34B.5050309@opersys.com> <1070669311.8421.35.camel@imladris.demon.co.uk>
In-Reply-To: <1070669311.8421.35.camel@imladris.demon.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


David Woodhouse wrote:
> So you have a loadable module made of two sections; a GPL'd wrapper
> layer clearly based on the kernel, and your original driver. The latter
> is clearly an identifiable section of that compound work which is _not_
> derived from Linux and which can reasonably be considered an independent
> and separate work in itself.

I didn't exactly specify how the interfacing would be done because that's
besides the point I'm trying to make (in fact, it's the later part of my
email which was most important). But here's two other ways to do it just
for the sake of discussion:
a) Hard-wired assembly in the driver that calls on the appropriate address
with the proper structure offsets etc. No headers used here.
b) User-space interrupt callbacks. Start app -> mlockall -> open GPL
driver -> use ioctl to pass callback address -> open /dev/mem -> ...
I've skipped a few things, but the essentials are there. Basically, you
get the interrupts in user-space and can access whatever you want through
/dev/mem.

Sure the above isn't as powerful as a properly coded driver for Linux,
but it should work for a few things.

> The GPL and its terms do not apply to that section when you distribute
> it as a separate work.

Right, but my argument has little to do with the GPL. In fact, as I
said before (http://www.embeddedtux.org/pipermail/etux/2003-October/000415.html),
I don't personally think the GPL has all the answers to this issue. Not
just that, but I don't really see myself debating with any kernel developer
what the law says he has the right to do or not do with his code. It just
seems to me that the copyright holder has the upper hand here. What I'm
really looking for is to understand how to apply the GPL to binary-only
modules given the copyright holders' interpretation. So far, I have heard
the following (this is a summary, so please correct me if you think I've
miss-characterized your take on this):

Linus Torvalds: modules API not a GPL barrier, must prove your work is not a
derived work - preexisted Linux. Ex.: NVidia is clearly not a derived work.
Alan Cox: Unclear if Linus can dictate terms for binary-only modules since
he's not the only copyright owner. Talk to your lawyer.
Russell King: Linus isn't the only copyright owner and hence can't change
the terms outright.
Theodore Ts'o: Modules API constitutes license barrier.
David Woodhouse: There's no such barrier and applications tightly packaged
with the kernel (i.e. embedded systems) _may_ be subject to derived work
clauses of the GPL.
etc.

Frankly, I don't know what to make of all this. I wish I could collect the
input of all kernel developers to come up with a table of X owns N% of
kernel copyright and his statement about binary-only modules is best
characterized as A, B, C, or D, or ... where each of these is an already
stated position about such modules. We could then come up with a weighed
percentage of validity for each of A, B, C, ... The exercise may not have
any legal weight, especially since as Linus stated a judge may just give
him more credence than any other kernel developer, but it would at least
tell kernel developers where they all stand on this issue.

As it stands now, however, it seems to me that any kernel developer
attempting to enforce the GPL across the modules API would have quite a
few problems. Mainly because:
1) There is no clear consensus among the copyright holders as to how
the GPL is to be interpreted across the modules API.
2) Established technical practice has been that hardware manufacturers
do indeed ship drivers with different licenses than those of the host
OS.

I had mentioned #2 elsewhere before
(http://www.embeddedtux.org/pipermail/etux/2003-October/000415.html) and
it has been discussed in this thread by other folks in slightly different
words. However, it may be that #1 could end up causing the most damage in
the case where a kernel developer, or a few, try to prosecute a real case
of binary-only module infringement on the GPL.

In sum, I agree with Jonathan Corbet's assessment that it's about time
that kernel developers agree where the axe falls. Not just for outsiders,
but also for themselves.

Cheers,

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 514-812-4145

