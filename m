Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262408AbVC2H10@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262408AbVC2H10 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 02:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262472AbVC2HZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 02:25:32 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:10451 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262476AbVC2HHU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 02:07:20 -0500
Date: Tue, 29 Mar 2005 09:06:51 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Pekka Enberg <penberg@gmail.com>
cc: Lee Revell <rlrevell@joe-job.com>, Dave Jones <davej@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       penberg@cs.helsinki.fi
Subject: Re: [PATCH] no need to check for NULL before calling kfree() -fs/ext2/
In-Reply-To: <84144f02050328223017b17746@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0503290903530.13383@yvahk01.tjqt.qr>
References: <Pine.LNX.4.62.0503252307010.2498@dragon.hyggekrogen.localhost>
  <1111825958.6293.28.camel@laptopd505.fenrus.org> 
 <Pine.LNX.4.61.0503261811001.9945@chaos.analogic.com> 
 <Pine.LNX.4.62.0503270044350.3719@dragon.hyggekrogen.localhost> 
 <1111881955.957.11.camel@mindpipe>  <Pine.LNX.4.62.0503271246420.2443@dragon.hyggekrogen.localhost>
  <20050327065655.6474d5d6.pj@engr.sgi.com>  <Pine.LNX.4.61.0503271708350.20909@yvahk01.tjqt.qr>
  <20050327174026.GA708@redhat.com> <1112064777.19014.17.camel@mindpipe>
 <84144f02050328223017b17746@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I see kfree used in several hot paths.  Check out
>> this /proc/latency_trace excerpt:
>
>Yes, but is the pointer being free'd NULL most of the time?

"[...]In general, you should prefer to use actual profile feedback for this 
(`-fprofile-arcs'), as programmers are NOTORIOUSLY BAD AT PREDICTING how 
their programs actually perform." --gcc info pages.

>The optimization does not help if you are releasing actual memory.

It does not turn the real case (releasing memory) worse, but just improves the 
unreal case (releasing NULL).



Jan Engelhardt
-- 
No TOFU for me, please.
