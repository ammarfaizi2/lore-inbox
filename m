Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265138AbSKESCb>; Tue, 5 Nov 2002 13:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265143AbSKESCb>; Tue, 5 Nov 2002 13:02:31 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:3081 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S265138AbSKESC3>; Tue, 5 Nov 2002 13:02:29 -0500
Date: Tue, 5 Nov 2002 13:07:40 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "Matt D. Robinson" <yakker@aparity.com>, Steven King <sxking@qwest.net>,
       Linus Torvalds <torvalds@transmeta.com>,
       Joel Becker <Joel.Becker@oracle.com>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lkcd-general@lists.sourceforge.net, lkcd-devel@lists.sourceforge.net
Subject: Re: [lkcd-general] Re: What's left over.
In-Reply-To: <1036341175.29646.49.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.3.96.1021105121112.17410E-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 Nov 2002, Alan Cox wrote:

> On Sun, 2002-11-03 at 14:33, Bill Davidsen wrote:
> > If you define "unmaintainably bad" as "having features you don't need"
> > then I agree. But since dump to disk is in almost every other commercial
> > UNIX, maybe someone would question why it's good for others but not  for
> > Linux.
> 
> It isnt about features, its about clean maintainable code. netdump to me
> doesnt mean no dump to disk option. In fact I'd rather like to be able
> to insmod dump-foo.o. The correctness issues are hard but if the
> dump-foo is standalone, resets the hardware and has an SHA integrity
> check then it can be done (think of it as a post crash variant of the
> trusted computing TCB verification problem)

I certainly don't disagree, but the one critical problem is writing the
dump to the right place, or at least not writing to the wrong place. I'd
love to have disk, net, NVram, whatever choices, but disk is the one which
would help the most. AIX and ISC have dump to swap, and the swapon copies
the data back or clears it, with a fresh O/S load to ensure writing the
right place.
 
> > uses the crash dump in AIX, the person who wants to send a compressed dump
> > and money to IBM and get back a fix. Netdump assumes external resources
> 
> Lots of interesting legal issues but yes you can do it sometimes (DMCA,
> privacy, financial duties sometimes make it horribly complex). Even in
> the case where you only dump the oops its still valuable.

Agreed, I would think about doing that with a mail server. But even an
oops like ksymoops would be helpful. I started on systems with dumps,
ksymoops is wonderful by comparison.
 
> > and a functional secure network (is the dump encrypted and I missed it?)
> > which home users surely don't have, and remote servers oftem lack as well.
> 
> Encrypting the dump with the new crypto lib in the kernel would be easy,
> right now it doesnt. 
> 
> My disk dump concerns are purely those of correctness. That means
> 
> 1.	After loading the module getting the block list for the dump target

That could all be built as part of init, clearly you can't depend on
demand loading the module.
 
> 2.	Resetting and scratch initializing the dump device

If the modules are to be really self-sufficient it would have to include
the driver. I'll let someone tell me that's not always the case if the
driver can have its own data area.
 
> 3.	Not relying on any code outside of the dump TCB that may have
> been corrupted

Yes, although with separate code, stack and data that's less likely. In
the bad old days self-modifying code was common.
 
> 4.	At dump time turning off all bus masters, doing the dump TCB
> verification and then dumping

The first part of that looks medium hard, particularly if the code has to
be part of the dump module.
 
> Most of the pieces already exist.

Clearly it can be done even better than the current implementation, and
given an interface standard a replacement in the whole could be done.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

