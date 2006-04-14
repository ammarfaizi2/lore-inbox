Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751436AbWDNVqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436AbWDNVqE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 17:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751438AbWDNVqD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 17:46:03 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:26838 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751436AbWDNVqB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 17:46:01 -0400
Date: Fri, 14 Apr 2006 23:45:56 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
cc: Ram Gupta <ram.gupta5@gmail.com>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       linux mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: select takes too much time
In-Reply-To: <Pine.LNX.4.61.0604141056120.11151@chaos.analogic.com>
Message-ID: <Pine.LNX.4.61.0604142344000.4238@yvahk01.tjqt.qr>
References: <728201270604130801l377d7285y531133ee9ee56e8c@mail.gmail.com>
 <443E9A17.4070805@stud.feec.vutbr.cz> <728201270604131251h5296dd41o7d0e0dd8f2f1ac63@mail.gmail.com>
 <Pine.LNX.4.61.0604131701030.7732@chaos.analogic.com> <443EC09C.2050409@stud.feec.vutbr.cz>
 <728201270604140754g7bf955d6y5e06bc5ce4f86c7b@mail.gmail.com>
 <Pine.LNX.4.61.0604141056120.11151@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> So it seems that the only solution to return back right away after
>> timeout is to play around with the scheduler or put the process doing
>> select at the front of the queue so it get a chance to run first.
>> Is there any other better way to do it?
>>
> 	nice(-19);

	sched_setscheduler(0, SCHED_FIFO,
		(struct sched_param){.sched_priority = 99});

That should probably beat anything, with the exception of IRQs.

Jan Engelhardt
-- 
