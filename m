Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262726AbTDIEks (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 00:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262728AbTDIEks (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 00:40:48 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:48029 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262726AbTDIEkq (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 00:40:46 -0400
To: Andrew Morton <akpm@digeo.com>
Cc: spstarr@sh0n.net, rml@tech9.net, rmk@arm.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [BUG][2.5.66bk9+] - tty hangings - patches, dmesg & sysctl+T info
References: <003001c2fe3d$6eab1080$030aa8c0@unknown>
	<524r58nw4e.fsf@topspin.com> <20030408212749.56a8737c.akpm@digeo.com>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 08 Apr 2003 21:52:21 -0700
In-Reply-To: <20030408212749.56a8737c.akpm@digeo.com>
Message-ID: <52vfxomfwa.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 09 Apr 2003 04:52:24.0352 (UTC) FILETIME=[CFE66A00:01C2FE53]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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


