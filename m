Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265233AbRF0D6p>; Tue, 26 Jun 2001 23:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265237AbRF0D6f>; Tue, 26 Jun 2001 23:58:35 -0400
Received: from adsl-63-198-73-118.dsl.lsan03.pacbell.net ([63.198.73.118]:26351
	"HELO hellman.xman.org") by vger.kernel.org with SMTP
	id <S265233AbRF0D6W>; Tue, 26 Jun 2001 23:58:22 -0400
Date: Tue, 26 Jun 2001 20:56:27 -0700
From: Christopher Smith <x@xman.org>
To: Dan Kegel <dank@kegel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: A signal fairy tale
Message-ID: <33240000.993614187@hellman>
In-Reply-To: <3B38860D.8E07353D@kegel.com>
X-Mailer: Mulberry/2.0.8 (Linux/x86 Demo)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Tuesday, June 26, 2001 05:54:37 -0700 Dan Kegel <dank@kegel.com> wrote:
> Once upon a time a hacker named Xman
> wrote a library that used aio, and decided
> to use sigtimedwait() to pick up completion
> notifications.  It worked well, and his I/O
> was blazing fast (since was using a copy
> of Linux that was patched to have good aio).
> But when he tried to integrate his library
> into a large application someone else had
> written, woe! that application's use of signals
> conflicted with his library.  "Fsck!" said Xman.
> At that moment a fairy appeared, and said
> "Young man, watch your language, or I'm going to
> have to turn you into a goon!  I'm the good fairy Eunice.
> Can I help you?"  Xman explained his problem to Eunice,
> who smiled and said "All you need is right here,
> just type 'man 2 sigopen'".  Xman did, and saw:

I must thank the god fair Eunice. ;-) From a programming standpoint, this 
looks like a really nice approach. I must say I prefer this approach to the 
various "event" strategies I've seen to date, as it fixes the primary 
problem with signals, while still allowing us to hook in to all the 
standard POSIX API's that already use signals. It'd be nice if I could pass 
in a 0 for signum and have the kernel select from unused signals (problem 
being that "unused" is not necessarily easy to define), althouh I guess an 
inefficient version of this could be handled in userland.

I presume the fd could be shared between threads and otherwise behave like 
a normal fd, which would be sooooper nice.

I guess the main thing I'm thinking is this could require some significant 
changes to the way the kernel behaves. Still, it's worth taking a "try it 
and see approach". If anyone else thinks this is a good idea I may hack 
together a sample patch and give it a whirl.

Thanks again good fairy Dan/Eunice. ;-)

--Chris

