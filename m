Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276477AbRKAALy>; Wed, 31 Oct 2001 19:11:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276429AbRKAALf>; Wed, 31 Oct 2001 19:11:35 -0500
Received: from [216.151.155.121] ([216.151.155.121]:10760 "EHLO
	belphigor.mcnaught.org") by vger.kernel.org with ESMTP
	id <S276424AbRKAALY>; Wed, 31 Oct 2001 19:11:24 -0500
To: Riley Williams <rhw@MemAlpha.cx>
Cc: Ville Herva <vherva@niksula.hut.fi>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Need blocking /dev/null
In-Reply-To: <Pine.LNX.4.21.0110312256030.28028-100000@Consulate.UFP.CX>
From: Doug McNaught <doug@wireboard.com>
Date: 31 Oct 2001 19:11:47 -0500
In-Reply-To: Riley Williams's message of "Wed, 31 Oct 2001 23:13:22 +0000 (GMT)"
Message-ID: <m31yjjz6ws.fsf@belphigor.mcnaught.org>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) XEmacs/21.1 (20 Minutes to Nikko)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Riley Williams <rhw@MemAlpha.cx> writes:

> Are you sure?
> 
> > find / -name "wanted-but-lost-download" | eat
> 
> Doesn't work - you're piping the stdin there, not stderr as per my
> example above. AFAIK, there's no way to pipe stderr without also piping
> stdout, hence this sort of solution just doesn't work.

The Bourne shell is more perverse than you realize:

$ exec 3>&1; find / -name "wanted-but-lost-download" 2>&1 1>&3 3>&- | eat

[stolen from "Csh Programming Considered Harmful" by Tom Christiansen]

Horrible, but does work.  ;) 

> > zerofill | head -c 1440k > /tmp/floppy.img
> 
> How does zerofill know when to stop writing zeros out?

Easy, it gets EPIPE on the write (or gets killed by SIGPIPE if it's
stupid). 

> > ssh foo@bar | block
> 
> Which of my examples is this an equivalent to? I don't recognise it.

None; he's referring to the /dev/block example that started the
thread.

I'm still happy to keep /dev/null and /dev/zero.  ;)

-Doug
-- 
Let us cross over the river, and rest under the shade of the trees.
   --T. J. Jackson, 1863
