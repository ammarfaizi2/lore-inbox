Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129228AbQKKXSc>; Sat, 11 Nov 2000 18:18:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129385AbQKKXSW>; Sat, 11 Nov 2000 18:18:22 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:12816 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129228AbQKKXSI>; Sat, 11 Nov 2000 18:18:08 -0500
Date: Sat, 11 Nov 2000 17:17:49 -0600
To: Andrea Arcangeli <andrea@suse.de>
Cc: Michael Meissner <meissner@spectacle-pond.org>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        George Anzinger <george@mvista.com>,
        "linux-kernel@vger.redhat.com" <linux-kernel@vger.kernel.org>
Subject: Re: Where is it written?
Message-ID: <20001111171749.A32100@wire.cadcamlab.org>
In-Reply-To: <20001110184031.A2704@munchkin.spectacle-pond.org> <200011110011.eAB0BbF244111@saturn.cs.uml.edu> <20001110192751.A2766@munchkin.spectacle-pond.org> <20001111163204.B6367@inspiron.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001111163204.B6367@inspiron.suse.de>; from andrea@suse.de on Sat, Nov 11, 2000 at 04:32:04PM +0100
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Andrea Arcangeli]
> Can you think at one case where it's better to push the parameter on
> the stack instead of passing them through the callee clobbered
> ebx/eax/edx?

Well it's safer if you are lazy about prototyping varargs functions.
But of course by doing that you're treading on thin ice anyway, in
terms of type promotion and portability.  So I guess it's much better
to say "varargs functions MUST be prototyped" and use the registers.

I'd say go for it -- set up a mailing list and flesh out a better x86
ABI.  (Yes, this is the ubiquitous "someone besides me should..."
suggestion, I'm afraid I would look pretty foolish trying to help
design such.)  One issue: ideally you want to use 64-bit regs on AMD
Hammer for long longs, but then you leave out all legacy x68s. :(

AIUI gcc can cope OK with multiple ABIs to be chosen at runtime, am I
right?  IRIX, HP-UX and AIX all have both 32-bit and 64-bit ABIs.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
