Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129764AbRB0TFd>; Tue, 27 Feb 2001 14:05:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129766AbRB0TFX>; Tue, 27 Feb 2001 14:05:23 -0500
Received: from mail.surgient.com ([63.118.236.3]:57357 "EHLO
	bignorse.SURGIENT.COM") by vger.kernel.org with ESMTP
	id <S129764AbRB0TFQ>; Tue, 27 Feb 2001 14:05:16 -0500
Message-ID: <A490B2C9C629944E85CE1F394138AF957FC3E3@bignorse.SURGIENT.COM>
From: "Collins, Tom" <Tom.Collins@Surgient.com>
To: "'richardj_moore@uk.ibm.com'" <richardj_moore@uk.ibm.com>,
        Andreas Dilger <adilger@turbolinux.com>
Cc: "Collins, Tom" <Tom.Collins@Surgient.com>, linux-kernel@vger.kernel.org
Subject: RE: Dynamically altering code segments
Date: Tue, 27 Feb 2001 13:04:55 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey...thank you ... I have looked at the Linux Trace Toolkit
and was wondering if such a thing could be done.  I also
have visited the dprobes web site and that looked like
it had the mechanisms I was looking for.

Will the updated version appear next week at the dprobes 
web site?  I assume that it will.

I have one more question:  My trace code is currently 
implemented as a kernel loadable module.  Would I need
to change that so that it is built as part of the kernel,
or can I keep it as a loadable module?  If I can keep it
as a module, I would ensure that the module would be the 
only place that would enable/disable the trace, (don't
want the kernel jumping to a nonexistant address :O  ..)

Thanks again...will be looking for the upgrade next week...

Tom
-----Original Message-----
From: richardj_moore@uk.ibm.com [mailto:richardj_moore@uk.ibm.com]
Sent: Tuesday, February 27, 2001 12:15 PM
To: Andreas Dilger
Cc: Collins, Tom; linux-kernel@vger.kernel.org
Subject: Re: Dynamically altering code segments




Dprobes is one mechanism for doing what you want. It works the same way
OS/2 dynamic trace did. Another mecnahism, also available from the dprobes
web page is the GKHI (generalised kernel hooks interface). If you know you
want tracepoints in permanently assigned locations then you could code a
gkhi hook in the kernel which is essentially two jmps. When the hook is
inactive the first jmp bypasses the second, which jumps to the hook exit
dispatcher routine. When active the first jmp uses a zero offset. If you
use the gkhi you'll need to write you own hook exits, which presumably will
trace data and drop it into a trace buffer of your own making. Again if you
do decide to use ghki, please wait for 1.0 to be dropped next week
sometime.

If you go down the dprobes route you'll see that it inter-operates with
Linux Trace Toolkit to give you a dynamic tracing capability for Linux
(user and kernel space).  We're currently working on custom formatting for
raw trace data events created by dprobes. If you're familiar with os/2 then
TRCUST might mean something to you in connection with custom formatting.


Richard Moore -  RAS Project Lead - Linux Technology Centre (PISC).

http://oss.software.ibm.com/developerworks/opensource/linux
Office: (+44) (0)1962-817072, Mobile: (+44) (0)7768-298183
IBM UK Ltd,  MP135 Galileo Centre, Hursley Park, Winchester, SO21 2JN, UK


Andreas Dilger <adilger@turbolinux.com> on 27/02/2001 17:05:37

Please respond to Andreas Dilger <adilger@turbolinux.com>

To:   "Collins, Tom" <Tom.Collins@surgient.com>
cc:   linux-kernel@vger.kernel.org
Subject:  Re: Dynamically altering code segments




Tom Collins writes:
> I am wanting to dynamically modify the kernel in specific places to
> implement a custom kernel trace mechanism.  The general idea is that,
> when the "trace" is off, there are NOP instruction sequences at various
> places in the kernel.  When the "trace" is turned on, those same NOPs
> are replaced by JMPs to code that implements the trace (such as logging
> events, using the MSR and PMC's etc..).
>
> This was a trick that was done in my old days of OS/2 performance tools
> developement to get trace information from the running kernel.
>
> Is it possible to do the same thing in Linux?

See IBM "dprobes" project.  It is basically what you are describing
(AFAIK).  It makes sense, because a lot of the OS/2 folks are now working
on Linux.

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


