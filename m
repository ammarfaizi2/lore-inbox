Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262767AbVCXKFv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262767AbVCXKFv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 05:05:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263078AbVCXKFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 05:05:51 -0500
Received: from smtp-out.tiscali.no ([213.142.64.144]:48658 "EHLO
	smtp-out.tiscali.no") by vger.kernel.org with ESMTP id S262767AbVCXKFk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 05:05:40 -0500
Subject: Re: forkbombing Linux distributions
From: Natanael Copa <mlists@tanael.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0503240805110.19487@yvahk01.tjqt.qr>
References: <e0716e9f05032019064c7b1cec@mail.gmail.com>
	 <20050322112628.GA18256@roll>
	 <Pine.LNX.4.61.0503221247450.5858@yvahk01.tjqt.qr>
	 <20050322124812.GB18256@roll> <20050322125025.GA9038@roll>
	 <9cde8bff050323025663637241@mail.gmail.com> <1111581459.27969.36.camel@nc>
	 <9cde8bff05032305044f55acf3@mail.gmail.com> <1111586058.27969.72.camel@nc>
	 <Pine.LNX.4.61.0503231543030.10048@yvahk01.tjqt.qr>
	 <1111590294.27969.114.camel@nc>
	 <Pine.LNX.4.61.0503240805110.19487@yvahk01.tjqt.qr>
Content-Type: text/plain
Date: Thu, 24 Mar 2005 11:05:38 +0100
Message-Id: <1111658739.22122.17.camel@nc>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-24 at 08:07 +0100, Jan Engelhardt wrote:
> >> >brings down almost all linux distro's while other *nixes survives.
> >> 
> >> Let's see if this can be confirmed.
> >
> >open/free/netbsd survives. I guess OSX does too.
> 
> Confirmed. My OpenBSD install copes very well with forkbombs.
> However, I _was able_ to spawn a lot of shells by default.
> The essence is that the number of processes/threads within
> a _session group_ (correct word?) is limited. That way, you can
> start a ton of "/bin/sh"s from one another, i.e.:
> 
>  \__ login jengelh
>      \__ /bin/sh
>          \__ /bin/sh
>              \__ /bin/sh
> ...
> 
> So I think that if you add a setsid() to your forkbomb,
> you could once again be able to bring a system - BSD this time - down.

I seriously doubt that. Try raising your maxproc setting (sysctl
kern.maxproc?) to something insane and try bombing again.

I tried to bring the box down by raising the limit to something similar
linux default and run the classic ":() { :|:& };:" However, the bomb was
stopped by maximum number of pipes and BSD survived.

If you don't hit the maximum number of processes you will hit another
limit.

--
Natanael Copa


