Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262371AbREUDMs>; Sun, 20 May 2001 23:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262368AbREUDMi>; Sun, 20 May 2001 23:12:38 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:45330 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262365AbREUDMb>; Sun, 20 May 2001 23:12:31 -0400
Date: Sun, 20 May 2001 20:12:04 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Alexander Viro <viro@math.psu.edu>, Russell King <rmk@arm.linux.org.uk>,
        Richard Gooch <rgooch@ras.ucalgary.ca>,
        Matthew Wilcox <matthew@wil.cx>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Andrew Clausen <clausen@gnu.org>, Ben LaHaise <bcrl@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code
In-Reply-To: <Pine.LNX.4.33.0105210135240.1569-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.21.0105202005070.8426-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 21 May 2001, Ingo Molnar wrote:
> 
> On Sun, 20 May 2001, Alexander Viro wrote:
> 
> > Linus, as much as I'd like to agree with you, you are hopeless
> > optimist. 90% of drivers contain code written by stupid gits.
> 
> 90% of drivers contain code written by people who do driver development in
> their spare time, with limited resources, most of the time serving as a
> learning excercise. And they do this freely and for fun. Accusing them of
> being 'stupid gits' is just micharacterising the situation.

I would disagree with both of you.

The problem is not whether people do it with limited resources or time, or
whether they are stupid or not.

The problem is that if you expect to get nice code, you have to have nice
interfaces and infratructure. And ioctl's aren't it.

The reason we _can_ write beautiful filesystems these days is that the VFS
layer _supports_ it. In fact, the VFS layer has tons of infrastructure and
structure that makes it _hard_ to write bad filesystem code (which is not
to say that we don't have ugly code there - but much of it is due to
historically not having had quite the same level of infrastructure).

If we had nice infrastructure to make ioctl's more palatable, we could
probably make do even with the current binary-number interfaces, simply
because people would use the infrastructure without ever even _seeing_ how
lacking the user-level accesses are.

But that absolutely _requires_ that the driver writers should never see
the silly "pass a random number and a random argument type" kind of
interface with no structure or infrastructure in place.

Because right now even _good_ programmers make a mess of the fact that
they get passed a bad interface.

Think of it this way: the user interface to opening a file is
"open()" with pathnames and magic flags. But a filesystem never even
_sees_ that interface, it sees a very nicely structured setup where all
the argument parsing and locking has already been done for it, and the
magic flags don't even exist any more as far as the low-level FS is
concerned. Which is why filesystems _can_ be clean.

In contrast, ioctl's are passed through directly, with no help to make
them clean. 

		Linus

