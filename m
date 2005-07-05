Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261613AbVGETRw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261613AbVGETRw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 15:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261553AbVGETRp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 15:17:45 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:3795 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261398AbVGETRP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 15:17:15 -0400
Date: Tue, 5 Jul 2005 21:18:42 +0200
From: Jens Axboe <axboe@suse.de>
To: Ondrej Zary <linux@rainbow-software.org>
Cc: =?iso-8859-1?Q?Andr=E9?= Tomt <andre@tomt.net>,
       Al Boldi <a1426z@gawab.com>,
       "'Bartlomiej Zolnierkiewicz'" <bzolnier@gmail.com>,
       "'Linus Torvalds'" <torvalds@osdl.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [git patches] IDE update
Message-ID: <20050705191840.GC30235@suse.de>
References: <20050705101414.GB18504@suse.de> <42CA5EAD.7070005@rainbow-software.org> <20050705104208.GA20620@suse.de> <42CA7EA9.1010409@rainbow-software.org> <1120567900.12942.8.camel@linux> <42CA84DB.2050506@rainbow-software.org> <1120569095.12942.11.camel@linux> <42CAAC7D.2050604@rainbow-software.org> <20050705142122.GY1444@suse.de> <42CAA075.4040406@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42CAA075.4040406@rainbow-software.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05 2005, Ondrej Zary wrote:
> Jens Axboe wrote:
> >On Tue, Jul 05 2005, Ondrej Zary wrote:
> >
> >>Jens Axboe wrote:
> >>
> >>>On Tue, 2005-07-05 at 15:02 +0200, Ondrej Zary wrote:
> >>>
> >>>
> >>>>>Ok, looks alright for both. Your machine is quite slow, perhaps that is
> >>>>>showing the slower performance. Can you try and make HZ 100 in 2.6 and
> >>>>>test again? 2.6.13-recent has it as a config option, otherwise edit
> >>>>>include/asm/param.h appropriately.
> >>>>>
> >>>>
> >>>>I forgot to write that my 2.6.12 kernel is already compiled with HZ 100 
> >>>>(it makes the system more responsive).
> >>>>I've just tried 2.6.8.1 with HZ 1000 and there is no difference in HDD 
> >>>>performance comparing to 2.6.12.
> >>>
> >>>
> >>>OK, interesting. You could try and boot with profile=2 and do
> >>>
> >>># readprofile -r
> >>># dd if=/dev/hda of=/dev/null bs=128k 
> >>># readprofile > prof_output
> >>>
> >>>for each kernel and post it here, so we can see if anything sticks out.
> >>>
> >>
> >>Here are the profiles (used dd with count=4096) from 2.4.26 and 2.6.12 
> >>(nothing from 2.6.8.1 because I don't have the .map file anymore).
> >
> >
> >Looks interesting, 2.6 spends oodles of times copying to user space.
> >Lets check if raw reads perform ok, please try and time this app in 2.4
> >and 2.6 as well.
> >
> ># gcc -Wall -O2 -o oread oread.c
> ># time ./oread /dev/hda
> >
> oread is faster than dd, but still not as fast as 2.4. In 2.6.12, HDD 
> led is blinking, in 2.4 it's solid on during the read.
> 
> 2.6.12:
> root@pentium:/home/rainbow# time ./oread /dev/hda
> 
> real    0m25.082s
> user    0m0.000s
> sys     0m0.680s
> 
> 2.4.26:
> root@pentium:/home/rainbow# time ./oread /dev/hda
> 
> real    0m23.513s
> user    0m0.000s
> sys     0m2.360s

Hmm, still not as fast, not so good. 2.6 shows more idle time than 2.4,
about 20% more. I seem to remember Ken Chen saying that 2.6 direct io
was still a little slower than 2.4, your really slow hardware could be
showing this to a much greater effect.

I'll try and play with this tomorrow!

-- 
Jens Axboe

