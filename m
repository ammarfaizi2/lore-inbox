Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262197AbVFUQr3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262197AbVFUQr3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 12:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262175AbVFUQoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 12:44:34 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:1036 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S262171AbVFUQoE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 12:44:04 -0400
Date: Tue, 21 Jun 2005 17:43:53 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Nishanth Aravamudan <nacc@us.ibm.com>
Cc: Domen Puncer <domen@coderock.org>, axboe@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 04/12] block/xd: replace schedule_timeout() with msleep()
In-Reply-To: <20050621161452.GA4175@us.ibm.com>
Message-ID: <Pine.LNX.4.61L.0506211729160.17779@blysk.ds.pg.gda.pl>
References: <20050620215133.675387000@nd47.coderock.org>
 <Pine.LNX.4.61L.0506211233490.9446@blysk.ds.pg.gda.pl>
 <20050621132100.GL3906@nd47.coderock.org> <Pine.LNX.4.61L.0506211451180.9446@blysk.ds.pg.gda.pl>
 <20050621161452.GA4175@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jun 2005, Nishanth Aravamudan wrote:

> schedule_timeout(1) is ambiguous in older/unchanged code since 2.4, as
> it indicated a 10 millisecond sleep then. Now, in 2.6, it indicates a 1
> millisecond sleep (HZ==1000). I am trying to prevent issues like this
> coming up in the future (CONFIG_HZ has hit -mm, e.g.) and msleep() is a
> good way to do so.

 Well, HZ has never been consistent across platforms, e.g. 1024 for 
the Alpha or even within certain platforms, e.g. 128 vs 100 for MIPS for 
different configurations, so relying on jiffies to provide any absolute 
time measurement has always been a misconception.  But assuming all code
authors have failed to observe it is probably going a little bit too far, 
so I'd always assume a given piece of code is correct unless I had reasons 
to decide it does something silly.

> If you are trying to sleep for the shortest amount of time possible (a
> tick), though, then the code is fine, I guess. A comment may be useful,
> though.

 This is obviously the case -- the code waits for a condition of an I/O 
device to change and does not want to hog the CPU for the duration as the 
device is slooow.  I don't think any comment is needed -- it speaks for 
itself: "I'm giving up now, but let me proceed at the next opportunity."

  Maciej
