Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129638AbRCERMe>; Mon, 5 Mar 2001 12:12:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129772AbRCERMY>; Mon, 5 Mar 2001 12:12:24 -0500
Received: from ns.suse.de ([213.95.15.193]:27911 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129638AbRCERMN>;
	Mon, 5 Mar 2001 12:12:13 -0500
To: Paul Flinders <P.Flinders@ftel.co.uk>
Cc: Jeff Mcadams <jeffm@iglou.com>, Rik van Riel <riel@conectiva.com.br>,
        John Kodis <kodis@mail630.gsfc.nasa.gov>,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        linux-kernel@vger.kernel.org, bug-bash@gnu.org
Subject: Re: binfmt_script and ^M
In-Reply-To: <20010305095512.A30787@tux.gsfc.nasa.gov>
	<Pine.LNX.4.21.0103051224450.5591-100000@imladris.rielhome.conectiva>
	<20010305105943.A25964@iglou.com> <3AA3BC4E.FA794103@ftel.co.uk>
X-Yow: Were these parsnips CORRECTLY MARINATED in TACO SAUCE?
From: Andreas Schwab <schwab@suse.de>
Date: 05 Mar 2001 18:12:05 +0100
In-Reply-To: <3AA3BC4E.FA794103@ftel.co.uk>
Message-ID: <jeae70m97e.fsf@hawking.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.0.99
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Flinders <P.Flinders@ftel.co.uk> writes:

|> Jeff Mcadams wrote:
|> 
|> > Also sprach Rik van Riel
|> > >On Mon, 5 Mar 2001, John Kodis wrote:
|> > >> On Mon, Mar 05, 2001 at 08:40:22AM -0500, Richard B. Johnson wrote:
|> > >> > Somebody must have missed the boat entirely. Unix does not, never
|> > >> > has, and never will end a text line with '\r'.
|> >
|> > >> Unix does not, never has, and never will end a text line with ' ' (a
|> > >> space character) or with \t (a tab character).  Yet if I begin a
|> > >> shell script with '#!/bin/sh ' or '#!/bin/sh\t', the training white
|> > >> space is striped and /bin/sh gets exec'd.  Since \r has no special
|> > >> significance to Unix, I'd expect it to be treated the same as any
|> > >> other whitespace character -- it should be striped, and /bin/sh
|> > >> should get exec'd.
|> >
|> > >Makes sense, IMHO...
|> >
|> > That only makes sense if:
|> > #!/bin/shasdf\n
|> > would also exec /bin/sh.
|> 
|> POSIX disagrees with you (accd to the manual page)
|> 
|> $ man isspace

This has no significance here.  The right thing to look at is $IFS, which
does not contain \r by default.  The shell only splits words by "IFS
whitespace", and the kernel should be consistent with it:

$ echo -e 'ls foo\r' | sh
ls: foo: No such file or directory

Andreas.

-- 
Andreas Schwab                                  "And now for something
SuSE Labs                                        completely different."
Andreas.Schwab@suse.de
SuSE GmbH, Schanzäckerstr. 10, D-90443 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
