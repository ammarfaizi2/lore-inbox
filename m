Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261884AbUCDO3M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 09:29:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261889AbUCDO3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 09:29:12 -0500
Received: from hq.pm.waw.pl ([195.116.170.10]:30095 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S261884AbUCDO3J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 09:29:09 -0500
To: Mariusz Mazur <mmazur@kernel.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] linux-libc-headers 2.6.3.0
References: <200402291942.45392.mmazur@kernel.pl>
	<40434BD7.9060301@nortelnetworks.com>
	<m37jy4cuaw.fsf@defiant.pm.waw.pl>
	<200403031829.41394.mmazur@kernel.pl>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Thu, 04 Mar 2004 15:13:20 +0100
In-Reply-To: <200403031829.41394.mmazur@kernel.pl> (Mariusz Mazur's message
 of "Wed, 3 Mar 2004 19:08:41 +0100")
Message-ID: <m3brnc8zun.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mariusz Mazur <mmazur@kernel.pl> writes:

> We do. Abi changes are rather rare so keeping them as a separate tree
> wouldn't 
> add too much work for subsystem maintainers, and it would be a Good Thing 
> (tm) to have one place where the whole current abi can be seen.

Sure. One place, yes. But separate header sets are IMHO too much crazy.

> One thing to 
> note is that linux headers duplicate many structures and definitions that 
> should be (and are) provided by glibc. This causes collisions. My current 
> practice is to clear offending linux headers of their content, and simply 
> include appropriate libc headers (with a nice warning) from them.

Is it the kernel which is based on glibc, or is it glibc (and the rest of
the userland as glibc isn't that special) using the kernel interface?

The kernel doesn't need glibc at all, I don't know why do you want it
to require some external headers to compile.
Should the kernel behave differently when compiled with different glibc
header sets? :-)

IMHO all the defines should be in the kernel tree. Glibc can and should
use them, as it uses the ABI.

> I can say that about 60-80% of current linux headers do not have proper 
> separation of kernel only code (counting in headers that are kernel only,
> but 
> have no visible signs of that fact)

No doubt.

> and adding that separation would take a 
> while. And even if successfull, it would add significant maintainer burden
> to 
> keep the whole thing working (it would probably look like crap too).

Don't think so. Anyway, there is no other acceptable option. The kernel
must compile without glibc headers (without any external headers, to
be precise) - as it doesn't need any external software to work.

The open question (of much less importance) is if we want to keep
the existing include/ layout or to move public parts to include/linux-abi
etc. It still has to reside in the kernel tree, though. I'd go with the
former for now as it requires less work. OTOH the latter might be
cleaner.

> And we have to remember 2.4 compatibilities (which linux-libc-headers
> have) - 
> is 2.6 kernel a place for them?

Examples?
If they are part of kernel API/ABI, then of course they are still used
by 2.6 kernel and they need to be there. If they aren't used by the
kernel (old #define names for instance) they should go to glibc headers
(#ifndef xxx #define xxx etc.).
-- 
Krzysztof Halasa, B*FH
