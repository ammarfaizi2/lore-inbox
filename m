Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266553AbSKOTd3>; Fri, 15 Nov 2002 14:33:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266578AbSKOTd3>; Fri, 15 Nov 2002 14:33:29 -0500
Received: from khms.westfalen.de ([62.153.201.243]:60051 "EHLO
	khms.westfalen.de") by vger.kernel.org with ESMTP
	id <S266553AbSKOTd2>; Fri, 15 Nov 2002 14:33:28 -0500
Date: 15 Nov 2002 20:26:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <8$tgwO4mw-B@khms.westfalen.de>
In-Reply-To: <20021115043827.A20764@wotan.suse.de>
Subject: Re: module mess in -CURRENT
X-Mailer: CrossPoint v3.12d.kh10 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
References: <Pine.LNX.4.44.0211141634060.12390-100000@penguin.transmeta.com> <20021115002730.GA22547@bjl1.asuk.net> <Pine.LNX.4.44.0211141634060.12390-100000@penguin.transmeta.com> <20021115043827.A20764@wotan.suse.de>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ak@suse.de (Andi Kleen)  wrote on 15.11.02 in <20021115043827.A20764@wotan.suse.de>:

> > and then have the timer clear "xtime_count" every time it updates it.
>
> Problem is that you cannot easily synchronize such a monotonously increasing
> timer in a network. But make needs synchronized times.

That's really a make problem. It gets much worse when you count in times  
going backwards because you restore a file from backup, or whatever.

What I'd really like make to do - but it can't with the current design -  
is to note the exact time stamp of each dependency when creating a target,  
and when reconsidering that target, finding out if any of those time  
stamps have changed in any way (and, while we're at it, probably check the  
size as well). *Changed since last time*, not younger than the target.

But of course to do that, you need a persistent repository for those time  
stamps - which, I think, kbuild-Owen does.

If you think about the more tricky things to do with make, this is almost  
always what you would need to make a solution much easier.

Take network time shift, for example. Once you no longer need a younger- 
older relation, that time shift is actually completely irrelevant!

One of these days, when I have lots of time (as if!) ...

MfG Kai
