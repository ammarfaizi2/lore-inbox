Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751294AbVJGCHH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbVJGCHH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 22:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbVJGCHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 22:07:07 -0400
Received: from xproxy.gmail.com ([66.249.82.207]:65165 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751294AbVJGCHF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 22:07:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KuXgirXAajqQiJnSo4YeGkHsElliVtsCGbO711KHet3FufUh8bA9AhTgDgVtVz4ukdcp8SSKOxDJOgyGF4uKi+jNtWywLFUneEwmFGFN8arZzJUMGWWD3Hbi83MSLhUUEB2MPfNaw5IBHINZ3Y1CCu07Ya/kchO1KJ3T5HEvVXc=
Message-ID: <5bdc1c8b0510061907w372cb406x45140b01e4011c4a@mail.gmail.com>
Date: Thu, 6 Oct 2005 19:07:05 -0700
From: Mark Knecht <markknecht@gmail.com>
Reply-To: Mark Knecht <markknecht@gmail.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.14-rc3-rt10 - xruns & config questions
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <5bdc1c8b0510061338r41e0b51ds2efd435a591d953e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5bdc1c8b0510061152o686c5774x2d0514a1f1b4e463@mail.gmail.com>
	 <20051006195242.GA15448@elte.hu>
	 <5bdc1c8b0510061307saf22655y26dd1e608b33a40c@mail.gmail.com>
	 <5bdc1c8b0510061338r41e0b51ds2efd435a591d953e@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/05, Mark Knecht <markknecht@gmail.com> wrote:
>
> I found an old conversation that answered this, at least when I'm
> logged in as root. Hopefully it will work at boot time also:
>
> chrt -f -p 80  `pidof "IRQ 58"`
>
> I noted that the default chrt command changed the IRQ process from
> SCHED_FIFO to SCHED_RR so I assume I really should leave it at
> SCHED_FIFO?
>

Evening all. A small report...

After getting rt priorities semi-setup using this commands:

/usr/bin/chrt -f -p 80  `/bin/pidof "IRQ 58"`
/usr/bin/chrt -f -p 61 `/bin/pidof "IRQ 66"`
/usr/bin/chrt -f -p 60 `/bin/pidof "IRQ 233"`

where 58 is my sound card, 66 is my 1394 audio drive, and 233 is
(apparently) my internal SATA system drive, I am now running a very
fast 64/2 setting on Jack. This corresponds to <3mS latency and is the
best that I can do with RME sound cards since the Alsa driver enforces
nothing lower than buffer sizes of 64. If things run at this level
reliably then no one is going to hear the latency and recorded audio
can go full circle and sound live. This is great. Thanks!

However, at odd times I still get xruns. For instance one set of xruns
came while browsing the web. I was on this page:

http://steveisaacs.typepad.com/news/2005/09/a_little_more_e.html

and went to this page:

http://steveisaacs.typepad.com/news/2005/09/adventureland.html

and got 2 xruns:

18:20:06.541 XRUN callback (8).
**** alsa_pcm: xrun of at least 3.172 msecs
**** alsa_pcm: xrun of at least 0.967 msecs
18:20:07.908 XRUN callback (1 skipped).

So, while things are far, far better for me than they were earlier
this wekk, there are still some problems I'd like to get to the bottom
of if possible.

I see no xruns created by using Gnome. I can change desktops, start
and stop applications, wiggle my mouse excessively, and do lots of
other things. No problems. I am still somewhat concerned however about
my networking setup. This motherboard uses the NVidia driver which is
marked as 'reverse engineered' and experiemental, I believe.

Would it make sense to put a different NIC in here or is that not
likely to produce valuable results? I'm not immediately certain if I
even have a PCI slot, and if I do it will likely share an interrupt
with some other device.

I will also mention, although I'm hoping it doesn't matter, that I am
seeing an occasional xrun problem when using an audio app that's
attached to the Jack server. For instance, if a certian app is
transferring audio and I tell the app to load a new file into a list
of files to be played then Jack reports a 'subgraph timeout'
associated with the app even though the new files won't get played
immediately.

I am assuming for now that this is just an internal programming issue
in the application itself, but maybe not. I don't know yet.

I have tried rebuilding the kernel with the preempt debug option
turned off. This did not seem to improve this remain souce of xruns.

As always I'm interested in whatever ideas folks have to help me zero
in on the source of the problems.

Thanks,
Mark
