Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129574AbRBXTfE>; Sat, 24 Feb 2001 14:35:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129581AbRBXTex>; Sat, 24 Feb 2001 14:34:53 -0500
Received: from [194.213.32.137] ([194.213.32.137]:2564 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S129580AbRBXTeq>;
	Sat, 24 Feb 2001 14:34:46 -0500
Message-ID: <20010223222141.A563@bug.ucw.cz>
Date: Fri, 23 Feb 2001 22:21:41 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Ph. Marek" <marek@mail.bmlv.gv.at>, linux-kernel@vger.kernel.org
Subject: Re: some char * optimizations in kernel
In-Reply-To: <3.0.6.32.20010222123207.009138d0@pop3.bmlv.gv.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <3.0.6.32.20010222123207.009138d0@pop3.bmlv.gv.at>; from Ph. Marek on Thu, Feb 22, 2001 at 12:32:07PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Hello everybody,
> 
> looking through the sources I found several pieces like
> lib/vsprintf.c, line 111:
> 	const char *digits="0123456789abcdefghijklmnopqrstuvwxyz";
> 
> As tested with egcs-2.91.60 even with -O3 there is a difference
> between 
> 	const char *digits="0123456789abcdefghijklmnopqrstuvwxyz";
> and
> 	const char digits[]="0123456789abcdefghijklmnopqrstuvwxyz";
> 
> in the resulting assembler code.
> 
> 
> Usage of this pointer results in it being loaded in a register, and then
> pushed on the stack (for subrouting using); if it's an array, the address
> is pushed directly.
> 
> Furthermore, in the "char *"-case the pointer is stored in memory.

It has to be, no matter of optimalization level. Some other module
might access that variable. You _could_ do static const char *..., but
it would probably not help.

> As I'm not at home I can't give a complete reference of all these cases.
> (But it's trivial [at least for me :-)] using perl).
> 
> So if this changes are approved and I have the time I can post a diff in
> the next few days.
> 
> 
> BTW: For which size of patch is it possible to get included in the "Hall of
> fame" (has helped with linux kernel)?

Try something bigger than this :-).

> And, btw too, where can I find a maintainer of a specific file? eg., one of
> these cases is in init/version.c which has "Copyright (C) 1992  Theodore
> Ts'o" - but I have to guess it's tytso@valinux.com.
> Is there something like Documentation/maintainers?

It is something like MAINTAINERS in root.

-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
