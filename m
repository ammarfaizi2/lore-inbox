Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263322AbTDLPzu (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 11:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263323AbTDLPzu (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 11:55:50 -0400
Received: from CPEdeadbeef0000-CM400026342639.cpe.net.cable.rogers.com ([24.114.185.204]:8196
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id S263322AbTDLPzt convert rfc822-to-8bit 
	(for <rfc822;linux-kernel@vger.kernel.org>); Sat, 12 Apr 2003 11:55:49 -0400
From: "Shawn Starr" <spstarr@sh0n.net>
To: "'Shawn Starr'" <spstarr@sh0n.net>, "'Roland Dreier'" <roland@topspin.com>,
       "'Andrew Morton'" <akpm@digeo.com>
Cc: <rml@tech9.net>, <rmk@arm.linux.org.uk>, <linux-kernel@vger.kernel.org>
Subject: RE: [BUG][2.5.66bk9+] - tty hangings - patches, dmesg & sysctl+T info
Date: Sat, 12 Apr 2003 12:08:13 -0400
Message-ID: <000301c3010d$b9972980$030aa8c0@unknown>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
In-reply-to: 
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's been three days since I applied the patch. No tty hangings have been
happening. From what I've tested the patch you've given works great. 

Please consider applying to next BK snapshot.

Shawn.

-----Original Message-----
From: Shawn Starr [mailto:spstarr@sh0n.net] 
Sent: Wednesday, April 09, 2003 1:02 AM
To: 'Roland Dreier'; 'Andrew Morton'
Cc: 'rml@tech9.net'; 'rmk@arm.linux.org.uk'; 'linux-kernel@vger.kernel.org'
Subject: RE: [BUG][2.5.66bk9+] - tty hangings - patches, dmesg & sysctl+T
info

Applying akpm's patch now, expect a result in 1-2 days since that's how long
it takes to begin to destabilize :-)

Shawn.


-----Original Message-----
From: Roland Dreier [mailto:roland@topspin.com] 
Sent: Wednesday, April 09, 2003 12:52 AM
To: Andrew Morton
Cc: spstarr@sh0n.net; rml@tech9.net; rmk@arm.linux.org.uk;
linux-kernel@vger.kernel.org
Subject: Re: [BUG][2.5.66bk9+] - tty hangings - patches, dmesg & sysctl+T
info
Importance: High

    Andrew> No, I agree.  I don't think pending delayed work should
    Andrew> contribute to the count at all.

    Andrew> If someone wants to synchronise with the workqueue system
    Andrew> they should cancel any delayed work which they own (via
    Andrew> cancel_scheduled_work) and then wait on any
    Andrew> currently-queued works via flush_scheduled_work().

    Andrew> So flush_scheduled_work() only needs to care about
    Andrew> currently-queued works, not the ones which are pending a
    Andrew> timer event.

    Andrew> And flush_scheduled_work() needs to be taught to not lock
    Andrew> up if someone keeps re-adding work.

Ah, I see... your patch that added insert_sequence and remove_sequence
was intended to apply on top of the patch that adds
cancel_delayed_work().

Please ignore the reply to your patch that I just sent, I
misunderstood what you were trying to do.

Shawn, I think if you add Andrew's most recent patch on top of what
you were running with, your problem should probably be fixed.

Sorry for the extra noise.

 - Roland



