Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311936AbSDIW3Z>; Tue, 9 Apr 2002 18:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311948AbSDIW3Y>; Tue, 9 Apr 2002 18:29:24 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:54926 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S311936AbSDIW3W>; Tue, 9 Apr 2002 18:29:22 -0400
Subject: Re: Event logging vs enhancing printk
From: Brian Beattie <alchemy@us.ibm.com>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Michel Dagenais <michel.dagenais@polymtl.ca>, linux-kernel@vger.kernel.org,
        Tony.P.Lee@nokia.com, kessler@us.ibm.com, alan@lxorguk.ukuu.org.uk,
        Dave Jones <davej@suse.de>, karym@opersys.com, lmcmpou@lmc.ericsson.se,
        lmcleve@lmc.ericsson.se
In-Reply-To: <108620000.1018387009@flay>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 09 Apr 2002 15:28:59 -0700
Message-Id: <1018391340.7923.40.camel@w-beattie1>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-04-09 at 14:16, Martin J. Bligh wrote:
> >> The current printk simply does not cut it for these applications. There are
> >> over 80000 printk statements in the kernel, using many different conventions.
> > 
> > It would be easier, to fix the printk's, than to put evlogging into any
                                  ^ required
> > particular piece of the kernel.
> 
> You want to fix 80000 printks? Be my guest ... I await your patch eagerly.
> If you mean changing printk with a wrapper to help clean up the existing
> mess in an automated fashion, that's exactly what's being proposed.

how nice of you to say so.  As to automating, I don;t believe it can
work.  You will be adding volume to the log, making the log processing
more complicated, a replay of EES.

> 
> > Evlog side-by-side with printk adds significat bloat.
> 
> To what? A kernel with event logging switch on? Sure. 
> But if you don't want it, don't turn it on. If it's a config option, I don't
> see why anyone would care.

The poor sod who has to maintain this stuff.

>  
> > What I hear you asking for, is to make it more of
> > the kernels responsibilty easing the problem of analysing the out put,
> > as opposed to making that the responsibilty of user space
> > postprocessing. 
> 
> Indeed. That's because the kernel has more context, and can trivially
> log the information it has, rather then reverse engineering it from user space.
> Why munge all the messages to post them through a tiny little formatting
> hole, and then try to unmunge them all again on the other side with a
> bunch of hokey scripts?

Information that only the kernel has is not what I'm talking about, it
is all the stuff to make it easy to parse and collate, it has to be
possible, not necessarly easy.

> 
> > One thing to keep in mind, 99% of logged messages will
> > never be reviewed.
> 
> If we had a more structured log format, it'd be a damned sight easier to
> write automated tools to parse through them, and actually do something
> useful with that 99%. Been there, done that.

What? generate reports that will be munged for statistics that will be
quoted in endless management meetings.
>  
> > But poorly implemented, a new format will in pratice increase the
> > volume, and with the increased complexity of the logging also slowing
> > down, logging will be slower, and more messages will be lost.  This has
> > been seen in pratice.
> 
> But correctly implemented, it will help. That's why this is being debated in
> public to make sure the design is correct.

But you could get 90% of the advantage for much less effort by fixing
the problems with printk/klogd without implementing yet another
subsystem.

> 
> > I would prefer to see effort expended on fixing printk/klogd...off the
> > top of my head:
> > 
> > - make printk a macro that prepends file/function/line to the message.
> > - fix printk calls: messages with consistent format, calls in the right
> > places, with the "correct" information.
> > - postprocessing tools for analysing the logs.
> 
> This is actually very close to what is being proposed. The main reason the
> we came to the conclusion that end result should be dumped into an evlog
> file instead of dmesg and /var/log/messages is that changing the format
> of /var/log/messages breaks the existing log parsing tools that people have.

And this could be avoided using the "improved printk" by not compiling
the new features.


