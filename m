Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312998AbSEHLNl>; Wed, 8 May 2002 07:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313019AbSEHLNk>; Wed, 8 May 2002 07:13:40 -0400
Received: from smtp-out-4.wanadoo.fr ([193.252.19.23]:11649 "EHLO
	mel-rto4.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S312998AbSEHLNj>; Wed, 8 May 2002 07:13:39 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Wesen <bjorn.wesen@axis.com>,
        Martin Dalecki <dalecki@evision-ventures.com>
Cc: Paul Mackerras <paulus@samba.org>, Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IDE 58
Date: Wed, 8 May 2002 13:12:56 +0200
Message-Id: <20020508111256.27246@smtp.wanadoo.fr>
X-Mailer: CTM PowerMail 3.1.2 F <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(resent, I had the date screwed up previously, sorry about the
inconvenience).

>I don't see why all IDE-interfaces in the world have to be I/O-mapped just 
>because the first PC implementations used that. Sure it was an extended 
>ISA-bus but the ISA bus is long gone and we don't all run PC's anymore 
>either.
>
>So the simple abstraction we need to hit IDE-bus registers is a macro or 
>inline, instead of a call of an I/O-primitive. It was too much work to 
>abstract this when I inserted the CRIS-arch IDE-driver in the first place 
>so I found a workaround but now seems like a better time..

No, not a macro. There are cases where you want different access methods
on the same machine. For example, pmacs can have the "mac-io" (ide-pmac)
controller, which is MMIO based, _and_ a PCI-based legacy IDE controller
using inx/outx like IOs. (A typical example is the Blue&White G3 who has
both on the motherboard).

Ultimately, you want the hwif (or what it becomes in 2.5) provide a set
of functions for accessing taskfile registers and doing the PIO data
stream read/writes (that is replace inb/outb and insw/outsw).


