Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932450AbWGHA2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932450AbWGHA2r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 20:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932447AbWGHA2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 20:28:47 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:44249 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932450AbWGHA2p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 20:28:45 -0400
Date: Sat, 8 Jul 2006 02:28:26 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: suspend2-devel@lists.suspend2.net, Olivier Galibert <galibert@pobox.com>,
       grundig <grundig@teleline.es>, Avuton Olrich <avuton@gmail.com>,
       jan@rychter.com, linux-kernel@vger.kernel.org
Subject: uswsusp history lesson [was Re: [Suspend2-devel] Re: swsusp / suspend2 reliability]
Message-ID: <20060708002826.GD1700@elf.ucw.cz>
References: <20060627133321.GB3019@elf.ucw.cz> <20060707215656.GA30353@dspnet.fr.eu.org> <20060707232523.GC1746@elf.ucw.cz> <200607080933.12372.ncunningham@linuxmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607080933.12372.ncunningham@linuxmail.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > So what Pavel wants can be
> > > > translated as 'please use already merged code, it can already do what
> > > > you want without further changing kernel'.
> > >
> > > Like we'd want to use unreviewed, extremely new and risky code for
> > > something that happily destroy filesystems.
> >
> > You can either use suspend2 (14000 lines of unreviewed kernel code,
> > old) or uswsusp (~500 lines of reviewed kernel code, ~2000 lines of
> > unreviewed userspace code, new).
> 
> I was going to keep quiet, but I have to say this: If Suspend2 can rightly be 
> called unreviewed code, it's only because you've been too busy flaming etc to 
> give it serious review. Personally, though, I don't think it's right

I really looked at suspend2 hard, year or so ago, when I was pretty
tired of the flamewars. At that point I decided it is way too big to
be acceptable to mainline, and got that crazy idea about uswsusp, that
surprisingly worked out at the end.

uswsusp makes suspend2 obsolete, and suspend2 now looks
misdesigned. It puts too much stuff into the kernel, you know that
already.

>From your point of view, uswsusp is misdesigned, too. It is too damn
hard to install. There's no way it could survive as a standalone patch
-- the way suspend2 survives. Fortunately, from distro point of view,
being hard to install does not matter that much. Distros already have
their own initrds, etc. And in the long term, distros matter, and I'm
quite confident I can make 90% distributions ship uswsusp + its
userland; cleaner kernel code matters, too, and maybe you'll agree
that if you only look at the kernel parts, uswsusp looks nicer.

Now, you are asking me to review 14000 lines of code. That's quite a
lot of code, and you did not exactly make reviewer's life easy. Also
reviews usually stop at first "fatal" problem, and you still drive
user interface from kernel. (Yes, drawing is done in userland, but
core user interface code is still in kernel). That is "fatal".

(Greg mentioned /proc usage being "fatal", too).

Now... moving user interface into userland, and removing /proc usage
are big tasks, do you agree? And they will mean lot of changes, and
lot of new testing.

Perhaps at this point right solution is to just drop suspend2
codebase, and do it again, this time in userland? Kernel
infrastructure is already there, and even if you wanted to replace
[u]swsusp by suspend2, you have to understand how the old code
works. (Another point you may like is that forking suspend.sf.net code
is relatively easy; so even if we disagree about coding style of the
userland parts, I can't veto it or something. And given that your only
problem is including all the possible features, I probably will not
have reason to stop you or something -- having all the features is
okay in userland).

Now... switching to uswsusp kernel parts will make it slightly harder
to install in the short term (messing with initrd). OTOH there's at
least _chance_ to get to the point where suspend "just works" in
Linux, in the long term...

(Of course, you can just ignore this and keep maintaining out-of-tree
suspend2. We'll also get to the point where it "just works"... it will
just take a little longer.)

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
