Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130315AbRCETD4>; Mon, 5 Mar 2001 14:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130320AbRCETDr>; Mon, 5 Mar 2001 14:03:47 -0500
Received: from balu.sch.bme.hu ([152.66.224.40]:50113 "EHLO balu.sch.bme.hu")
	by vger.kernel.org with ESMTP id <S130315AbRCETDj>;
	Mon, 5 Mar 2001 14:03:39 -0500
Date: Mon, 5 Mar 2001 19:58:52 +0100 (MET)
From: Pozsar Balazs <pozsy@sch.bme.hu>
To: Paul Flinders <P.Flinders@ftel.co.uk>
cc: Jeff Mcadams <jeffm@iglou.com>, Rik van Riel <riel@conectiva.com.br>,
        John Kodis <kodis@mail630.gsfc.nasa.gov>,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, <bug-bash@gnu.org>
Subject: Re: binfmt_script and ^M
In-Reply-To: <3AA3BC4E.FA794103@ftel.co.uk>
Message-ID: <Pine.GSO.4.30.0103051954420.25495-100000@balu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Mar 2001, Paul Flinders wrote:

> Jeff Mcadams wrote:
>
> > Also sprach Rik van Riel
> > >On Mon, 5 Mar 2001, John Kodis wrote:
> > >> On Mon, Mar 05, 2001 at 08:40:22AM -0500, Richard B. Johnson wrote:
> > >> > Somebody must have missed the boat entirely. Unix does not, never
> > >> > has, and never will end a text line with '\r'.
> >
> > >> Unix does not, never has, and never will end a text line with ' ' (a
> > >> space character) or with \t (a tab character).  Yet if I begin a
> > >> shell script with '#!/bin/sh ' or '#!/bin/sh\t', the training white
> > >> space is striped and /bin/sh gets exec'd.  Since \r has no special
> > >> significance to Unix, I'd expect it to be treated the same as any
> > >> other whitespace character -- it should be striped, and /bin/sh
> > >> should get exec'd.
> >
> > >Makes sense, IMHO...
> >
> > That only makes sense if:
> > #!/bin/shasdf\n
> > would also exec /bin/sh.
>
> POSIX disagrees with you (accd to the manual page)
>
> $ man isspace
>        ....
>        isspace()
>               checks for white-space characters.  In the "C"  and
>               "POSIX"   locales,   these  are:  space,  form-feed
>               ('\f'), newline  ('\n'),  carriage  return  ('\r'),
>               horizontal tab ('\t'), and vertical tab ('\v').

And what does POSIX say about "#!/bin/sh\r" ?
In other words: should the kernel look for the interpreter between the !
and the newline, or [the first space or newline] or the first whitespace?

IMHO, the first whitespace. Which means that "#!/bin/sh\r" should invoke
/bin/sh. (though it is junk).

-- 

