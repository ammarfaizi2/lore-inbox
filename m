Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262125AbULCJoF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262125AbULCJoF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 04:44:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbULCJoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 04:44:05 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:58840 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262125AbULCJn7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 04:43:59 -0500
Date: Fri, 3 Dec 2004 10:43:14 +0100
From: Jens Axboe <axboe@suse.de>
To: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au
Subject: Re: Time sliced CFQ io scheduler
Message-ID: <20041203094314.GF10492@suse.de>
References: <20041202130457.GC10458@suse.de> <20041202134801.GE10458@suse.de> <20041202114836.6b2e8d3f.akpm@osdl.org> <20041202195232.GA26695@suse.de> <20041202121938.12a9e5e0.akpm@osdl.org> <41AF94B8.8030202@gmx.de> <20041203070108.GA10492@suse.de> <41B02DFD.9090503@gmx.de> <20041203091840.GD10492@suse.de> <41B03375.4050702@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41B03375.4050702@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03 2004, Prakash K. Cheemplavam wrote:
> Jens Axboe schrieb:
> >On Fri, Dec 03 2004, Prakash K. Cheemplavam wrote:
> >
> >>Jens Axboe schrieb:
> >>
> >>>On Thu, Dec 02 2004, Prakash K. Cheemplavam wrote:
> >>>
> >>
> >>>>0  3   3080   2208   1156 817712    0    0  3592 75624 1326  2289  1 36 
> >>>>0 63
> >>>>0  3   3080   2664   1156 818240    0    0  5124 15692 1302   992  1 18 
> >>>>0 81
> >>>>0  3   3080   2580   1160 815832    0    0  4356 155792 1375  1064  1 
> >>>>39  0 60
> >>>>0  3   3080   2472   1160 817124    0    0  3076 100852 1345  1138  1 
> >>>>23  0 76
> >>>>2  4   3080   2836   1148 816228    0    0  3336 100412 1352  1379  1 
> >>>>47  0 52
> >>>>0  4   3080   2708   1144 815964    0    0  3844 48908 1343   871  1 25 
> >>>>0 74
> >>>>0  3   3080   2748   1152 815984    0    0  3332 71996 1338   843  1 27 
> >>>>0 72
> >>>
> >>>
> >>>Can you try with the patch that is in the parent of this thread? The
> >>>above doesn't look that bad, although read performance could be better
> >>>of course. But try with the patch please, I'm sure it should help you
> >>>quite a lot.
> >>>
> >>
> >>It actually got worse: Though the read rate seems accepteble, it is not, 
> >>as interactivity is dead while writing. I cannot start porgrammes, other 
> >>programmes which want to do i/o pretty much hang. This is only while 
> >>writing. While reading there is no such problem.
> >
> >
> >Interesting, thanks for testing. I'll run some tests here as well, so
> >far only the cases mentioned yesterday have been tested.
> 
> BTW, in case it is misread: Above (except the io performance as such) is
> no regression: The other schedulers behave the same on my system.

Yes, that's what I assumed. Another thing to keep in mind is that even
with just a single writer, you could have 3 people doing writeout for
you (pdflush for each disk, and the writer itself), while the reader is
on its own. This could affect latencies/bandwidth for the reader in
not-so pleasant ways.

> >You could try and bumb the slice period. But I'll experiment and see
> >what happens. What is your test case?
> 
> [slice bumping] Uhm, is it doable via proc? I haven't seen text docs to
> your patch and I am not good at kernel code ;-)

:-)

See my previous mail, it tells you how to do it.

-- 
Jens Axboe

