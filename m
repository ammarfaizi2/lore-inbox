Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266113AbTLIUjY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 15:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266136AbTLIUjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 15:39:24 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:15625 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S266113AbTLIUhc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 15:37:32 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: Linux GPL and binary module exception clause?
Date: 9 Dec 2003 20:26:12 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <br5b54$nbj$1@gatekeeper.tmr.com>
References: <3FCDE5CA.2543.3E4EE6AA@localhost> <3FCED34B.5050309@opersys.com> <1070669311.8421.35.camel@imladris.demon.co.uk> <3FD4C9C8.6040709@opersys.com>
X-Trace: gatekeeper.tmr.com 1071001572 23923 192.168.12.62 (9 Dec 2003 20:26:12 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3FD4C9C8.6040709@opersys.com>,
Karim Yaghmour  <karim@opersys.com> wrote:
| 
| David Woodhouse wrote:
| > So you have a loadable module made of two sections; a GPL'd wrapper
| > layer clearly based on the kernel, and your original driver. The latter
| > is clearly an identifiable section of that compound work which is _not_
| > derived from Linux and which can reasonably be considered an independent
| > and separate work in itself.
| 
| I didn't exactly specify how the interfacing would be done because that's
| besides the point I'm trying to make (in fact, it's the later part of my
| email which was most important). But here's two other ways to do it just
| for the sake of discussion:
| a) Hard-wired assembly in the driver that calls on the appropriate address
| with the proper structure offsets etc. No headers used here.

Well, the addresses and offset specs came from *somewhere*, and I would
love to hear someone argue that they "just seemed like good values," or
that reading the header file and then using absolute numbers isn't
derivative.

| b) User-space interrupt callbacks. Start app -> mlockall -> open GPL
| driver -> use ioctl to pass callback address -> open /dev/mem -> ...
| I've skipped a few things, but the essentials are there. Basically, you
| get the interrupts in user-space and can access whatever you want through
| /dev/mem.
| 
| Sure the above isn't as powerful as a properly coded driver for Linux,
| but it should work for a few things.

And people who would do this so they can violate the spirit of the GPL
without violating the language would sue if someone reverse engineered
their secret code...

| 
| > The GPL and its terms do not apply to that section when you distribute
| > it as a separate work.
| 
| Right, but my argument has little to do with the GPL. In fact, as I
| said before (http://www.embeddedtux.org/pipermail/etux/2003-October/000415.html),
| I don't personally think the GPL has all the answers to this issue. Not
| just that, but I don't really see myself debating with any kernel developer
| what the law says he has the right to do or not do with his code. It just
| seems to me that the copyright holder has the upper hand here. What I'm
| really looking for is to understand how to apply the GPL to binary-only
| modules given the copyright holders' interpretation. So far, I have heard
| the following (this is a summary, so please correct me if you think I've
| miss-characterized your take on this):
| 
| Linus Torvalds: modules API not a GPL barrier, must prove your work is not a
| derived work - preexisted Linux. Ex.: NVidia is clearly not a derived work.
| Alan Cox: Unclear if Linus can dictate terms for binary-only modules since
| he's not the only copyright owner. Talk to your lawyer.
| Russell King: Linus isn't the only copyright owner and hence can't change
| the terms outright.
| Theodore Ts'o: Modules API constitutes license barrier.
| David Woodhouse: There's no such barrier and applications tightly packaged
| with the kernel (i.e. embedded systems) _may_ be subject to derived work
| clauses of the GPL.
| etc.
| 
| Frankly, I don't know what to make of all this. I wish I could collect the
| input of all kernel developers to come up with a table of X owns N% of
| kernel copyright and his statement about binary-only modules is best
| characterized as A, B, C, or D, or ... where each of these is an already
| stated position about such modules. We could then come up with a weighed
| percentage of validity for each of A, B, C, ... The exercise may not have
| any legal weight, especially since as Linus stated a judge may just give
| him more credence than any other kernel developer, but it would at least
| tell kernel developers where they all stand on this issue.
| 
| As it stands now, however, it seems to me that any kernel developer
| attempting to enforce the GPL across the modules API would have quite a
| few problems. Mainly because:
| 1) There is no clear consensus among the copyright holders as to how
| the GPL is to be interpreted across the modules API.
| 2) Established technical practice has been that hardware manufacturers
| do indeed ship drivers with different licenses than those of the host
| OS.
| 
| I had mentioned #2 elsewhere before
| (http://www.embeddedtux.org/pipermail/etux/2003-October/000415.html) and
| it has been discussed in this thread by other folks in slightly different
| words. However, it may be that #1 could end up causing the most damage in
| the case where a kernel developer, or a few, try to prosecute a real case
| of binary-only module infringement on the GPL.
| 
| In sum, I agree with Jonathan Corbet's assessment that it's about time
| that kernel developers agree where the axe falls. Not just for outsiders,
| but also for themselves.

I don't think the opinion of the copyright holders counts a bit, the
text of the license and the opinion of a court count. And based on
asking a total of one lawyer, any Linux user has standing to sue because
(if) the copyright infringement interferes with the user's right to use
the software. I report that opinion without defending it, the lawyer was
unwilling to be named.

| Cheers,
| 
| Karim
| -- 
| Author, Speaker, Developer, Consultant
| Pushing Embedded and Real-Time Linux Systems Beyond the Limits
| http://www.opersys.com || karim@opersys.com || 514-812-4145
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
