Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262321AbVA0ACW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262321AbVA0ACW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 19:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262519AbVA0ABx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 19:01:53 -0500
Received: from speedy.student.utwente.nl ([130.89.163.131]:65411 "EHLO
	speedy.student.utwente.nl") by vger.kernel.org with ESMTP
	id S262334AbVAZU0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 15:26:54 -0500
Date: Wed, 26 Jan 2005 21:26:38 +0100
From: Sytse Wielinga <s.b.wielinga@student.utwente.nl>
To: John Richard Moser <nigelenki@comcast.net>
Cc: Linus Torvalds <torvalds@osdl.org>, Bill Davidsen <davidsen@tmr.com>,
       Valdis.Kletnieks@vt.edu, Arjan van de Ven <arjan@infradead.org>,
       Ingo Molnar <mingo@elte.hu>, Christoph Hellwig <hch@infradead.org>,
       Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       marcelo.tosatti@cyclades.com, Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
Message-ID: <20050126202637.GH23182@speedy.student.utwente.nl>
Mail-Followup-To: John Richard Moser <nigelenki@comcast.net>,
	Linus Torvalds <torvalds@osdl.org>,
	Bill Davidsen <davidsen@tmr.com>, Valdis.Kletnieks@vt.edu,
	Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>,
	Christoph Hellwig <hch@infradead.org>,
	Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
	marcelo.tosatti@cyclades.com, Greg KH <greg@kroah.com>,
	chrisw@osdl.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <41F6604B.4090905@tmr.com> <Pine.LNX.4.58.0501250741210.2342@ppc970.osdl.org> <41F6816D.1020306@tmr.com> <41F68975.8010405@comcast.net> <Pine.LNX.4.58.0501251025510.2342@ppc970.osdl.org> <41F691D6.8040803@comcast.net> <Pine.LNX.4.58.0501251054400.2342@ppc970.osdl.org> <41F6A5F8.5030100@comcast.net> <20050126160620.GE23182@speedy.student.utwente.nl> <41F7EFF4.40303@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41F7EFF4.40303@comcast.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2005 at 02:31:00PM -0500, John Richard Moser wrote:
> Sytse Wielinga wrote:
> > On Tue, Jan 25, 2005 at 03:03:04PM -0500, John Richard Moser wrote:
> >[...]
> >>true. Very very true.
> >>
> >>With things like Gr, there's like a million features.  Normally the
> >>first step I take is "Disable it all".  If it still breaks, THEN THERE'S
> >>A PROBLEM.  If it works, then the binary searching begins.
> > 
> > 
> > So how do you think you would do a binary search within big patches, if it
> > would take you 10,000 man-hours to split up the patch? Disabling a lot of
> > small patches is easy, disabling a part of a big one takes a lot more work.
> 
> 'make menuconfig' is not a lot more work wtf
> 
> 
> [*] Grsecurity
>   Security Level (Custom)  --->
>   Address Space Protection  --->
>   Role Based Access Control Options  --->
>   Filesystem Protections  --->
>   Kernel Auditing  --->
>   Executable Protections  --->
>   Network Protections  --->
>   Sysctl support  --->
>   Logging Options  --->
> 
> ?? Address Space Protection ??
>  [ ] Deny writing to /dev/kmem, /dev/mem, and /dev/port
>  [ ] Disable privileged I/O
>  [*] Remove addresses from /proc/<pid>/[maps|stat]
>  [*] Deter exploit bruteforcing
>  [*] Hide kernel symbols
> 
> Need I continue?  There's some 30 or 40 more options I could show.  If
> you can't use your enter, left, right, up, y, n, and ? keys, you're
> crippled and won't be able to patch and unpatch crap either.

Granted, in some patches you can disable certain features by turning off config
options. Even though it's much less convenient and you might miss out on some
parts because bugs may be introduced that aren't disabled by any option and
even if you find the option that triggers the bug, you still may have lots of
code to check because the option enables a large piece of code, and will have
to work with the entire patch instead of just a small one, in the case of a
well-written patch it's mostly very inconvenient. It still is a good habit to
split out the work you do into small parts though. 

> >>>Which is why lots of small patches usually have _different_ bug behaviour
> >>>than the patch they fix. To go back to the A+B fix: the bug they fix may
> >>>be fixed only by the _combination_ of the patch, but the bug they cause is
> >>>often an artifact of _one_ of the patches.
> >>>
> >>
> >>Wasn't talking about bugfixes, see above.
> > 
> > 
> > Oh, so you're saying that security fixes don't cause bugs? Great world you live
> > in, then...
> > 
> 
> I didn't say that.  I said I wasn't talking about bugfix patches.  I
> wasn't talking about "mremap(0,0) gives you root," I was talking about
> "preventing following links under X conditions breaks nothing legitimate
> but deadstops /tmp races" or "properly setting CPU protections for
> PROT_EXEC stops code injection" or "ASLR stops ret2libc attacks."
> 
> If you people ever bothered to read what I say, you wouldn't continually
> say stupid shit like <me> You get milk from cows <you> wtf idiot
> chocolate milk doens't come from chocolate cows

I'm sorry about the rant. Besides, your comment ('Wasn't talking about
bugfixes') makes some sense, too. You were actually talking about two patches
though, which close two closely related holes. Linus was talking about the
possible bugs caused by either one of these two patches, which may be totally
unrelated to the thing they try to fix.

    Sytse
