Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130673AbRCEVHN>; Mon, 5 Mar 2001 16:07:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130676AbRCEVHE>; Mon, 5 Mar 2001 16:07:04 -0500
Received: from balu.sch.bme.hu ([152.66.224.40]:57274 "EHLO balu.sch.bme.hu")
	by vger.kernel.org with ESMTP id <S130673AbRCEVG4>;
	Mon, 5 Mar 2001 16:06:56 -0500
Date: Mon, 5 Mar 2001 22:05:36 +0100 (MET)
From: Pozsar Balazs <pozsy@sch.bme.hu>
To: Robert Read <rread@datarithm.net>
cc: Paul Flinders <P.Flinders@ftel.co.uk>, Jeff Mcadams <jeffm@iglou.com>,
        Rik van Riel <riel@conectiva.com.br>,
        John Kodis <kodis@mail630.gsfc.nasa.gov>,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: binfmt_script and ^M
In-Reply-To: <20010305123907.C6400@tenchi.datarithm.net>
Message-ID: <Pine.GSO.4.30.0103052154360.28239-100000@balu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Mar 2001, Robert Read wrote:
> On Mon, Mar 05, 2001 at 07:58:52PM +0100, Pozsar Balazs wrote:
> >
> > And what does POSIX say about "#!/bin/sh\r" ?
> > In other words: should the kernel look for the interpreter between the !
> > and the newline, or [the first space or newline] or the first whitespace?
> >
> > IMHO, the first whitespace. Which means that "#!/bin/sh\r" should invoke
> > /bin/sh. (though it is junk).
>
> The line terminator, '\n', is what terminates the interpreter.  White
> space (in this case, only ' ' and '\t') is used to seperate the
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> arguments to the interpreter.


The last little tiny thing that bothers me: why? Why only ' ' and '\t' _in
this case_? As someone mentioned, even isspace() returns whitespace.

A possible answer (that i can think of), is that those ar the whitespaces,
which are in IFS (as said previously), taking out us from kernel-space
into userspace. But imho we shouldn't define another set whitespace for
this case, can't we just use what isspace() says?

(okay, I'm not for this '\r' thingy, I just want to see the reasons.)

-- 
Balazs Pozsar.

