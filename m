Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261715AbTCNLQz>; Fri, 14 Mar 2003 06:16:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261763AbTCNLQy>; Fri, 14 Mar 2003 06:16:54 -0500
Received: from gold.muskoka.com ([216.123.107.5]:19983 "EHLO gold.muskoka.com")
	by vger.kernel.org with ESMTP id <S261715AbTCNLQx>;
	Fri, 14 Mar 2003 06:16:53 -0500
Message-ID: <3E71BAB6.AFB608BC@yahoo.com>
Date: Fri, 14 Mar 2003 06:19:18 -0500
From: Paul Gortmaker <p_gortmaker@yahoo.com>
X-Mailer: Mozilla 4.51 [en] (X11; I; Linux 2.4.21-pre5 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Andries Brouwer <aebr@win.tue.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: bio too big device
References: <20030312090943.GA3298@suse.de> <Pine.LNX.4.10.10303120205250.391-100000@master.linux-ide.org> <20030312101414.GB3950@suse.de> <20030312154440.GA4868@win.tue.nl> <b4nsh7$eg0$1@penguin.transmeta.com> <20030312212846.GA4925@win.tue.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer wrote:

> We have seen *one* drive (a six years old Maxtor 7850AV) that could not
> sustain heavy load with max # secs set to 256, while it behaved better
> with max set to 255.

[...] 

> Paul remarked: "So the 255 (or even the old 128) fixes things vs. 256,
> but I'd feel better being 100% sure why. Is 255 a "fix" or a perturbation
> that happens to paper over something else?"

As luck would have it, I kept that drive around, thinking it might be
interesting to have around if the above "why" part got revisited
someday.

> I think there is no good reason to limit us to 255 sectors.
> 
> (And no reason for blacklists either - there is just no good evidence
> that something is systematically wrong with 256 sectors for any brand or
> model. Things would change if a second Maxtor 7850AV owner could confirm.)

Perhaps I can also act as the second owner in this case.  :-) The drive is 
currently in an old 16MB P133 on a PIIX3, so after tripping over this 
thread, I did some testing to 1st see if I could still re-create any 
problems in this different box.  Of note, 2.4.21pre5 reports:

hda: 1667232 sectors (854 MB) w/64KiB Cache, CHS=1654/16/63, BUG DMA OFF
                                        -------------------->^^^
which I haven't looked into yet. Anyway, I tweaked pre5 to re-allow 256
and then let it do two 2.5.64 compiles at the same time (in 16MB, this
takes a while) and nothing broke.  Thinking that the original problem was 
in an even older VLB box, I disabled DMA and did the same test. Still no
breakage.

What does this mean?  I'm not sure :)  Maybe this simple test isn't as
harsh as the prior one from several years ago.   Realistically, there 
are a fair number of changes that also may have a role: e.g.  ide driver, 
gcc, gas, kernel, CPU, mainboard, ide controller, PSU, cables, and so on 
all have changed.  It looks like I would need to jump back into the past 
and test on the exact same system and then progressively rule out some 
of these variables.
 
Paul.

