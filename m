Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270567AbRHITkr>; Thu, 9 Aug 2001 15:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270568AbRHITkh>; Thu, 9 Aug 2001 15:40:37 -0400
Received: from alfik.ms.mff.cuni.cz ([195.113.19.71]:25870 "EHLO
	alfik.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S270567AbRHITkW>; Thu, 9 Aug 2001 15:40:22 -0400
Message-ID: <20010809212730.C25162@bug.ucw.cz>
Date: Thu, 9 Aug 2001 21:27:30 +0200
From: Pavel Machek <pavel@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Dirk W. Steinberg" <dws@dirksteinberg.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Swapping for diskless nodes
In-Reply-To: <no.id> <E15Ulnx-0006zZ-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <E15Ulnx-0006zZ-00@the-village.bc.nu>; from Alan Cox on Thu, Aug 09, 2001 at 10:08:37AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > what is the best/recommended way to do remote swapping via the network
> > for diskless workstations or compute nodes in clusters in Linux 2.4?=20
> > Last time i checked was linux 2.2, and there were some races related=20
> > to network swapping back then. Has this been fixed for 2.4?
> 
> The best answer probably is "don't". Networks are high latency things for
> paging and paging is latency sensitive. If performance is not an issue then
> the nbd driver ought to work. You may need to check it uses the
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Alan, are you saying it should work reliably?

> right
> GFP_ levels to avoid deadlocks and you might need to up the amount of atomic
> pool memory. Hopefully other hacks arent needed

There still may be some deadlocks. Swapping over nbd seemed to work
for me... until I used mem=8M and did two ping -f's to the victim.

Issue is that you not only need to check nbd, you need to check whole
network layer, too.
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
