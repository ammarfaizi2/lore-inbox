Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293432AbSCUGOn>; Thu, 21 Mar 2002 01:14:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293410AbSCUGOe>; Thu, 21 Mar 2002 01:14:34 -0500
Received: from tomts17-srv.bellnexxia.net ([209.226.175.71]:42447 "EHLO
	tomts17-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S293407AbSCUGOY>; Thu, 21 Mar 2002 01:14:24 -0500
Content-Type: text/plain; charset=US-ASCII
From: Martin Blais <blais@iro.umontreal.ca>
To: linux-kernel@vger.kernel.org
Subject: xxdiff as a visual diff tool (shameless plug)
Date: Thu, 21 Mar 2002 01:13:32 -0500
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020321061423.HIXG2746.tomts17-srv.bellnexxia.net@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello gang.

(I always thought you guys must be visual-diff hungry, with the
large amount patching-by-hand that you must do, and I knew I'd
send this email one day, just never got to it.  I've witnessed
the latest KT with the discussion about SCM systems, and in
particular, the discussion about the graphical merge tools, so
now is the time or never.)

I was wondering if you've tried my tool xxdiff (shameless
plug), it has the following features:

  * 2-way and 3-way file comparisons, with LOTS of conveniences
    for merging and policing (selecting hunks, reordering, fast
    "save as merged" button);

  * highlighting of horizontal diffs (once you try that for
    merge reviews, you can never go back); multiple horizontal
    diff hunks are supported as well, i.e. if you added two
    words on a line, sufficiently separated, it highlights the
    two words separately;

  * can show the resulting merged file from the selections (in
    a separate window, currently dev. feature is a classic
    3-pane view);

  * can "unmerge" CVS conflicts and display them as if they
    were two files;

  * uses whatever external diff program you prefer (I used to
    use cleardiff which sometimes does a better does than GNU
    diff)

  * fully customizable with an .xxdiffrc file

It depends only on troltech's qt, so you don't need a desktop
environment to use it. I've introduced it at my workplace and
at least 50 people using it daily in a commercial development
environment for more than 2 years now, people using it mostly
for merge reviews and merging, so it has become fairly
stable. And quite many users have been replacing their vendor's
visual diff with it.

Check it out at   http://xxdiff.sourceforge.net

(I actually bothered writing documentation as well)

It does not do edits at this point because I felt everyone has
their own strong preferences for editing files. However, I may
in the future support very simple editing of hunks. For now,
the recommended way to edit is to leave some hunks unselected
and those will be output in the merged file with markers
similar to CVS conflicts. You can then edit the files. Also,
what I often do is leave it running, then edit one of the
original files and then press C-r, and it redoes the diff.


I'd be delighted to hear any ideas on features you think are
missing, incorrect or needed for integration with BitKeeper and
otherwise, and also what you would like to see in it in the
future (I could prioritize development). Check out the TODO
file for details (from the web site).

With the large amount of parallel development going on in the
kernel, some of you guys must be experts at merging patches,
and I'm sure you'll come up with tons of cool ideas. I'm
actively supporting and developing this tool, so I will
consider suggestions seriously, although I have limited amount
of nighttime to develop this.


I was already contemplating adding support for patch input
(mentioned in KT) and output (I think I might be able to hack
this quickly in the meantime with a wrapper script).


> Andrew said that tkdiff was already quite good at this, and
> might be something to merge into the project. But he added,
> "The problem I find is that I often want to take (file1+patch)
> -> file2, when I don't have file1. But merge tools want to take
> (file1|file2) -> file3. I haven't seen a graphical tool which
> helps you to wiggle a patch into a file." 

I actually wanted to implement it exactly like this in xxdiff,
and I think it may not be too hard. Something like

  "xxdiff --patch file1 < patch"

and it would display as two files, and allow you to save merged
results. That was the plan (read more below).

I wanted to spawn a patch command on it and recuperate the
output and then run diff and display that, so one could use and
alternate patch program as well, and I would reuse patch's
heuristics automatically (e.g. i don't have to code it myself).


> Neil Brown agreed with this, and said, "I would like a tool
> (actually an emacs mode) that would show me exactly why a patch
> fails, and allow me to edit bits until it fits, and then apply
> it. I assume that is what you mean by "wiggle a patch into a
> file"." Pavel Machek also thought this would be a rerally great
> thing.

The part I haven't figured out a nice solution for yet, is for
the failed hunks... how to display them sensibly.  I was
thinking of using the 3-file display with the third file
showing only the failed hunks in the approximate location where
they were supposed to be. Not sure how to do this yet. Any
ideas welcome.

Cheers,



--
M.

PS. Please CC replies to me, I don't follow the list itself,
just the KT summaries.
