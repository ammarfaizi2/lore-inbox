Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129361AbQLMBwa>; Tue, 12 Dec 2000 20:52:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129747AbQLMBwV>; Tue, 12 Dec 2000 20:52:21 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:43273 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129361AbQLMBwJ>; Tue, 12 Dec 2000 20:52:09 -0500
Date: Tue, 12 Dec 2000 19:17:19 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Rainer Mager <rmager@vgkk.com>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Signal 11 - the continuing saga
Message-ID: <20001212191719.A12420@vger.timpanogas.org>
In-Reply-To: <NEBBJBCAFMMNIHGDLFKGKENMCIAA.rmager@vgkk.com> <NEBBJBCAFMMNIHGDLFKGAEAHCJAA.rmager@vgkk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <NEBBJBCAFMMNIHGDLFKGAEAHCJAA.rmager@vgkk.com>; from rmager@vgkk.com on Wed, Dec 13, 2000 at 09:22:55AM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2000 at 09:22:55AM +0900, Rainer Mager wrote:
> Hi again,
> 
> 	Ok, I just upgraded to 2.4.0test12 (although I don't think there was any
> work in 12 that directly addresses this signal 11 problem). When compiling
> the new kernel I chose to disable AGPGart and RDM as suggested by
> davej@suse.de. I will report later if this makes any difference.
> 
> 	On another, possibly related note, I'm getting some really weird behavior
> with a Java program. The only reason I mention it here is because it dies
> with our old friend Signal 11. Anyway, please bear with the description
> below.
> 	I have a tiny bash script that launches a Java swing app. If I run my
> script from an xterm (or gnome-terminal or whatever) then it starts up fine.
> If, however, I try to launch it from my gnome taskbar's menu then it dies
> with signal 11 (the Java log is available upon request). This seems to be
> 100% consistent, since I noticed it yesterday, even across reboots.
> Interestingly, the same behavior occurs if I try to run the program from
> withis JBuilder 4.
> 	So, is this related to the larger signal 11 problems?

There's a corruption bug in the page cache somewhere, and it's 100%
reproducable.  Finding it will be tough....

> 
> 
> 	What else can I do regarding these issues to help fix it? Would a core dump
> help anyone? I'd really like to contribute somehow but I need some
> direction.
> 
> 
> --Rainer
> 
> > From: CMA [mailto:cma@mclink.it]
> > Did you already try to selectively disable L1 and L2 caches (if
> > your box has both) and see what happens?
> 
> Anyone know how to do this?

Usually this is performed in the BIOS setup.  You can also disable L1 
with a sequence of instructions that write to the CR0 register on intel
and flip a bit, but in doing this you have to execute a WBINV (write
back invalidate) instruction to flush out the cache.  BIOS setup is
probably simpler.  Disabling Level I will make the machine slower 
than mollasses, BTW, and if this bug is race related (they always 
are) it won't help much in running it down.

Jeff

> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
