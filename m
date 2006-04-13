Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965018AbWDMXM2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965018AbWDMXM2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 19:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965031AbWDMXMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 19:12:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49822 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965018AbWDMXLo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 19:11:44 -0400
Date: Thu, 13 Apr 2006 16:11:30 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       Dan Bonachea <bonachead@comcast.net>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: pthread-safety bug in write(2) on Linux 2.6.x
In-Reply-To: <Pine.LNX.4.64.0604131603310.3701@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0604131608340.3701@g5.osdl.org>
References: <6.2.5.6.2.20060412173852.033dbb90@cs.berkeley.edu> 
 <20060412214613.404cf49f.akpm@osdl.org> <443DE2BD.1080103@yahoo.com.au> 
 <Pine.LNX.4.64.0604130750240.14565@g5.osdl.org>  <1144965022.12387.23.camel@localhost.localdomain>
  <Pine.LNX.4.64.0604131531440.3701@g5.osdl.org> <1144969549.12387.33.camel@localhost.localdomain>
 <Pine.LNX.4.64.0604131603310.3701@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 13 Apr 2006, Linus Torvalds wrote:

> 
> 
> On Fri, 14 Apr 2006, Alan Cox wrote:
> > 
> > Quality for whom ? There is a measurable cost to all that extra locking
> > which will hurt everyone. Given existing kernels don't make the
> > guarantee and SuS v3 does not make the guarantee the apps that need it
> > will continue to do the extra work themselves anyway.
> 
> True. 

Side note: if you want the strange POSIX guarantees that Dan quoted 
(atomicity between write and fstat), you'd almost have to do it with 
user-space crapola magic locks. Doing it in the kernel would just be 
insane, you'd have to have some per-process "IO semaphore".

(Doing it in user space _also_ sounds insane, but then you could have a 
switch like "POSIX me harder, and do all the really stupid things" at 
compile time or something)

			Linus
