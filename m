Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283627AbRK3Ll5>; Fri, 30 Nov 2001 06:41:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283625AbRK3Llt>; Fri, 30 Nov 2001 06:41:49 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:26383 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S283624AbRK3Llg>; Fri, 30 Nov 2001 06:41:36 -0500
Subject: Re: kapm-idled no longer idling CPU?
To: dglidden@illusionary.com (Derek Glidden)
Date: Fri, 30 Nov 2001 11:50:08 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C06855F.22AD79C4@illusionary.com> from "Derek Glidden" at Nov 29, 2001 01:58:39 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E169mBE-0003Fw-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> application that uses more than very minor system resources is running,
> (i.e. mozilla, netscape, xemacs, apache, Tomcat, just to name a few
> common ones I've seen this behaviour with) kapm-idled no longer receives
> scheduling time from what I can tell and I assume that means my CPU is
> never getting idled when nothing is scheduled.

kapm_idled will get scheduling time when there is nothing else to run, 
whether it wants it or is using it is more of the question.

> reporting its time incorrectly since my laptop has gone from about 2-1/2
> hours of battery life in early 2.4 versions to less than 1 hour of
> battery life under the same conditions for recent kernels.  Plus, if I

Stick some printk calls in so you can see a count of when the thread runs
and also see when it decides to ask the BIOS to do idling (and also what
then occurs).

I fixed one case recently where we would spin calling the bios all the time
when instead of pausing the bios replied that it had slowed down the
processor. That however was post 2.4.9 so I dont think its related.

Alan
