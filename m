Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129417AbRCEQjT>; Mon, 5 Mar 2001 11:39:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129421AbRCEQjJ>; Mon, 5 Mar 2001 11:39:09 -0500
Received: from cc78409-a.hnglo1.ov.nl.home.com ([213.51.107.234]:30730 "EHLO
	dexter.hensema.xs4all.nl") by vger.kernel.org with ESMTP
	id <S129417AbRCEQit>; Mon, 5 Mar 2001 11:38:49 -0500
Date: Mon, 5 Mar 2001 17:37:49 +0100
From: Erik Hensema <erik@hensema.xs4all.nl>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org,
        bug-bash@gnu.org
Subject: Re: binfmt_script and ^M
Message-ID: <20010305173749.C16345@hensema.xs4all.nl>
In-Reply-To: <m3k8648i94.fsf@appel.lilypond.org> <Pine.LNX.3.95.1010305083112.8719A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3i
In-Reply-To: <Pine.LNX.3.95.1010305083112.8719A-100000@chaos.analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 05, 2001 at 08:40:22AM -0500, Richard B. Johnson wrote:
> On 5 Mar 2001, Jan Nieuwenhuizen wrote:

> > Pavel Machek <pavel@suse.cz> writes:

> > > > $ head -1 testscript
> > > > #!/bin/sh
> > > > $ ./testscript bash: ./testscript: No such file or directory

> > > What kernel wants to say is "/usr/bin/perl\r: no such
> > > file". Saying ENOEXEC would be even more confusing.

> > So, why don't we make bash say that, then?  As I guess that we've
> > all been bitten by this before.

> > What are the chances for something like this to be included?

> > Greetings, Jan.

> [SNIPPED...]

> So why would you even consider breaking bash as a work-around for a
> broken script?

Userfriendlyness.

> Somebody must have missed the boat entirely. Unix does not, never
> has, and never will end a text line with '\r'. It's Microsoft junk
> that does that, a throwback to CP/M, a throwback to MDS/200.

Yes, _we_ all know that. However, it's not really intuitive to the user
getting a 'No such file or directory' on a script he just created. Bash
doesn't say:
bash: testscript: Script interpreter not found
but bash says:
bash: testscript: No such file or directory

Maybe we should create a new errno: EINTERPRETER or something like that and
let the kernel return that instead of ENOENT.

Note that this has little to do with the \r\n problem but only with the
_real_ underlying reason: the script interpreter is not found and ENOENT is
returned confusing the user: the user thinks the _script_ is not found,
while its there, for sure.
-- 
Erik Hensema (erik@hensema.xs4all.nl)
