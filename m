Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261610AbVDJV1R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbVDJV1R (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 17:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261611AbVDJV1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 17:27:17 -0400
Received: from w241.dkm.cz ([62.24.88.241]:10462 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261610AbVDJV1L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 17:27:11 -0400
Date: Sun, 10 Apr 2005 23:27:06 +0200
From: Petr Baudis <pasky@ucw.cz>
To: Willy Tarreau <willy@w.ods.org>
Cc: Ingo Molnar <mingo@elte.hu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>
Subject: Re: Re: Re: [ANNOUNCE] git-pasky-0.1
Message-ID: <20050410212706.GB5902@pasky.ji.cz>
References: <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org> <20050410024157.GE3451@pasky.ji.cz> <20050410162723.GC26537@pasky.ji.cz> <20050410173349.GA17549@elte.hu> <20050410174221.GD7858@alpha.home.local> <20050410174512.GA18768@elte.hu> <20050410184522.GA5902@pasky.ji.cz> <20050410191319.GE7858@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050410191319.GE7858@alpha.home.local>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Sun, Apr 10, 2005 at 09:13:19PM CEST, I got a letter
where Willy Tarreau <willy@w.ods.org> told me that...
> On Sun, Apr 10, 2005 at 08:45:22PM +0200, Petr Baudis wrote:
>  
> > It turns out to be the forks for doing all the cuts and such what is
> > bogging it down so awfully (doing diff-tree takes 0.48s ;-). I do about
> > 15 forks per change, I guess, and for some reason cut takes a long of
> > time on its own.
> > 
> > I've rewritten the cuts with the use of bash arrays and other smart
> > stuff. I somehow don't feel comfortable using this and prefer the
> > old-fashioned ways, but it would be plain unusable without this.
> 
> I've encountered the same problem in a config-generation script a while
> ago. Fortunately, bash provides enough ways to remove most of the forks,
> but the result is less portable.
> 
> I've downloaded your code, but it does not compile here because of the
> tv_nsec fields in struct stat (2.4, glibc 2.2), so I cannot use it to
> get the most up to date version to take a look at the script. Basically,

Ok, I decided to stop this nsec madness (since it broke show-diff
anyway at least on my ext3), and you get it only if you pass -DNSEC
to CFLAGS now. Hope this fixes things for you. :-)

BTW, I regularly update the public copy as accessible on the web.

> all the 'cut' and 'sed' can be removed, as well as the 'dirname'. You
> can also call mkdir only if the dirs don't exist. I really think you
> should end up with only one fork in the loop to call 'diff'.

You still need to extract the file by cat-file too. ;-) And rm the files
after it compares them (so that we don't fill /tmp with crap like
certain awful programs like to do). But I will conditionalize the mkdir
calls, thanks for the suggestion - I think that's the last bit to be
squeezed from this loop (I'll yet check on the read proposal - I
considered it before and turned down for some reason, can't remember why
anymore, though).

Thanks,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
98% of the time I am right. Why worry about the other 3%.
