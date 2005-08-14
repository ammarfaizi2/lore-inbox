Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932503AbVHNMUB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932503AbVHNMUB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 08:20:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932504AbVHNMUB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 08:20:01 -0400
Received: from zproxy.gmail.com ([64.233.162.206]:4882 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932503AbVHNMUB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 08:20:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JFSlFqANGC013Ju9HT9tHw49IxKm4HObjqVs24Eu+LEPfTSLEF2xzfw7yzZ8G8WNDQG1/x4DHRAb5Q+0oQw8dB43Z3bPFLjnm3HxBdxUht/5+RVI97FthHLF5cmzaaCkhkPfH/YVz4IBKFTad7pcc5nJdju9kIFNG3dkIC+QKF8=
Message-ID: <9a874849050814052035ad2838@mail.gmail.com>
Date: Sun, 14 Aug 2005 14:20:00 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] Convert sigaction to act like other unices
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>,
       rmk@arm.linux.org.uk, gerg@uclinux.org, jdike@karaya.com,
       sammy@sammy.net, lethal@linux-sh.org, wli@holomorphy.com,
       davem@davemloft.net, matthew@wil.cx, geert@linux-m68k.org,
       paulus@samba.org, davej@codemonkey.org.uk, tony.luck@intel.com,
       dev-etrax@axis.com, rpurdie@rpsys.net, spyro@f2s.com,
       Robert Wilkens <robw@optonline.net>,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Chris Wright <chrisw@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20050813212924.GQ22901@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1123900802.5296.88.camel@localhost.localdomain>
	 <20050813123956.GN22901@wotan.suse.de>
	 <1123941614.5296.112.camel@localhost.localdomain>
	 <20050813212924.GQ22901@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/13/05, Andi Kleen <ak@suse.de> wrote:
> On Sat, Aug 13, 2005 at 10:00:14AM -0400, Steven Rostedt wrote:
> > On Sat, 2005-08-13 at 14:39 +0200, Andi Kleen wrote:
> > > On Fri, Aug 12, 2005 at 10:40:02PM -0400, Steven Rostedt wroqte:
> > > > Here's a patch that converts all architectures to behave like other unix
> > > > boxes signal handling.  It's funny that I didn't need to change the m68k
> > > > architecture, since it was the only one that already behaves this way!
> > > > (the m68knommu does not!)
> > >
[snip]
> 
> My general feeling about the change is that it risks breaking programs
> and doesn't seem to have any compelling advantages,
> so unless there is a bug demonstrated I wouldn't apply it.
> 
> -Andi
> 

As I see it, the advantages are that we would  a) match the
documentation (man pages & posix/SUS) which makes things easier for
application writers who won't have to scratch their beards wondering
why Linux doesn't behave like the docs say. And  b) Linux behaviour
would match what most (all?) other Unices do, so there'll be less
hassle/bugs when porting apps from other systems to Linux.   To me,
those look like significant bennefits.
As for the "it may break programs" bit, that of course is a concern,
but one way around that would be to stick it in -mm and let it cook
for a few kernel releases. Say we stick it in -mm with a plan to merge
it into 2.6.16-rc1, that should give it quite a bit of time to
determine if it breaks apps (and if it does, to fix those apps).

Just my 0.02euro.


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
