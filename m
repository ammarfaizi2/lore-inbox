Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932170AbWAPCnM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbWAPCnM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 21:43:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932176AbWAPCnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 21:43:12 -0500
Received: from main.gmane.org ([80.91.229.2]:21930 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932170AbWAPCnL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 21:43:11 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: Re: [PATCH 2/2] kbuild: fix make -jN with multiple targets with make
 O=...
Date: Mon, 16 Jan 2006 11:42:30 +0900
Message-ID: <dqf16n$4tn$1@sea.gmane.org>
References: <dqev9f$pnc$1@sea.gmane.org> <7627.1137378243@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: s175249.ppp.asahi-net.or.jp
User-Agent: Mail/News 1.5 (X11/20060115)
In-Reply-To: <7627.1137378243@kao2.melbourne.sgi.com>
X-Enigmail-Version: 0.94.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> Kalin KOZHUHAROV (on Mon, 16 Jan 2006 11:09:51 +0900) wrote:
>> Sam Ravnborg wrote:
>>> [It is pushed out at:
>>> git://git.kernel.org/pub/scm/linux/kernel/git/sam/kbuild.git]
>>>
>>> The way multiple targets was handled with make O=...
>>> broke because for each high-level target make spawned
>>> a parallel make resulting in a broken build.
>>> Reported by Keith Owens <kaos@ocs.com.au>
>> When did it break? Are any of the released (not -git) kernels affected?
> 
> 2.6.15 has the problem.  It only triggers with the combination of a
> separate object directory _and_ multiple targets on the make command
> line _and_ running make in parallel (make -j).

Thanks for the clarification!

I am safe as I don't usually use multiple targets, but I always compile with
KBUILD_OUTPUT set and make -j5 (and distcc).

However, some of the out-of-tree modules might break, will stay on alert.
A quick check through the relevant to my hardware ebuilds (/me on Gentoo)
showed no show stoppers, they all do:

for T in $TARGETS; do make $T; done

(MAKEOPTS=-jN is handled internally on Gentoo if configured; and I use
/var/kernels/out to compile my kernels)

Please get that patch into 2.6.15.2 if possible (seems many people have ppp
problems, so I guess that will be released soon).

Kalin.

-- 
|[ ~~~~~~~~~~~~~~~~~~~~~~ ]|
+-> http://ThinRope.net/ <-+
|[ ______________________ ]|

