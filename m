Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280691AbRKGMfl>; Wed, 7 Nov 2001 07:35:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280697AbRKGMfb>; Wed, 7 Nov 2001 07:35:31 -0500
Received: from mta.sara.nl ([145.100.16.144]:30639 "EHLO mta.sara.nl")
	by vger.kernel.org with ESMTP id <S280691AbRKGMfV>;
	Wed, 7 Nov 2001 07:35:21 -0500
Message-Id: <200111071235.NAA24809@zhadum.sara.nl>
X-Mailer: exmh version 2.1.1 10/15/1999
From: Remco Post <r.post@sara.nl>
To: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: PROPOSAL: /proc standards (was dot-proc interface [was: /proc 
In-Reply-To: Message from Ricky Beam <jfbeam@bluetopia.net> 
   of "Tue, 06 Nov 2001 16:43:30 EST." <Pine.GSO.4.33.0111061611080.17287-100000@sweetums.bluetronic.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 07 Nov 2001 13:35:14 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, 6 Nov 2001, Roy Sigurd Karlsbakk wrote:
> >What about adding a separate choice in the kernel config to allow for
> >/hproc (or something) human readable /proc file system?
> 
> Just think about it for a minute.
> 
> There are three ways to address "/proc":
>  - 100% binary interface
>   * human interaction doesn't belong in the kernel - period.
>  - optimally formated text
>   * not designed for humans, but in human format ("text")
>  - human readable
>   * thus the entire OS is reduced to "cat" and "echo"
> 
> Providing more than one interface/format means code duplication.  It doesn't
> matter how much is actually compiled.  Someone has to write it.  Others have
> to maintain it.  Suddenly a change in one place becomes a change in dozens
> of places.
> 
> Personally, I vote for a 100% binary interface. (no surprise there.)  It
> makes things in kernel land so much cleaner, faster, and smaller.  Yes,
> it increases the demands on userland to some degree.  However, printf/scanf
> is one hell of a lot more wasteful than a simple mov.
> 
> For my worst case scenerio, answer this:
>   How do you tell how many processors are in a Linux box?
> 
> The kernel already knows this, but it isn't exposed to userland.  So, one
> must resort to ass-backward, stupid shit like counting entries in
> /proc/cpuinfo.  And to make things even worse, the format is different for
> every arch! (I've been bitching about this for four (4) years.)
> 
> And for those misguided people who think processing text is faster than
> binary, you're idiots.  The values start out as binary, get converted to
> text, copied to the user, and then converted back to binary.  How the hell
> is that faster than copying the original binary value? (Answer: it isn't.)
> 
> And those who *will* complain that binary structures are hard to work with,
> (you're idiots too :-)) a struct is far easier to deal with than text
> processing, esp. for anyone who knows what they are doing.  Yes, changes
> to the struct do tend to break applications, but the same thing happens
> to text based inputs as well.  Perhaps some of you will remember the stink
> that arose when the layout of /proc/meminfo changed (and broke, basically,
> everything.)
> 
> --Ricky
> 

Hi,

the nice thing about text interface as opposed to a struct is that the userland can parse a "CPU_FAMILY=6" as good as 0x6, but if you decide to change the format of the /proc entry, with a binary interface, this means you MUST update the userland as well, while with a text interface and some trivial error processing, adding a field would in the worst case mean that the userland app will not profit from the new info, but it will NOT BREAK.

I do realize this means that the userland apps have to be carefully designed and implemented, but at least, a kernel upgrade wouldn't imply an upgrade of half the OS tools. Once programmers start to realize that error processing is a must anyway, this is a trivial step (and no, "Your proc is broken, go fix it" messages are not error processing ;).

-- 
Met vriendelijke groeten,

Remco Post

SARA - Stichting Academisch Rekencentrum Amsterdam
High Performance Computing  Tel. +31 20 592 8008    Fax. +31 20 668 3167

"I really didn't foresee the Internet. But then, neither did the computer
industry. Not that that tells us very much of course - the computer industry
didn't even foresee that the century was going to end." -- Douglas Adams


