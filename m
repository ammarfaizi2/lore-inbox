Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262549AbUCCTUv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 14:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262550AbUCCTUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 14:20:50 -0500
Received: from [80.72.36.106] ([80.72.36.106]:12731 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S262549AbUCCTUq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 14:20:46 -0500
Date: Wed, 3 Mar 2004 20:20:37 +0100 (CET)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Mariusz Mazur <mmazur@kernel.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] linux-libc-headers 2.6.3.0
In-Reply-To: <200403031829.41394.mmazur@kernel.pl>
Message-ID: <Pine.LNX.4.58.0403032003280.1319@alpha.polcom.net>
References: <200402291942.45392.mmazur@kernel.pl> <40434BD7.9060301@nortelnetworks.com>
 <m37jy4cuaw.fsf@defiant.pm.waw.pl> <200403031829.41394.mmazur@kernel.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Mar 2004, Mariusz Mazur wrote:

> On Monday 01 of March 2004 19:10, Krzysztof Halasa wrote:
> > Not sure about it being "official".
> > It may make sense if it's a distribution - many users don't install
> > kernel sources. Still, from a technical point of view, it should be
> > a straight copy of kernel includes - we don't want to maintain two
> > separate sets, do we?
> 
> We do. Abi changes are rather rare so keeping them as a separate tree wouldn't 
> add too much work for subsystem maintainers, and it would be a Good Thing 
> (tm) to have one place where the whole current abi can be seen. One thing to 
> note is that linux headers duplicate many structures and definitions that 
> should be (and are) provided by glibc. This causes collisions. My current 
> practice is to clear offending linux headers of their content, and simply 
> include appropriate libc headers (with a nice warning) from them.
> I can say that about 60-80% of current linux headers do not have proper 
> separation of kernel only code (counting in headers that are kernel only, but 
> have no visible signs of that fact) and adding that separation would take a 
> while. And even if successfull, it would add significant maintainer burden to 
> keep the whole thing working (it would probably look like crap too). 
> And we have to remember 2.4 compatibilities (which linux-libc-headers have) - 
> is 2.6 kernel a place for them?
> (keep in mind I know squat about kernel development, so don't rely on my 
> opinions too much)
> 
> My current objective is to remove *all* remaining kernel code from 
> linux-libc-headers and add as much 2.4 compatibilities as possible. And this 
> will take a loooong time since the majority of headers are kernel only, but 
> are not marked as such, or are marked as such on one arch only (ppc guys 
> rock :), and assumption that removal of those headers from other archs is 
> safe is... well... just an assumption.
> 
> And as to leaving this as a separate project, or trying to push it into the 
> kernel - well, I see pros and cons of both options (and it's not my 
> decision :).

Then maybe we need 3 types of includes (each in separate directory I 
think):
1. kernel only - cannot be seen from user space, for current kernel, no 
comatibility
2. user only - cannot be seen from kernel (mainly for compatibility), will 
not change very often
3. shared - really portions of includes with definitions that are shared 
between current kernel headers and user headers, are included by both 1. 
and 2. internally (= both kernel and user space does not include them 
directly), extra care should be taken when changing it

This way there are no _KERNEL_ ifdefs needed any more and there is no code 
or data duplications (= no inconsistencies between 1. and 2.).

And if some definitions in kernel 6.6.6 will be obsolete but should be 
kept for compatibility with user space then it will be moved from 3. to 2. 
and apropriate #include commands will be removed from 1. (and from 2. 
too).

What do You think about this? (I know I am completly wrong :))


Grzegorz Kulewski
