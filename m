Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268197AbUHFS0y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268197AbUHFS0y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 14:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268196AbUHFS0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 14:26:54 -0400
Received: from mail4.bluewin.ch ([195.186.4.74]:20969 "EHLO mail4.bluewin.ch")
	by vger.kernel.org with ESMTP id S268197AbUHFSWV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 14:22:21 -0400
Date: Fri, 6 Aug 2004 20:21:31 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Albert Cahalan <albert@users.sf.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org, wli@holomorphy.com
Subject: Re: [proc.txt] Fix /proc/pid/statm documentation
Message-ID: <20040806182131.GA2611@k3.hellgate.ch>
Mail-Followup-To: Albert Cahalan <albert@users.sf.net>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>,
	linux-mm@kvack.org, wli@holomorphy.com
References: <1091754711.1231.2388.camel@cube> <20040806094037.GB11358@k3.hellgate.ch> <1091797122.1231.2452.camel@cube> <20040806163428.GA31285@k3.hellgate.ch> <1091803883.1231.2502.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091803883.1231.2502.camel@cube>
X-Operating-System: Linux 2.6.8-rc3 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Aug 2004 10:51:24 -0400, Albert Cahalan wrote:
> Everybody else can parse ps output.

Not everybody wants to. And ps doesn't provide all the process
information I can get via proc anyway.

> > Some users may prefer written documentation over reading the kernel
> > source. In addition, in the case of statm, there is nothing to document
> > the expected behavior in the source, either. Which is precisely why
> > statm has been utterly broken forever.
> 
> A correct proc.txt would not have avoided this.

It would have helped some of us confirming our suspicions.

> The source code needs a few comments.

Works for me. I'm looking forward to see that fixed.

> > It was not dumb. Some people actually prefer human-readable output when
> > working with proc.
> 
> These people shouldn't be working in /proc. It's easier and

Let me be the one to decide when I use a proc file.

> more portable to use "ps" for their scripts. You can select
> which fields you want, get a header if you like, have the
> processes filtered for you, and so on. Look:
> 
> ps -U root -u root -o pid= -o ppid= -o args
> 
> What's not to like about that? It's portable even.

I wouldn't like ps to be the gatekeeper to proc information. Plus
there's non-portable information in proc that I care about.

> > > On AIX:  ps -eo trs
> > > On BSD:  ps axo trss
> > 
> > I trust they take that information from /proc/pid/statm, too?
> 
> The point is that the name "trs" has a specific meaning.
> The statm file was created to support ps. It wouldn't exist
> if ps didn't need to display a TRS column. So the proper
> behavior of ps is what defines the meaning. Run these two

Fair enough. I think proc.txt should note this relation between
statm and ps.

> > > >> + dt       number of dirty pages   (always 0 on 2.6)
> > > >>
> > > >> This one would be useful.
> > > >
> > > > Agreed. It would be nice to have it somewhere else.
> > > 
> > > No, it's not nice to go moving things around. How about you go
> > 
> > This field is 0 on 2.6. Zero. Always. I am suggesting to have the
> > information available somewhere. That sure ought to count as an
> > improvement.
> 
> Sure. That "somewhere" should be where it was before.

I wouldn't mind seeing it in /proc/pid/status if the accounting gets
merged.

> > > > Hey, I am all _for_ improving proc. But rather than adding more values,
> > > > I'd like to address some design problems first: For example, I'd
> > > > like to have a reserved value for N/A (currently, kernels just set
> > > > obsolete fields to 0 and parsers must guess whether it's truly 0 or not
> > > > available).
> > > 
> > > Don't even think of changing this.
> > 
> > Why not? Got a better solution?
> 
> Old tools need a value that will best make them work. (zero)

True for old fields. New fields are a different matter.

> New tools can examine the kernel version number.

Right. And every user space tool reading proc needs a database to
remember which field is active in which kernel version.

> > The current state of statm code clearly demonstrates the level of
> > interest in this concept.
> 
> It demonstrates that misleading data is hard to spot.
> It demonstrates that people hacking on the kernel are
> often unconcerned with providing correct stats for others.

I'd agree to some extent, but statm was pretty much impossible to fix
for even the most concerned kernel hacker.

Roger
