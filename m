Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932110AbWJHXdh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbWJHXdh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 19:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932111AbWJHXdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 19:33:37 -0400
Received: from wx-out-0506.google.com ([66.249.82.228]:29323 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932110AbWJHXdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 19:33:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Pwb1IN7PtCkSFTRgdpgpXFNy1iTiEZCL+/Vvj4OLnIfIzBneKgD308tNiYBMOpyVvCE27Wzmk2rZYX2dXpA3R/M6BRsQv9LfjgxDg4y78lKcN2h6/J+XTf6Ufv+wNT1lWxSzk5vWhc4eo0vqPTo9CoLcyLT7Rn/xbkMqVoEqkXs=
Message-ID: <9a8748490610081633k7bf011d1q131b2f9e06f2808d@mail.gmail.com>
Date: Mon, 9 Oct 2006 01:33:35 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Subject: Re: Simple script that locks up my box with recent kernels
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610071408220.3952@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9a8748490610061636r555f1be4x3c53813ceadc9fb2@mail.gmail.com>
	 <Pine.LNX.4.64.0610062000281.3952@g5.osdl.org>
	 <9a8748490610071402m4450365kedff5615d008fcd5@mail.gmail.com>
	 <Pine.LNX.4.64.0610071408220.3952@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, some preliminary results on this before I go get some sleep + a
working day tomorrow...


On 07/10/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
>
> On Sat, 7 Oct 2006, Jesper Juhl wrote:
> >
> > > Can I bother you to just bisect it?
> >
> > Sure, but it will take a little while since building + booting +
> > starting the test + waiting for the lockup takes a fair bit of time
> > for each kernel
>
> Sure. That said, we've tried to narrow down things that took hours or days
> (under real loads, not some nice test-script) to reproduce, and while it
> doesn't always work, the real problem tends to be if the problem case
> isn't really reproducible. It sounds like yours is pretty clear-cut, and
> that will make things much easier.
>

Yeah, it seems pretty clear-cut, but I'm a bit nervous that it may
sometimes take longer than my observed 60min to reproduce, rendering
my git-bisection less than perfect (more on that below).


> > and also due to the fact that my git skills are pretty
> > limited, but I'll figure it out (need to improve those git skills
> > anyway) :-)
>
> "git bisect" in particular isn't that hard to use, and it will really do
> a lot of heavy lifting for you.
>
(...)
Thanks a lot for the tutorial, that really helped.

For some reason I couldn't get git to accept 2.6.17.13 as a "good"
starting point, so I used 2.6.17 instead, and the sha1 you gave me for
2.6.18-git15 as the "bad" starting point.

Here's where I am right now (a log of what I've done) :

[bisection start]

Bisecting: 5188 revisions left to test after this
[92164c5dd1ade33f4e90b72e407910de6694de49] USB: OHCI hub code unaligned access

[git bisect good]

Bisecting: 2567 revisions left to test after this
[e41542f5167d6b506607f8dd111fa0a3e468ccb8] [DCCP]: Introduce dccp_probe

[git bisect good]

Bisecting: 1351 revisions left to test after this
[b98adfccdf5f8dd34ae56a2d5adbe2c030bd4674] Merge
master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-2.6

[git bisect good]

Bisecting: 635 revisions left to test after this
[538d9d532b0e0320c9dd326a560b5a72d73f910d] irq: remove a extra line

[git bisect good]

Bisecting: 292 revisions left to test after this
[db1a19b38f3a85f475b4ad716c71be133d8ca48e] Merge branch
'intelfb-patches' of
master.kernel.org:/pub/scm/linux/kernel/git/airlied/intelfb-2.6

[git bisect bad]

Bisecting: 146 revisions left to test after this
[1db27c11e9a0c6d659040ac0b7c64a339e248fa1] istallion: Remove private
baud rate decoding, which is also broken in this case on some
platforms

[git bisect bad]

Bisecting: 73 revisions left to test after this
[3171a0305d62e6627a24bff35af4f997e4988a80] simplify update_times
(avoid jiffies/jiffies_64 aliasing problem)

[git bisect good]

Bisecting: 37 revisions left to test after this
[29b884921634e1e01cbd276e1c9b8fc07a7e4a90] set EXIT_DEAD state in
do_exit(), not in schedule()

[currently testing this kernel]


Looking at "git bisect visualize" the current status is this :

bisect/good: 3171a0305d62e6627a24bff35af4f997e4988a80
bisect/bad: 1db27c11e9a0c6d659040ac0b7c64a339e248fa1
Current bisect marker at: 29b884921634e1e01cbd276e1c9b8fc07a7e4a90


I'm a little worried though that my results may not be completely reliable.

There's no doubt that you can trust the kernels that I told git were
"bad" since those resultet in a hang and there's just no getting
around that. So we know for a fact that the bad commit is somewhere
between my last found bad kernel and 2.6.17, what we don't know with
the same amount of certainty is if the bad commit is between my last
found good kernel and the last found bad one.

What I'm worried about is the kernels I've marked as "good".  Before
starting this run I had never experienced a hang if the kernel
survived past the one hour mark, so I concluded that testing each
kernel for 80min would be enough to prove it good or bad. This now
seems to be not completely reliable since my second bad kernel
happened to hang after ~2hrs. This happened since I forgot to check my
computer after 80min and only came back to it some 3hrs later (I know
the time it hung since I had a xterm doing   while true;do sleep
10;uptime;done  running, so I could check.

This all means that my testing and concluding kernels were "good"
after 80min of test runtime may not be 100% reliable.

Is it useful for me to continue bisecting from the point I'm at, or
should I reset from good==2.6.17 and bad==the_last_bad_commit_I_found
?   Or do you have a likely culprit I should try revoking?

Whatever your answer it'll have to wait until tomorrow evening since
I'm going to go get some sleep now, but please let me know what you'd
like me to do ...


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
