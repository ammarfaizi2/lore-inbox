Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263126AbTETARW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 20:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263152AbTETARW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 20:17:22 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:31507 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263126AbTETART (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 20:17:19 -0400
Message-ID: <3EC9770E.2080409@zytor.com>
Date: Mon, 19 May 2003 17:30:06 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en, sv
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Recent changes to sysctl.h breaks glibc
References: <20030519165623.GA983@mars.ravnborg.org>	<Pine.LNX.4.44.0305191039320.16596-100000@home.transmeta.com>	<babhik$sbd$1@cesium.transmeta.com>	<m1d6ie37i8.fsf@frodo.biederman.org> <3EC95B58.7080807@zytor.com>	<m18yt235cf.fsf@frodo.biederman.org> <3EC9660D.2000203@zytor.com> <m14r3q331h.fsf@frodo.biederman.org>
In-Reply-To: <m14r3q331h.fsf@frodo.biederman.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> "H. Peter Anvin" <hpa@zytor.com> writes:
> 
>>Yes.  And guess what?  Bugs happen.  Sometimes you can't fix them either
>>because the "new" usage has gotten established.  However, that's not the
>>point.
>>
>>Your message assumes that the ABI remains fixed.  This is totally and
>>utterly and undeniably WRONG. 
> 
> It is correct by definition, the existing part of an ABI may not change.
>

"THE ABI" does not consitute "THE EXISTING PART OF AN ABI".  They are
two different things.

>>>But there is no reason not to write documentation today about what the
>>>kernel interfaces are and convert glibc and the kernel later when
>>>it is convenient to their development cycles.  
>>>
>>>What I do not is see the necessity of using automation to follow the
>>>documentation.
>>>
>>Otherwise you have three places to manually make your changes (usually
>>more) -- the documentation, the kernel, and glibc... and really you also
>>have klibc, uclibc, dietlibc, and God knows what else.
> 
> But since the older interface still remains you don't have to change
> klibc, uclibc, dietlibc, and whatever else does not care.  Making
> it easy to change an existing ABI is simply wrong.

No, it's not.  It provides a chance to fix bugs quickly and easily.
Furthermore, it provides a clean, uniform way to distribute ABI
extensions.

> If you were to increment the syscall numbers by one no amount of automation
> in the world would make that a kernel that would be usable on a production
> box.  The only way it could even work is if you were to declare that
> kernel uses a new ABI.

Syscall numbers are an extremely bad example (ioctl structures is more
like it), but since you brought it up: how would you deal with the
hypotetical case that two syscalls were assigned the same number?
You're screwed no matter what, and making it hard to fix doesn't improve
the situation in any way.

>>Automation is the way to maintain these together and in concert, to
>>avoid your "B_ U_ G_ S_."  This isn't just a Good Thing, this is the
>>only sane possibility.
> 
> If things must be maintained in concert it is a bug.  

Things *DO* have to be maintained in concert if you want to get things
done.  I'm not talking atomic changes as I'm talking getting changes in
within a reasonable time frame.

> With a fixed ABI people take advantage of new features as they
> care for them.  And in general to use new features requires new code.
> 
> If people are adding and changing ioctls/sysctls/prctls left and right,
> and that is what is causing the maintenance problem, then that is the
> problem.  And that is where the problem needs to be reigned in at.

And your proposal for this is...?

Let's face it, you're going to need these kinds of things.  You're also
going to need a way to push these features into use.  You're also going
to want to have an automated way to make things like strace (my personal
favourite debugging tool) produce useful output.

>>Does that mean C source code is the only possible format?  It most
>>certainly *doesn't* -- in fact one could argue it's not even a very good
>>format -- as long as C source code is one of the possible productions.
> 
> Agreed.
> 
> Calling it documentation simply makes it clear what the headers are,
> and suggest that the machine readable for does not need to be C source
> code.

What it really is is an ABI specification, not documentation.  The
difference is that the specification *is* the ABI, by definition,
whereas documentation is a *description* of what the ABI is.  The latter
may or may not be up to date and correct.

Automation prevents bugs.  This is a good thing.

	-hpa

