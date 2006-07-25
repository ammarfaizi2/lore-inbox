Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751468AbWGYS2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751468AbWGYS2R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 14:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbWGYS2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 14:28:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32917 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751468AbWGYS2P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 14:28:15 -0400
Date: Tue, 25 Jul 2006 11:27:31 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andi Kleen <ak@suse.de>, Ingo Molnar <mingo@elte.hu>,
       Albert Cahalan <acahalan@gmail.com>, arjan@infradead.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, Roland McGrath <roland@redhat.com>
Subject: Re: utrace vs. ptrace
In-Reply-To: <1153853342.4725.21.camel@localhost>
Message-ID: <Pine.LNX.4.64.0607251124080.29649@g5.osdl.org>
References: <787b0d920607122243g24f5a003p1f004c9a1779f75c@mail.gmail.com> 
 <200607131437.28727.ak@suse.de> <20060713124316.GA18852@elte.hu> 
 <200607131521.52505.ak@suse.de>  <Pine.LNX.4.64.0607131203450.5623@g5.osdl.org>
 <1153853342.4725.21.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 25 Jul 2006, Alan Cox wrote:
>
> On Iau, 2006-07-13 at 12:05 -0700, Linus Torvalds wrote:
> > Doing core-dumping in user space would be insane. It doesn't give _any_ 
> > advantages, only disadvantages.
> 
> It has a number of very real advantages in certain circumstances and the
> only interface the kernel needs to provide is the debugger interface and
> something to "kick" the debugger and reparent to it, or for that matter
> it might even be viable just to pass the helper the fd of an anonymous
> file holding the dump.

What you're talking about is not core-dumping, it's just an extended 
debugging interface. And it eeds to be _damn_ careful, exactly because it 
tends to be something very security-sensitive.

> Taking out the kernel core dump support would be insane.

Indeed.

> We get customers who like to collect/process/do clever stuff with core
> dumps and failure cases. We also get people who want to dump a core that
> excludes the 14GB shared mmap of the database file as another example
> where it helps.

"ptrace" certainly isn't wondeful.

What you often want is not a core-dump at all, but a "stop the process" 
thing. It's really irritating that the core-dump is generated and the 
process is gone, when it would often be a lot nicer if instead of 
core-dumping, the process was just stopped and then you could attach to it 
with gdb, and get the whole damn information (including things like access 
to open file descriptors etc).

But again, that has nothing to do with core-dumping. 

			Linus
