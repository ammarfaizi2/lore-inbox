Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266003AbUHFPDg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266003AbUHFPDg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 11:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268077AbUHFPDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 11:03:36 -0400
Received: from mail4.bluewin.ch ([195.186.4.74]:45531 "EHLO mail4.bluewin.ch")
	by vger.kernel.org with ESMTP id S266003AbUHFPDc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 11:03:32 -0400
Date: Fri, 6 Aug 2004 17:02:36 +0200
From: Roger Luethi <rl@hellgate.ch>
To: William Lee Irwin III <wli@holomorphy.com>,
       Albert Cahalan <albert@users.sf.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
Subject: Re: [proc.txt] Fix /proc/pid/statm documentation
Message-ID: <20040806150236.GA28743@k3.hellgate.ch>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Albert Cahalan <albert@users.sf.net>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>,
	linux-mm@kvack.org
References: <1091754711.1231.2388.camel@cube> <20040806094037.GB11358@k3.hellgate.ch> <20040806104630.GA17188@holomorphy.com> <20040806120123.GA23081@k3.hellgate.ch> <20040806121118.GE17188@holomorphy.com> <20040806135756.GA21411@k3.hellgate.ch> <20040806140714.GG17188@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040806140714.GG17188@holomorphy.com>
X-Operating-System: Linux 2.6.8-rc3 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Aug 2004 07:07:14 -0700, William Lee Irwin III wrote:
> On Fri, 06 Aug 2004 05:11:18 -0700, William Lee Irwin III wrote:
> >> Some of the 2.4 semantics just don't make sense. I would not find it
> >> difficult to explain what I believe correct semantics to be in a written
> >> document.
> 
> On Fri, Aug 06, 2004 at 03:57:56PM +0200, Roger Luethi wrote:
> > IMO this is a must for such files (and be it only some comments above
> > the code implementing them). I'm afraid that statm is carrying too much
> > historical baggage, though -- you would add yet another interpretation
> > of those 7 fields.
> > Tools reading statm would have to be updated anyway, so I'd rather
> > think about what could be done with a new (or just different) file.
> 
> Okay, could you write up a "specification" for what you want reported,
> then I can cook up a new file or some such for you?

Thanks for your offer. I really suck at communicating, it seems. I don't
mind implementing my suggestion or writing documentation if there is a
general agreement that this is the way to go. Currently, I am looking
for suggestions and comments.

My suggestion for /proc/pid/statm would be

Field 0 := /proc/pid/status:VmSize
Field 1 := /proc/pid/status:VmRSS
Fields 2-6: 0

That's really just cleaning up cruft and is trivial to implement.

============ Warning. Switching subject.
Maybe I should have started a separate thread for that. Sorry about
the confusion.

I am also interested in a related problem -- finding a better way for
tools to access process information. Preferably a generic way so we
don't need to keep tools and kernel in sync forever. I have some ideas,
but I don't know if they are acceptable as solutions (and if the problem
actually exists as I see it).

Most of the current problems with proc are related to tools: They don't
like changes and some of them are very sensitive to resource usage
(because they may make hundreds of calls per second on typical systems).

If we want to facilitate the use of additional information in tools,
I see two possible strategies:

- Design a new solution that enables tools to discover the fields
  that are available and to ask for a subset (as I sketched out in my
  previous post). This would remove the need for inflexible solutions
  like statm.

- Split proc information by new criteria: Slow, expensive items should
  not be in the same file as information that tools typically
  and frequently read. For instance, you could have status_basic,
  status_exotic, and status_slow. Even status_basic could have a format
  similar to /proc/pid/status, but would be shorter and contain only
  the most frequently used values (like statm today -- with all the
  problems that come with such a pre-made selection).

Roger
