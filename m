Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129675AbRAPNAh>; Tue, 16 Jan 2001 08:00:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129868AbRAPNA1>; Tue, 16 Jan 2001 08:00:27 -0500
Received: from schmee.sfgoth.com ([63.205.85.133]:53002 "EHLO
	schmee.sfgoth.com") by vger.kernel.org with ESMTP
	id <S129675AbRAPNAT>; Tue, 16 Jan 2001 08:00:19 -0500
Date: Tue, 16 Jan 2001 05:00:04 -0800
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: O_ANY  [was: Re: 'native files', 'object fingerprints' [was: sendpath()]]
Message-ID: <20010116050003.J5386@sfgoth.com>
In-Reply-To: <20010116123743.A32075@gruyere.muc.suse.de> <Pine.LNX.4.30.0101161242180.529-100000@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <Pine.LNX.4.30.0101161242180.529-100000@elte.hu>; from mingo@elte.hu on Tue, Jan 16, 2001 at 01:04:22PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> - probably the most radical solution is what i suggested, to completely
> avoid the unique-mapping of file structures to an integer range, and use
> the address of the file structure (and some cookies) as an identification.

IMO... gross.  We do pretty much this exact thing in the ATM code (for
the signalling daemon and the kernel exchainging status on VCCs) and it's
pretty disgusting.  I want to make it go away.

> - a less radical solution would be to still map file structures to an
> integer range (file descriptors) and usage-maintain files per processes,
> but relax the 'allocate first non-allocated integer in the range' rule.
[...]
> 	fd = open(...,O_ANY);

Yeah, this gets talked about, but I don't think a new flag for open is a
good way to do this, because open() isn't the only thing that returns
a new fd.  What about socket()?  pipe()?

Maybe we could have a new prctl() control that turns this behavior
on and off.  Then you'd just have to be careful to turn it back off
before calling any library functions that require ordering (like popen).

Other than that, I think it'd be a good idea, especially if it could
be implemented clean enough to make it CONFIG_'urable.  That can't
really be fairly judged until someone produces the code.

-Mitch
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
