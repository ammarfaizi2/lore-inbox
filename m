Return-Path: <linux-kernel-owner+w=401wt.eu-S965000AbXADQTK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965000AbXADQTK (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 11:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965014AbXADQTK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 11:19:10 -0500
Received: from mail.tmr.com ([64.65.253.246]:35447 "EHLO gaimboi.tmr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965000AbXADQTI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 11:19:08 -0500
Message-ID: <459D290B.1040703@tmr.com>
Date: Thu, 04 Jan 2007 11:19:23 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061105 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: open(O_DIRECT) on a tmpfs?
References: <459CEA93.4000704@tls.msk.ru> <Pine.LNX.4.64.0701041242530.27899@blonde.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.64.0701041242530.27899@blonde.wat.veritas.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> On Thu, 4 Jan 2007, Michael Tokarev wrote:
>> I wonder why open() with O_DIRECT (for example) bit set is
>> disallowed on a tmpfs (again, for example) filesystem,
>> returning EINVAL.
> 
> Because it would be (a very small amount of) work and bloat to
> support O_DIRECT on tmpfs; because that work didn't seem useful;
> and because the nature of tmpfs (completely in page cache) is at
> odds with the nature of O_DIRECT (completely avoiding page cache),
> so it would seem misleading to support it.
> 
> You have a valid view, that we should not forbid what can easily be
> allowed; and a valid (experimental) use for O_DIRECT on tmpfs; and
> a valid alternative perception, that the nature of tmpfs is already
> direct, so O_DIRECT should be allowed as a no-op upon it.

It does seem odd to require that every application using O_DIRECT would 
have to contain code to make it work with tmpfs, or that the admin would 
have to jump through a hoop and introduce (slight) overhead to bypass 
the problem, when the implementation is mostly to stop disallowing 
something which would currently work if allowed.

> 
> On the other hand, I'm glad that you've found a good workaround,
> using loop, and suspect that it's appropriate that you should have
> to use such a workaround: if the app cares so much that it insists
> on O_DIRECT succeeding (for the ordering and persistence of its
> metadata), would it be right for tmpfs to deceive it?

In many cases the use of O_DIRECT is purely to avoid impact on cache 
used by other applications. An application which writes a large quantity 
of data will have less impact on other applications by using O_DIRECT, 
assuming that the data will not be read from cache due to application 
pattern or the data being much larger than physical memory.
> 
> I'm inclined to stick with the status quo;
> but could be persuaded by a chorus behind you.

This isn't impacting me directly, but I can imagine some applications I 
have written, which currently use O_DIRECT, failing if someone chose the 
put a control file on tmpfs. I may be missing some benefit from 
restricting O_DIRECT, feel free to point it out.
> 
> Hugh
> 
> p.s.  You said "O_DIRECT (for example)" - what other open
> flag do you think tmpfs should support which it does not?


-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
