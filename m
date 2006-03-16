Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752197AbWCPGqb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752197AbWCPGqb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 01:46:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752192AbWCPGqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 01:46:31 -0500
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:49902 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1752189AbWCPGqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 01:46:30 -0500
To: "Yu, Luming" <luming.yu@intel.com>
cc: linux-kernel@vger.kernel.org, "Linus Torvalds" <torvalds@osdl.org>,
       "Andrew Morton" <akpm@osdl.org>, "Tom Seeley" <redhat@tomseeley.co.uk>,
       "Dave Jones" <davej@redhat.com>, "Jiri Slaby" <jirislaby@gmail.com>,
       michael@mihu.de, mchehab@infradead.org,
       "Brian Marete" <bgmarete@gmail.com>,
       "Ryan Phillips" <rphillips@gentoo.org>, gregkh@suse.de,
       "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org,
       "Mark Lord" <lkml@rtr.ca>, "Randy Dunlap" <rdunlap@xenotime.net>,
       jgarzik@pobox.com, "Duncan" <1i5t5.duncan@cox.net>,
       "Pavlik Vojtech" <vojtech@suse.cz>, "Meelis Roos" <mroos@linux.ee>
Subject: Re: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
In-Reply-To: Your message of "Wed, 15 Mar 2006 16:02:57 +0800."
             <3ACA40606221794F80A5670F0AF15F840B32AC5E@pdsmsx403> 
Date: Thu, 16 Mar 2006 06:46:26 +0000
From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Message-Id: <E1FJmFe-00006W-00@skye.ra.phy.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I started subdividing the _TMP method, and found that

hangs: -AC0 (as reported in the last email)
okay:  -AC0-TMP (also in last email)

but

okay: -AC0-one line of TMP, by which I mean getting rid of the 
EC0.UPDT() line below:

            Method (_TMP, 0, NotSerialized)
            {
                \_SB.PCI0.ISA0.EC0.UPDT ()
                Store (\_SB.PCI0.ISA0.EC0.TMP0, Local0)
                If (LGreater (Local0, 0x0AAC))
                {
                    Return (Local0)
                }
                Else
                {
                    Return (0x0BB8)
                }
            }

So that's a small change in which having a line means the hang
happens, and not having the line means it goes away.

By the way, I just checked -AC0-TMP and it was okay (no hang).  That
data point is consistent with TMP & (PSV | AC0).

> I found the common code in _PSV and _AC0
>    Store (DerefOf (Index (DerefOf (MODP (0x01)), Local1)), Local0)
> Could you just comment out that?

I will try that right now (leaving TMP as in the vanilla DSDT).

-Sanjoy

`Never underestimate the evil of which men of power are capable.'
         --Bertrand Russell, _War Crimes in Vietnam_, chapter 1.
