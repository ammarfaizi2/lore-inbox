Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262710AbTDIEPy (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 00:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262711AbTDIEPy (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 00:15:54 -0400
Received: from [12.47.58.221] ([12.47.58.221]:48909 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262710AbTDIEPx (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 00:15:53 -0400
Date: Tue, 8 Apr 2003 21:27:49 -0700
From: Andrew Morton <akpm@digeo.com>
To: Roland Dreier <roland@topspin.com>
Cc: spstarr@sh0n.net, rml@tech9.net, rmk@arm.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [BUG][2.5.66bk9+] - tty hangings - patches, dmesg & sysctl+T
 info
Message-Id: <20030408212749.56a8737c.akpm@digeo.com>
In-Reply-To: <524r58nw4e.fsf@topspin.com>
References: <003001c2fe3d$6eab1080$030aa8c0@unknown>
	<524r58nw4e.fsf@topspin.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Apr 2003 04:27:27.0246 (UTC) FILETIME=[538E2AE0:01C2FE50]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier <roland@topspin.com> wrote:
>
> Andrew, I've never seen a reply from you about this, can you tell me
> if I'm missing something here?
> 

No, I agree.  I don't think pending delayed work should contribute to the
count at all.

If someone wants to synchronise with the workqueue system they should cancel
any delayed work which they own (via cancel_scheduled_work) and then wait on
any currently-queued works via flush_scheduled_work().

So flush_scheduled_work() only needs to care about currently-queued works,
not the ones which are pending a timer event.

And flush_scheduled_work() needs to be taught to not lock up if someone keeps
re-adding work.

That's what my patch did (I think; it was a quicky)


