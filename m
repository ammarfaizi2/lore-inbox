Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261480AbVGNR2K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261480AbVGNR2K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 13:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261804AbVGNR2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 13:28:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9674 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261480AbVGNR0j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 13:26:39 -0400
Date: Thu, 14 Jul 2005 10:24:52 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Chris Friesen <cfriesen@nortel.com>
cc: Vojtech Pavlik <vojtech@suse.cz>, Arjan van de Ven <arjan@infradead.org>,
       Lee Revell <rlrevell@joe-job.com>,
       dean gaudet <dean-list-linux-kernel@arctic.org>,
       Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@osdl.org>,
       "Brown, Len" <len.brown@intel.com>, dtor_core@ameritech.net,
       david.lang@digitalinsight.com, davidsen@tmr.com, kernel@kolivas.org,
       linux-kernel@vger.kernel.org, mbligh@mbligh.org, diegocg@gmail.com,
       azarah@nosferatu.za.org, christoph@lameter.com
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
In-Reply-To: <42D69C6F.9030301@nortel.com>
Message-ID: <Pine.LNX.4.58.0507141022070.19183@g5.osdl.org>
References: <d120d50005071312322b5d4bff@mail.gmail.com> <1121286258.4435.98.camel@mindpipe>
 <20050713134857.354e697c.akpm@osdl.org> <20050713211650.GA12127@taniwha.stupidest.org>
 <Pine.LNX.4.63.0507131639130.13193@twinlark.arctic.org>
 <20050714005106.GA16085@taniwha.stupidest.org>
 <Pine.LNX.4.63.0507131810430.13193@twinlark.arctic.org> <1121304825.4435.126.camel@mindpipe>
 <Pine.LNX.4.58.0507131847000.17536@g5.osdl.org> <1121326938.3967.12.camel@laptopd505.fenrus.org>
 <20050714121340.GA1072@ucw.cz> <Pine.LNX.4.58.0507140933150.19183@g5.osdl.org>
 <42D69C6F.9030301@nortel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 14 Jul 2005, Chris Friesen wrote:
> 
> But if all I really want is to sleep for 20ms, what does the additional 
> power actually buy me?

If you _only_ want to sleep for 20ms, it doesn't buy you anything.

But the sleep is often part of a bigger picture, where the 20ms might be 
part of a bigger loop that wants to run for at most a second, after which 
it will error out.

At which point it's not just about sleeping 20ms any more. 

I'm not saying that we should get rid of msleep(). I'm saying that anybody 
who thinks the jiffies-based stuff should always be rewritten as msleep() 
simply doesn't know what the hell he is talking about. At ALL.

Jiffies are here to stay, and they are here to stay for some very very 
fundamental reasons. If you hear somebody arguing for removing jiffies, 
you should piss in their general direction, and realize that they don't 
know what they are talking about.

		Linus
