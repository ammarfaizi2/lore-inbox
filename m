Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263992AbUDVMok@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263992AbUDVMok (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 08:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264015AbUDVMok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 08:44:40 -0400
Received: from mtagate6.de.ibm.com ([195.212.29.155]:15049 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP id S263992AbUDVMoi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 08:44:38 -0400
Subject: Re: [PATCH] s390 (9/9): no timer interrupts in idle.
To: Arjan van de Ven <arjanv@redhat.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.11   July 24, 2002
Message-ID: <OF8486E763.A98E66AA-ONC1256E7E.00452A1A-C1256E7E.0045F93D@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Thu, 22 Apr 2004 14:44:17 +0200
X-MIMETrack: Serialize by Router on D12ML062/12/M/IBM(Release 6.0.2CF2|July 23, 2003) at
 22/04/2004 14:44:18
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





> xtime is easy, that's interpolated anyway afaics. Jiffies would either
just
> jump some, which code needs to deal with anyway given that preempt can do
> the same, or would become an approximated thing as well based on the
other
> time keeping sources in the system.

Unluckily no. xtime is not easy because the network stack uses this for
time stamps at several locations. Living in the past and time stamps for
network packets don't go together, do they?

> calculating the load can be a real timer for sure (which would cause an irq
> at that time), cpu limits we can do at the end of timeslice (and set the
> timeslice such that the limits won't be exceeded).

Nod, the load could easily be done with an add_timer and we can live with a
small inaccuracy as far as the cpu limits are concerned.

By the way I am planning to do a BOFS at the OLS in july where I'd like
to discuss exactly this kind of questions. Any chance that you'd be there
too?

blue skies,
   Martin

