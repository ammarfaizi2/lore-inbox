Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262364AbSKFJDn>; Wed, 6 Nov 2002 04:03:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262862AbSKFJDn>; Wed, 6 Nov 2002 04:03:43 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:1191 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262364AbSKFJDk>;
	Wed, 6 Nov 2002 04:03:40 -0500
Date: Wed, 6 Nov 2002 14:41:47 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Werner Almesberger <wa@almesberger.net>,
       Jeff Garzik <jgarzik@pobox.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lkcd-general@lists.sourceforge.net, lkcd-devel@lists.sourceforge.net
Subject: Re: [lkcd-devel] Re: What's left over.
Message-ID: <20021106144147.A2432@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <Pine.LNX.4.44.0211052203150.1416-100000@home.transmeta.com> <m1znsndtpn.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <m1znsndtpn.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Wed, Nov 06, 2002 at 12:48:36AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2002 at 12:48:36AM -0700, Eric W. Biederman wrote:
> Linus Torvalds <torvalds@transmeta.com> writes:
> 
> > On 5 Nov 2002, Eric W. Biederman wrote:
> > > 
> > > In replying to another post by Al Viro I managed to think this through.
> > > kexec needs:
> > 
> > Note that kexec doesn't bother me at all, and I might find myself using it 
> > myself.
> 
> Good.  Just before I saw this message I sent you my patch ported to 2.5.46,
> and from the feed back on this one it looks like people would
> appreciate a tweak or two.
>  
> 
> That sounds reasonable to me.  Especially as that lines up a little more
> with what the mcore people want as well.  Until today I hadn't realized
> they were using a spare current to process oopses.  For just booting
> another kernel all of the staging can currently be done by reading the
> new kernel into your process before calling the user-level shutdown code.
> 
> > Right now the kexec() stuff seems to mix up the loading and rebooting, but
> > I didn't take a very deep look, maybe I'm wrong.
> 
> It currently happens all in one step because I had never gotten
> feedback that people wanted it in two steps.   

I'd mentioned it a few times in the context of mcore, but probably 
didn't explain myself clearly enough then. 

> 
> > Note that the two-phase boot means that you can load the new kernel early, 
> > which allows you to later on use it for oops handling (it's a bit late to 
> > try to set up the kernel to be loaded at that time ;)
> 
> Given that it is definitely a good idea to split the patch up into two
> pieces.  And a kernel for oops handling should work once all of other
> problems are resolved.

Yes, this fits the model we need.

> 
> The question is how much of that do we need.
> 
> Thinking out loud, and hopefully answering your question.
> - We need a working stack when the new kernel is jumped to so PIC code
>   can exist at the entry point.
> 
> - An oops processing kernel needs to load at an address other than 1MB,
>   or at the very least it's boot sequence needs to squirrel away the
>   old contents of the kernel text and data segments, which reside at
>   1MB, before it moves down to 1MB.

Yes, that bit of memory save logic exists in the mcore mechanism. These
pages are saved away in compressed form in memory and written out
later after dump.  

Now to avoid these pages from being used by the new kernel until
the dump is safetly written out to disk, mcore patches some of
the initialization code to mark these pages (containing saved
dump) as reserved. 

> O.k.  In the next couple of days I will split the loading, and
> executing phase of my kexec code into parts, and resubmit the code.

Great !

> The we can dig in on what it takes to make kexec run stably.
> 

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India

