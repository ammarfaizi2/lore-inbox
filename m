Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261644AbUCCSMV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 13:12:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262540AbUCCSMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 13:12:21 -0500
Received: from [217.153.196.35] ([217.153.196.35]:23056 "EHLO
	prin.lo2.opole.pl") by vger.kernel.org with ESMTP id S261644AbUCCSMT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 13:12:19 -0500
From: Mariusz Mazur <mmazur@kernel.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] linux-libc-headers 2.6.3.0
Date: Wed, 3 Mar 2004 19:08:41 +0100
User-Agent: KMail/1.6.1
References: <200402291942.45392.mmazur@kernel.pl> <40434BD7.9060301@nortelnetworks.com> <m37jy4cuaw.fsf@defiant.pm.waw.pl>
In-Reply-To: <m37jy4cuaw.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200403031829.41394.mmazur@kernel.pl>
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 01 of March 2004 19:10, Krzysztof Halasa wrote:
> Not sure about it being "official".
> It may make sense if it's a distribution - many users don't install
> kernel sources. Still, from a technical point of view, it should be
> a straight copy of kernel includes - we don't want to maintain two
> separate sets, do we?

We do. Abi changes are rather rare so keeping them as a separate tree wouldn't 
add too much work for subsystem maintainers, and it would be a Good Thing 
(tm) to have one place where the whole current abi can be seen. One thing to 
note is that linux headers duplicate many structures and definitions that 
should be (and are) provided by glibc. This causes collisions. My current 
practice is to clear offending linux headers of their content, and simply 
include appropriate libc headers (with a nice warning) from them.
I can say that about 60-80% of current linux headers do not have proper 
separation of kernel only code (counting in headers that are kernel only, but 
have no visible signs of that fact) and adding that separation would take a 
while. And even if successfull, it would add significant maintainer burden to 
keep the whole thing working (it would probably look like crap too). 
And we have to remember 2.4 compatibilities (which linux-libc-headers have) - 
is 2.6 kernel a place for them?
(keep in mind I know squat about kernel development, so don't rely on my 
opinions too much)

My current objective is to remove *all* remaining kernel code from 
linux-libc-headers and add as much 2.4 compatibilities as possible. And this 
will take a loooong time since the majority of headers are kernel only, but 
are not marked as such, or are marked as such on one arch only (ppc guys 
rock :), and assumption that removal of those headers from other archs is 
safe is... well... just an assumption.

And as to leaving this as a separate project, or trying to push it into the 
kernel - well, I see pros and cons of both options (and it's not my 
decision :).


-- 
In the year eighty five ten
God is gonna shake his mighty head
He'll either say,
"I'm pleased where man has been"
Or tear it down, and start again
