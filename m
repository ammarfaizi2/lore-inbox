Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262721AbTDIEtj (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 00:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262739AbTDIEtj (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 00:49:39 -0400
Received: from CPEdeadbeef0000-CM400026342639.cpe.net.cable.rogers.com ([24.114.185.204]:1028
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id S262721AbTDIEth (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 00:49:37 -0400
From: "Shawn Starr" <spstarr@sh0n.net>
To: "'Roland Dreier'" <roland@topspin.com>, "'Andrew Morton'" <akpm@digeo.com>
Cc: <rml@tech9.net>, <rmk@arm.linux.org.uk>, <linux-kernel@vger.kernel.org>
Subject: RE: [BUG][2.5.66bk9+] - tty hangings - patches, dmesg & sysctl+T info
Date: Wed, 9 Apr 2003 01:01:31 -0400
Message-ID: <000001c2fe55$16edbe70$030aa8c0@unknown>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
In-Reply-To: <52vfxomfwa.fsf@topspin.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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



