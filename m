Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311536AbSDIUvW>; Tue, 9 Apr 2002 16:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311564AbSDIUvV>; Tue, 9 Apr 2002 16:51:21 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:44999 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S311536AbSDIUvT>; Tue, 9 Apr 2002 16:51:19 -0400
Subject: Re: Event logging vs enhancing printk
From: Brian Beattie <alchemy@us.ibm.com>
To: Michel Dagenais <michel.dagenais@polymtl.ca>
Cc: linux-kernel@vger.kernel.org, Martin@m3.polymtl.ca,
        "Martin.Bligh@us.ibm.com" <J.Bligh@m3.polymtl.ca>,
        Tony.P.Lee@nokia.com, kessler@us.ibm.com, alan@lxorguk.ukuu.org.uk,
        Dave Jones <davej@suse.de>, karym@opersys.com, lmcmpou@lmc.ericsson.se,
        lmcleve@lmc.ericsson.se
In-Reply-To: <m2it71uf4u.fsf@m3.polymtl.ca>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 09 Apr 2002 13:49:53 -0700
Message-Id: <1018385394.7923.26.camel@w-beattie1>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-04-09 at 07:21, Michel Dagenais wrote:

> 
> The current printk simply does not cut it for these applications. There are
> over 80000 printk statements in the kernel, using many different conventions.

It would be easier, to fix the printk's, than to put evlogging into any
particular piece of the kernel.

> A few tens of driver specific tracing facilities (SCSI, ftape, wireless...)
> were implemented each with its own mechanism to compile/not the debugging
> statements, trigger massive debugging output at runtime...
> 

this could also be fixed as easily as adding evloging.

> The EVLOG proposition strikes me as a good balance between solid features,
> simplicity, and ease of integration/transition with the current printk.
> 

Evlog side-by-side with printk adds significat bloat.

> Here are some of the advantages of more structured logging:
> 
> - More consistent activation mechanisms for logging points
>   troughout the kernel at configuration/compilation time and at runtime.

I'm not sure what you are saying here, but if  I understand you, this is
a problem with the printk calls written by the author.  There is nothing
in evlog that will make this significatly easier for evlog as opposed to
evlog, and now you have two almost identical mechanisims to maintain.

> 
> - Structured data events for which it is easier to apply filtering, querying,
>   analysis and detection tools.

this is a post processing problem.  To speak to Martins issue of
interspersed messages, it would be easy enough, to make sure that each
call to printk starts with a new line, and prepends id information to
sort the messages.  What I hear you asking for, is to make it more of
the kernels responsibilty easing the problem of analysing the out put,
as opposed to making that the responsibilty of user space
postprocessing.  One thing to keep in mind, 99% of logged messages will
never be reviewed.

> 
> - More compact format, when desired, where data and text descriptions are 
>   separated. This facilitates high volume applications (lower logging 
>   overhead, smaller files) and also enables customization/i18n of the static 
>   text descriptions.

But poorly implemented, a new format will in pratice increase the
volume, and with the increased complexity of the logging also slowing
down, logging will be slower, and more messages will be lost.  This has
been seen in pratice.

> 
> - In its current configuration, klogd rapidly looses events under high volumes.
>   The Linux Trace Toolkit with its zero-copy, kernel-daemon shared memory,
>   does much better under heavy debugging/tracing output.

I would prefer to see effort expended on fixing printk/klogd...off the
top of my head:

- make printk a macro that prepends file/function/line to the message.
- fix printk calls: messages with consistent format, calls in the right
places, with the "correct" information.
- postprocessing tools for analysing the logs.

I would say that this is probably less work than implementing evlog,
much less work to maintain, and provide generally better performance.


