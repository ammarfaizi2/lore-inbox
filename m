Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313601AbSDZEFL>; Fri, 26 Apr 2002 00:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313605AbSDZEFK>; Fri, 26 Apr 2002 00:05:10 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:28400
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S313601AbSDZEFJ>; Fri, 26 Apr 2002 00:05:09 -0400
Date: Thu, 25 Apr 2002 21:04:57 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Stephen Samuel <samuel@bcgreen.com>, linux-kernel@vger.kernel.org,
        Andre Hedrick <andre@linux-ide.org>
Subject: Re: A CD with errors (scratches etc.) blocks the whole system while reading damadged files
Message-ID: <20020426040457.GO574@matchmail.com>
Mail-Followup-To: Bill Davidsen <davidsen@tmr.com>,
	Stephen Samuel <samuel@bcgreen.com>, linux-kernel@vger.kernel.org,
	Andre Hedrick <andre@linux-ide.org>
In-Reply-To: <3CC738AD.50905@bcgreen.com> <Pine.LNX.3.96.1020424232237.4586B-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2002 at 11:33:23PM -0400, Bill Davidsen wrote:
> I suspect (without having a good way to check) that all IDE devices
> sharing the IRQ with the error device *may* be affected. That's the only
> thing which comes to mind, I'll add a Promise controller and disk on a
> totally separate board and see if that changes anything. Hopefully it will
> not share the IRQ :-(

I don't think it has to do with the IRQs, but it sounds like the entire ide
chipset (think two cables one one chipset...) has stopped responding when
ONE device (out of a possible four (with two cables)) has failed media.

Let's use an example to help shine the light on exactly what I'm saying (I'm
trying to summarize what's been said in the threads, and I haven't tested
this... though I will be working on such a system in the next few weeks):

1)
Two drives each on a seperate cable, but on the same chipset:
/dev/hda (hard drive) (chipset1)
/dev/hdc (cd-rom) (chipset1)

Put broken CD into /dev/hdc, and read somehow (dd, cat, whatever), now try
to read from /dev/hda.  This (according to this thread) should be damn slow
and you will have a very hard time to use this system while it is trying to
read the CD.

2)
Two drives, each on a seperate cable and on different chipsets:
/dev/hda (hard drive) (chipset1)
/dev/hde (cd-rom) (chipset2)

Put broken CD into /dev/hde, read it again, and try to read from /dev/hda.
All should be good, with blue skies, and a responsive system.

Can someone verify that the above is true, and acurately expresses
what they've experienced?

Also, can someone say for sure (Andre) that this is a hardware limitation,
not a Linux IDE locking problem, and with no possibility of a software
work-around? 

Thanks,

Mike
