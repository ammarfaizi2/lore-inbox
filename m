Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130151AbRBGTfX>; Wed, 7 Feb 2001 14:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129907AbRBGTfN>; Wed, 7 Feb 2001 14:35:13 -0500
Received: from thalia.fm.intel.com ([132.233.247.11]:39432 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S129608AbRBGTe4>; Wed, 7 Feb 2001 14:34:56 -0500
Message-ID: <4148FEAAD879D311AC5700A0C969E8905DE666@orsmsx35.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Tony Hoyle'" <tmh@magenta-netlogic.com>
Cc: linux-kernel@vger.kernel.org,
        "Acpi-linux (E-mail)" <acpi@phobos.fachschaften.tu-muenchen.de>
Subject: RE: ACPI slowdown...
Date: Wed, 7 Feb 2001 11:34:18 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Tony Hoyle [mailto:tmh@magenta-netlogic.com]
> OK I see that safe_halt() will re-enable interrupts.  However 
> this is only
> called in S1.  If your machine gets as far as S3 you have...

I think you mean C1 and C3, but I know what you mean.. :)

[C3 code snipped]

> There is no halt here... the interrupts are enabled for only 
> a couple of 
> instructions (one comparison and a jump) before being disabled again. 
> It seems to me if the computer gets into S3 it'll effectively 
> die until 
> some kind of busmaster device wakes it up (DMA?).

The problem I've had in fixing this code is that it WorksForMe(TM). I cannot
reproduce the problem on my machine (an IBM T20). That's the way the code
was, so I left it (the code I changed/broke was the C2/C3 latency calcs).

Since you have a symtomatic system, if you're willing to do some testing to
either prove or disprove your theory (that entering C2/C3 interrupts enabled
helps things) I would greatly appreciate it.

Also, the next ACPI update will let you disable using this code for idle (so
we have some breathing room while we fix it) and will print some more C
state info on boot, because although you don't say, it sounds like you have
a desktop system, which usually don't support C2/C3, and so should not be
trying to enter them.

Regards -- Andy
(ACPI maintainer)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
