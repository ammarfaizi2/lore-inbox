Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130417AbQLFArY>; Tue, 5 Dec 2000 19:47:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130456AbQLFArE>; Tue, 5 Dec 2000 19:47:04 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:5385 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130417AbQLFAqw>; Tue, 5 Dec 2000 19:46:52 -0500
Message-ID: <3A2D8509.117F6BD8@transmeta.com>
Date: Tue, 05 Dec 2000 16:15:05 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test11-pre5 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kai@thphy.uni-duesseldorf.de, Alan Cox <alan@redhat.com>
Subject: Re: That horrible hack from hell called A20
In-Reply-To: <Pine.LNX.4.10.10012051558490.13428-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> So the "orb $2,%al ; andb $0xfe,%al" will potentially change both of
> these. And I'd feel a hell of a lot more safe, if we avoided using 0x92
> except when we find that we absolutely _have_ to.
> 
> How about making the keyboard controller timeouts shorter, and moving all
> the 0x92 games to after the keyboard controller games. That, I feel, would
> be the safest approach: try the really old approach first (that people are
> the least likely to use as GPIO - it's just too damn painful to go through
> the keyboard controller, and the keyboard controller A20 logic is just too
> well documented, so nobody would use it for anything else).
> 
> If the keyboard controller times out, or if A20 still doesn't seem to be
> enabled, only _then_ would we do the 0x92 testing.
> 
> Btw, do we actually know of any machine that really needs the "and $0xfe"?
> That register really makes me nervous.
> 

Good question.  The whole thing makes me nervous... in fact, perhaps we
should really consider using the BIOS INT 15h interrupt to enter
protected mode?

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
