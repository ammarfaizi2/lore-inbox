Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267920AbTBKXfi>; Tue, 11 Feb 2003 18:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267922AbTBKXfi>; Tue, 11 Feb 2003 18:35:38 -0500
Received: from packet.digeo.com ([12.110.80.53]:41658 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267920AbTBKXfi>;
	Tue, 11 Feb 2003 18:35:38 -0500
Date: Tue, 11 Feb 2003 15:44:13 -0800
From: Andrew Morton <akpm@digeo.com>
To: root@chaos.analogic.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Panic `cat /proc/ioports`
Message-Id: <20030211154413.19a172f4.akpm@digeo.com>
In-Reply-To: <Pine.LNX.3.95.1030211155003.2868A-100000@chaos.analogic.com>
References: <Pine.LNX.3.95.1030211155003.2868A-100000@chaos.analogic.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Feb 2003 23:45:14.0788 (UTC) FILETIME=[9FE41E40:01C2D227]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" <root@chaos.analogic.com> wrote:
>
> Linux version 2.4.18, after it runs for a few days, will panic
> if I do `cat /proc/ioports`. Has this been reported/fixed in
> later versions?
> 
> : Unable to handle kernel paging request at virtual address d48e2fa0 

This means that some driver which was previously loaded forgot to do a
release_region().  Later, the /proc code tries to read stuff from within the
driver which isn't there any more and oopses.

So you need to look at whatever drivers were rmmodded before you did the read
from /proc/ioports.
