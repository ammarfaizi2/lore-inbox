Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261358AbSIZQDD>; Thu, 26 Sep 2002 12:03:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261360AbSIZQDD>; Thu, 26 Sep 2002 12:03:03 -0400
Received: from relay1.pair.com ([209.68.1.20]:34060 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id <S261358AbSIZQDA>;
	Thu, 26 Sep 2002 12:03:00 -0400
X-pair-Authenticated: 24.126.73.164
Message-ID: <3D93331C.86F87359@kegel.com>
Date: Thu, 26 Sep 2002 09:17:32 -0700
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-3custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Kernel call chain search tool?
References: <3D913D58.49D855DB@kegel.com> <1033053348.1269.37.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> On Wed, 2002-09-25 at 05:36, Dan Kegel wrote:
> > <prelude>
> > I have a large multithreaded program that has a habit of using too
> > much memory, and as a safeguard, I want to kill it before it makes
> > the system unstable.  The OOM killer often guesses wrong, and RLIMIT_AS
> > kills too soon because of the address space used up by the many thread
> > stacks.
> > So I'd like an RLIMIT_RSS that just kills the fat process.
> 
> The RSS limit isnt a "kill" limit in Unix. its a residency limit. Its
> preventing the obese process from getting more than a certain amount of
> RAM as opposed to swap

Yeah.  RLIMIT_RSS seemed like something I could hijack for the
purpose, though.  And the code change was really small
( http://marc.theaimsgroup.com/?l=linux-kernel&m=103299570928378 ).

If only the darn program didn't have so many threads, RLIMIT_AS
or the no-overcommit patch would be perfect.  I unfortunately can't 
get rid of the threads, so I'm stuck trying to figure out some way
to kill the right program when the system gets low on memory.

Maybe I should look at giving the OOM killer hints?
- Dan
