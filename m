Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264522AbUEJFki@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264522AbUEJFki (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 01:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264527AbUEJFki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 01:40:38 -0400
Received: from colin2.muc.de ([193.149.48.15]:8970 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S264522AbUEJFkd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 01:40:33 -0400
Date: 10 May 2004 07:40:32 +0200
Date: Mon, 10 May 2004 07:40:32 +0200
From: Andi Kleen <ak@muc.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andi Kleen <ak@muc.de>, Andy Lutomirski <luto@myrealbox.com>,
       "R. J. Wysocki" <rjwysocki@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.6-rc3-mm2
Message-ID: <20040510054032.GA68320@colin2.muc.de>
References: <fa.gcf87gs.1sjkoj6@ifi.uio.no> <fa.freqmjk.11j6bhe@ifi.uio.no> <409D3507.2030203@myrealbox.com> <20040509133231.GA25195@colin2.muc.de> <1084141013.28220.8.camel@bach>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1084141013.28220.8.camel@bach>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2004 at 08:16:53AM +1000, Rusty Russell wrote:
> On Sun, 2004-05-09 at 23:32, Andi Kleen wrote:
> > It is all the fault of Move-saved_command_line-to-init-mainc.patch
> > which unfortunately has been in -mm* for some time.
> > 
> > It simply breaks all boot arguments on x86-64.
> 
> How about debugging a known problem instead of whining how your arch was
> broken by a simple change required to consolidate early parameter
> parsing sanely?

I did that, found that your patch causes the breakage, reverted it 
and it worked again. Sorry I don't have time right now to hunt
for bugs in your patches.

Frankly such cleanups are more something for 2.7 anyways, they seem
to be misplaced currently when we're all else trying to stabilize 2.6.
After all it does not fix any bugs, just adds new ones.
 
> I suspect that the problem is caused by x86_64 not saving the
> commandline correctly, and this change has merely made the bug worse.

I am not aware of any x86-64 command line problems without your
patches.
> 
> You copy the command line to saved_command_line twice: once in head64.c
> and once in setup.c.  Why?  In head64.c you don't terminate it, in
> setup.c you do.  Which is right?  There are printks of

It should be already terminated, the additional termination in 
setup.c was probably just paranoia (It was inherited from i386)

The second copy could be probably dropped, but I am not touching
this code with a bargepole right now.

> I don't have an x86_64 box, and I ask *again* if someone who does can
> take a look at the problem...

I would propose you defer these patches to 2.7 and then we try again.
Hopefully there will be more time then to hunt issues in all kinds
of cleanup patches.

-Andi
