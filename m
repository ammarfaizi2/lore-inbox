Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311593AbSCUQXk>; Thu, 21 Mar 2002 11:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311595AbSCUQXb>; Thu, 21 Mar 2002 11:23:31 -0500
Received: from acolyte.thorsen.se ([193.14.93.247]:48901 "HELO
	acolyte.hack.org") by vger.kernel.org with SMTP id <S311593AbSCUQXT>;
	Thu, 21 Mar 2002 11:23:19 -0500
From: Christer Weinigel <wingel@acolyte.hack.org>
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Hiroshi MIURA <miura@da-cha.org>,
        anders.wallin@mvista.com
Subject: NatSemi SC1200 timer problems
Message-Id: <20020321162312.7241DF5B@acolyte.hack.org>
Date: Thu, 21 Mar 2002 17:23:12 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm seeing some very strange problems with a NatSemi SC1200 based
system.  The problems is that the code to read the PIT counter
sometimes returns the bytes swapped:

    outb(0, 0x43);
    count = inb(0x40);
    count |= inb(0x40) << 8;

This sometimes gives 0x822e instead of 0x2e82 that is reasonable.  I
first thought this was a bug in another driver, but sometimes the
counter read from the timer would be 0xd5dd and that value should be
impossible to get, so I'm starting to suspect the hardware.

Besides this, I have a report that the TSC sometimes jumps ahead, so
that the reported time of day will be about 7 seconds more than it
should be.  

Does any of this sound familar?

Hiroshi MIURA <miura@da-cha.org> has a patch for a Cyrix CX5520 i8254
timer bug on his web page, but I have been unable to find any
information on the net on what the bug actually is.  Could you tell me
a bit more about it?  I'm trying to figure out if it has reappeared in
the SC1200 or if this is a completely new problem.

Alan, i think did a patch to disable the TSC on the MediaGX and I have
seen posts by you where you say about the MediaGX that "It reports a
TSC but the TSC is unreliable at least in certain strange
circumstances".  Do you refer to the TSC being stopped or turned off
on halt or suspend or is it a completely different problem?  Could you
please tell me what kind of problems you saw?

Regards,
   Christer (pulling his hair in confusion)

-- 
"Just how much can I get away with and still go to heaven?"
