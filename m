Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262881AbVGNWnu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262881AbVGNWnu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 18:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263172AbVGNWlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 18:41:39 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:56195 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S263159AbVGNWjt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 18:39:49 -0400
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Arjan van de Ven <arjan@infradead.org>,
       Lee Revell <rlrevell@joe-job.com>,
       dean gaudet <dean-list-linux-kernel@arctic.org>,
       Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@osdl.org>,
       "Brown, Len" <len.brown@intel.com>, dtor_core@ameritech.net,
       david.lang@digitalinsight.com, davidsen@tmr.com, kernel@kolivas.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mbligh@mbligh.org, diegocg@gmail.com, azarah@nosferatu.za.org,
       christoph@lameter.com
In-Reply-To: <Pine.LNX.4.58.0507140933150.19183@g5.osdl.org>
References: <d120d50005071312322b5d4bff@mail.gmail.com>
	 <1121286258.4435.98.camel@mindpipe> <20050713134857.354e697c.akpm@osdl.org>
	 <20050713211650.GA12127@taniwha.stupidest.org>
	 <Pine.LNX.4.63.0507131639130.13193@twinlark.arctic.org>
	 <20050714005106.GA16085@taniwha.stupidest.org>
	 <Pine.LNX.4.63.0507131810430.13193@twinlark.arctic.org>
	 <1121304825.4435.126.camel@mindpipe>
	 <Pine.LNX.4.58.0507131847000.17536@g5.osdl.org>
	 <1121326938.3967.12.camel@laptopd505.fenrus.org>
	 <20050714121340.GA1072@ucw.cz>
	 <Pine.LNX.4.58.0507140933150.19183@g5.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1121380637.3747.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 14 Jul 2005 23:37:20 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> just doesn't realize that the latter is a bit more complicated exactly 
> because the latter is a hell of a lot more POWERFUL. Trying to get rid of 
> jiffies for some religious reason is _stupid_.

Getting rid of jiffies in its current form is a huge win for very
non-religious reasons. Jiffies is expensive in power management and
virtualisation because you have to maintain it.

Swap jiffies for jiffies() and the world gets a lot better. 

In actual fact you also want to fix users of

	while(time_before(foo, jiffies)) { whack(mole); }

to become

	init_timeout(&timeout);
	timeout.expires = jiffies + n
	add_timeout(&timeout);
	while(!timeout_expired(&timeout)) {}

Which is a trivial wrapper around timers as we have them now


