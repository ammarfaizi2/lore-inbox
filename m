Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311618AbSDIVT0>; Tue, 9 Apr 2002 17:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311635AbSDIVTZ>; Tue, 9 Apr 2002 17:19:25 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:49858 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S311618AbSDIVTY>;
	Tue, 9 Apr 2002 17:19:24 -0400
Date: Tue, 09 Apr 2002 14:16:49 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Brian Beattie <alchemy@us.ibm.com>,
        Michel Dagenais <michel.dagenais@polymtl.ca>
cc: linux-kernel@vger.kernel.org, Tony.P.Lee@nokia.com, kessler@us.ibm.com,
        alan@lxorguk.ukuu.org.uk, Dave Jones <davej@suse.de>,
        karym@opersys.com, lmcmpou@lmc.ericsson.se, lmcleve@lmc.ericsson.se
Subject: Re: Event logging vs enhancing printk
Message-ID: <108620000.1018387009@flay>
In-Reply-To: <1018385394.7923.26.camel@w-beattie1>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> The current printk simply does not cut it for these applications. There are
>> over 80000 printk statements in the kernel, using many different conventions.
> 
> It would be easier, to fix the printk's, than to put evlogging into any
> particular piece of the kernel.

You want to fix 80000 printks? Be my guest ... I await your patch eagerly.
If you mean changing printk with a wrapper to help clean up the existing
mess in an automated fashion, that's exactly what's being proposed.

> Evlog side-by-side with printk adds significat bloat.

To what? A kernel with event logging switch on? Sure. 
But if you don't want it, don't turn it on. If it's a config option, I don't
see why anyone would care.
 
> What I hear you asking for, is to make it more of
> the kernels responsibilty easing the problem of analysing the out put,
> as opposed to making that the responsibilty of user space
> postprocessing. 

Indeed. That's because the kernel has more context, and can trivially
log the information it has, rather then reverse engineering it from user space.
Why munge all the messages to post them through a tiny little formatting
hole, and then try to unmunge them all again on the other side with a
bunch of hokey scripts?

> One thing to keep in mind, 99% of logged messages will
> never be reviewed.

If we had a more structured log format, it'd be a damned sight easier to
write automated tools to parse through them, and actually do something
useful with that 99%. Been there, done that.
 
> But poorly implemented, a new format will in pratice increase the
> volume, and with the increased complexity of the logging also slowing
> down, logging will be slower, and more messages will be lost.  This has
> been seen in pratice.

But correctly implemented, it will help. That's why this is being debated in
public to make sure the design is correct.

> I would prefer to see effort expended on fixing printk/klogd...off the
> top of my head:
> 
> - make printk a macro that prepends file/function/line to the message.
> - fix printk calls: messages with consistent format, calls in the right
> places, with the "correct" information.
> - postprocessing tools for analysing the logs.

This is actually very close to what is being proposed. The main reason the
we came to the conclusion that end result should be dumped into an evlog
file instead of dmesg and /var/log/messages is that changing the format
of /var/log/messages breaks the existing log parsing tools that people have.

If people wanted to take the improvments made for event logging, and use
those to change the dmesg output format, that would be a fairly simple efffort
for them to do as an additional patch on top of event logging.

M.

