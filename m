Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289058AbSBXB3d>; Sat, 23 Feb 2002 20:29:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289084AbSBXB3Y>; Sat, 23 Feb 2002 20:29:24 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:39428 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S289058AbSBXB3I>; Sat, 23 Feb 2002 20:29:08 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sat, 23 Feb 2002 17:31:33 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Bill Huey <billh@gnuppy.monkey.org>
cc: Pete Zaitcev <zaitcev@redhat.com>, Keith Owens <kaos@ocs.com.au>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] [PATCH] C exceptions in kernel
In-Reply-To: <20020223235051.GA2412@gnuppy.monkey.org>
Message-ID: <Pine.LNX.4.44.0202231708080.1035-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Feb 2002, Bill Huey wrote:

> On Sat, Feb 23, 2002 at 07:50:02AM -0500, Pete Zaitcev wrote:
> > Personally, I have no problem handling current practices.
> > But I may see the point of the guy with the try/catch patch.
> > Do not make me to defend him though. I am trying to learn
> > is those exceptions are actually helpful. BTW, we all know
> > where they come from (all of Cutler's NT is written that way),
> > but let it not cloud our judgement.
>
> Uh, that's probably not right. If I've been told/remember correctly,
> it's a technique that certain old school mainframe OSes use to
> implement sophisticate fault recovery of various sorts. As you know,
> one basically rewinds to the original point before the block is
> called so that you can recover/continue from it.

You can't do that w/out an integrated resource allocation/deallocation
system. This because real code ends up by allocating resources ( or doing
whatever operation that needs an undo ) during its path and if you do not
have an automatic resource deallocation you're going to leak resources
more than Harleys engine oil. So w/out such system you've to catch
exceptions at every level where you actually own resources with the code
that is likely->surely to be way worse than the kernel gotos. Where you're
going to save is in cases where your code does not allocate any resource (
book's code ) and here you save the cost of multiple unwinding 'return's
against a single catch link. So, in case that an exception happen ( very
low probability compared to the common path ) and in case your code
underneath the catch point does not own resources, you're going to have a
'little' advantage. What is the cost ? You're going to push onto the
common path the exception code by slowing down the CPU's fast path.




- Davide



