Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312737AbSCZVUM>; Tue, 26 Mar 2002 16:20:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312738AbSCZVUA>; Tue, 26 Mar 2002 16:20:00 -0500
Received: from fungus.teststation.com ([212.32.186.211]:32517 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S312737AbSCZVTf>; Tue, 26 Mar 2002 16:19:35 -0500
Date: Tue, 26 Mar 2002 22:19:32 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: <puw@cola.teststation.com>
To: Ivan Gurdiev <ivangurdiev@yahoo.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Via-Rhine stalls - transmit errors
In-Reply-To: <20020326015223.69972.qmail@web10104.mail.yahoo.com>
Message-ID: <Pine.LNX.4.33.0203262143110.10843-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Mar 2002, Ivan Gurdiev wrote:

> tried that one...it seemed to fix transmit when
> initiated from my desktop computer, but it freezes
> everything when I initiate the transmit in the same
> direction from the laptop. 

Ok, that's bad but still not so bad. It could be a locking problem in the
via driver but that is fixable you just need to find out where it hangs 
and then guess why :)

(sysrq to get stacktraces and run through ksymoops, or kernel debugger or
 some deadlock detection thing, if no one gives you more specific
 directions search for ikd)


> This one won't compile. Lots of errors.
> Entire include files are missing.

You need to follow the instructions on those pages, there are some
additional header files for backwards compatibility. I don't know if it
compiles under 2.4 but I think the idea is that it should.


> I do, the erorrs are correct. However for some of
> those errors you can't even get the "something wicked"
> message the way that the code is written.
> Other errors are handled elsewhere. The whole
> thing is complicated and may cause redundancies 
> and problems. Error handling needs improvement.

I believe the "something wicked" is for an error/uncommon event that isn't
handled and so the known events are filtered out. If you get a IntrTxAbort
by itself then a message isn't printed, but if you get a IntrTxAbort and
IntrTxDone you get some output (000a).

If you look at the via code or the parts I copied from it, then yes errors
are handled both in the error and the tx parts of the interrupt handler.
The reason for that is that some handling is done for error bits set in
the descriptor word and the others are based on the interrupt bits.

Perhaps those aren't the redundancies you mean.


> > There were ideas on changed meaning
> > of an interrupt bit (0x0200) and the "fix" for that 
> > is probably causing
> >this.
> 
> Isn't this your patch?

Yes? I don't understand that question to that statement.

People around me (in a virtual sense) had ideas that the newer datasheets
described a different function for that bit. When fixing that it seems
like the older chips weren't too happy. But the goal of that patch was to
try and fix the "Dragon+" errors so it wasn't tested on older chips.


> Where's IntrRxEarly? IntrRxNoBuf? IntrRxWakeUp?
> IntrTxAborted? .... I added those to my version.

I don't know. Possibly those flags are never set without also setting
another flag, like IntrRxErr, and the driver doesn't want to do anything
special on a "IntrRxNoBuf" error anyway. I see no harm in adding them.

Maybe ask Donald Becker why he didn't when he wrote that code?

/Urban

