Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265540AbUGGWTz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265540AbUGGWTz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 18:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265544AbUGGWTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 18:19:55 -0400
Received: from meg.vosn.net ([209.197.254.7]:39851 "EHLO meg.vosn.net")
	by vger.kernel.org with ESMTP id S265540AbUGGWTw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 18:19:52 -0400
Message-ID: <001801c46470$94116820$0a01a8c0@jwrdesktop>
From: "John W. Ross" <programming@johnwross.com>
To: <linux-kernel@vger.kernel.org>
Subject: Increasing IDE Channels
Date: Wed, 7 Jul 2004 15:20:15 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1409
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - meg.vosn.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - johnwross.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I've spent several days working to increase the number of IDE channels above
the 10 allowed in the kernel.  Ideally I would like to raise the limit to
14. (to accomidate the 2 interfaces on the motherboard and 6 cheap dual
channel ide cards) Although I've found some references to others who would
like to do this, I can find noone who has actually both accomplished the
task and mentioned their success.  I decided to start small and try to get
up to 12.  To do this I:

Changed ide.h:

IDE_NR_PORTS  (10)
to
IDE_NR_PORTS  (12)

In major.h I added:

#define IDE10_MAJOR     240
#define IDE11_MAJOR     241

in ide.c I changed

static const u8 ide_hwif_to_major[] = { IDE0_MAJOR, IDE1_MAJOR,
     IDE2_MAJOR, IDE3_MAJOR,
     IDE4_MAJOR, IDE5_MAJOR,
     IDE6_MAJOR, IDE7_MAJOR,
     IDE8_MAJOR, IDE9_MAJOR };

to :

static const u8 ide_hwif_to_major[] = { IDE0_MAJOR, IDE1_MAJOR,
     IDE2_MAJOR, IDE3_MAJOR,
     IDE4_MAJOR, IDE5_MAJOR,
     IDE6_MAJOR, IDE7_MAJOR,
     IDE8_MAJOR, IDE9_MAJOR,
     IDE10_MAJOR, IDE11_MAJOR)

This was on a clean 2.6.7 kernel download.  I then ran menuconfig and the
only change I made was to select the processor as AMD Athlon.  After
compiling I still get the "too many ide interfaces, no room in table".

I'm certianly no kernel hacker at heart, so I may be trying to do the
impossible/impractical.

1.) Could someone please explain why there is a limit of 10 interfaces (is
this something that I shouldn't even try)?
2.)What did I miss on moving to 12?
3.) I could understand a limit of 12, as hda, hdb, hdc... hdw, hdx, would
only allow a possible 13th interface, but at 14 you would totally exhaust
the alphabet, but is that still relevant with the newer method of
enumerating partitions?
4.) Is there a kernel patch available already that I'm ignorant of?
5.) Are there references that I should review elsewhere?
6.) I generally use Mandrake but if there is another distribution patched to
allow additional interfaces pray tell.

Thank you for you time reading this, and for any help you may be able to
provide.

John

To respond, just click reply.  The spammers will get the address regardless
of anything I do to prevent it!



