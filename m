Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262562AbTJAVIy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 17:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262582AbTJAVIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 17:08:54 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:40457 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S262562AbTJAVIK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 17:08:10 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: Who changed /proc/<pid>/ in 2.6.0-test5-bk9?
Date: 1 Oct 2003 20:58:39 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <blff5v$ivt$1@gatekeeper.tmr.com>
References: <16250.38688.152166.875893@gargle.gargle.HOWL> <Pine.LNX.4.44.0310010803530.23860-100000@home.osdl.org>
X-Trace: gatekeeper.tmr.com 1065041919 19453 192.168.12.62 (1 Oct 2003 20:58:39 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.44.0310010803530.23860-100000@home.osdl.org>,
Linus Torvalds  <torvalds@osdl.org> wrote:
| 
| On Wed, 1 Oct 2003, Mikael Pettersson wrote:
| >
| > Linus' 2.6.0-test6 announcement doesn't seem to mention the
| > fact that 2.6.0-test5-bk9 fundamentally changed the semantics
| > of /proc/self and the /proc/<pid> name space.
| 
| Well, that's because the semantics weren't _supposed_ to change. The new 
| semantics were meant to be a superset of the old behaviour, with just the 
| added "task" subdirectory that lists the actual threads.
| 
| However, you're right that "/proc/self" should likely point into the
| _thread_, and not into the task. But it's debatable. You are very likely 
| the only one who could ever care ;)

Well, it's a subtle detail, and it would be well to document such. He
may be the only person to use that, but it's certainly not intuitive,
and if I were to ever do this I'm certainly alerted that it might
violate Plauger's law of least astonishment. I would hope it points to
the thread, but if it doesn't it's not something I use every day ;-)
| 
| > I don't actually disagree with the change, but it took me by
| > surprise since neither the 2.6.0-test6 annoucement nor the
| > diff between the t5-bk8 and t5-bk9 logs seem to mention it.
| 
| Well, the changelog mentions "fix for hidden task problem", since the diff 
| really is mainly to _add_ threads to the /proc layout. The fact that it 
| changed /proc/self is actually a bit surprising. Albert?

When I get this one built I'm going to see which getpid() (and family)
returns as well, I never though of using /proc/self from a thread, but
I do on rare occasions get my pid.
| 
| > (It broke the perfctr driver, but I'm handling that by making
| > an already planned API switch now instead of later.)
| 
| I think /proc/self most likely _should_ point into the thread, not the 
| task. 

Hopefully that was an unintended side effect.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
