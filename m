Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130139AbQLFBlY>; Tue, 5 Dec 2000 20:41:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131044AbQLFBlP>; Tue, 5 Dec 2000 20:41:15 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:24587 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130139AbQLFBlH>; Tue, 5 Dec 2000 20:41:07 -0500
Message-ID: <3A2D91F0.D8FE8BBC@transmeta.com>
Date: Tue, 05 Dec 2000 17:10:08 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test11-pre5 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kai Germaschewski <kai@thphy.uni-duesseldorf.de>,
        Alan Cox <alan@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: That horrible hack from hell called A20
In-Reply-To: <Pine.LNX.4.10.10012051703080.811-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> Actually, I bet I know what's up.
> 
> Want to bet $5 USD that suspend/resume saves the keyboard A20 state, but
> does NOT save the fast-A20 gate information?
> 
> So anything that enables A20 with only the fast A20 gate will find that
> A20 is disabled again on resume.
> 
> Which would make Linux _really_ unhappy, needless to say. Instant death in
> the form of a triple fault (all of the Linux kernel code is in the 1-2MB
> area, which would be invisible), resulting in an instant reboot.
> 
> Peter, we definitely need to do the keyboard A20, even if fast-A20 works
> fine.
> 

Yup.  It's a BIOS bug, oh what a shocker... (that never happens, right)?

I might hack on using INT 15h to do the jump to protected mode, as ugly
as it is, but I won't have time before my trip.  It would require quite a
bit of restructuring in setup.S, and would probably break LOADLIN.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
