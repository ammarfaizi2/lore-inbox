Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261530AbUFJOx3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261530AbUFJOx3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 10:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbUFJOx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 10:53:29 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:61961 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S261530AbUFJOwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 10:52:00 -0400
Message-ID: <40C87934.2060505@techsource.com>
Date: Thu, 10 Jun 2004 11:07:32 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>,
       Al Viro <viro@math.psu.edu>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Finding user/kernel pointer bugs [no html]
References: <1086838266.32059.320.camel@dooby.cs.berkeley.edu> <Pine.LNX.4.58.0406092059030.2050@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0406092059030.2050@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Linus Torvalds wrote:

> What we do NOT want to have is to continue with these "implied rules". 
> That's what caused the bugs in the first place. I really want the user 
> pointers to be _explicit_, because not only does that mean that a stupid 
> tool can figure it out with purely "local" knowledge, but more 
> importantly, it means that a _programmer_ can figure it out with purely 
> local knowledge.


Are user pointers actual pointers?  That's much too tempting to dereference.

If you really want to force user space accesses to follow certain rules, 
make them longs or structs (or at least void *) (depending on 
architecture) so that only the proper user-space-access functions can 
interpret them.

Now, if this "handle" corresponds directly to a user space pointer, 
someone might cast it and dereference it, but that would be easy to 
detect, and such patches would be easy to reject.

Bad idea?

