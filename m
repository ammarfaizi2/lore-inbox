Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262095AbTIFDhZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 23:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262653AbTIFDhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 23:37:20 -0400
Received: from citrine.spiritone.com ([216.99.193.133]:40365 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S262095AbTIFDhS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 23:37:18 -0400
Date: Fri, 05 Sep 2003 20:36:32 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Nick Piggin <piggin@cyberone.com.au>
cc: Mike Fedyk <mfedyk@matchmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Nick's scheduler policy v12
Message-ID: <6470000.1062819391@[10.10.2.4]>
In-Reply-To: <3F5935EB.4000005@cyberone.com.au>
References: <3F58CE6D.2040000@cyberone.com.au> <195560000.1062788044@flay> <20030905202232.GD19041@matchmail.com> <207340000.1062793164@flay> <3F5935EB.4000005@cyberone.com.au>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yep, as Mike mentioned, renicing X causes it to get bigger
> timeslices with the stock scheduler. If you had 2 nice -20 processes,
> they would each get a timeslice of 200ms, so you're harming their
> latency.

Well, if I can be naive for a second (and I'll fully admit I don't
understand the implications of this), there are two things here - 
either give it more of a timeslice (bandwidth increase), or make it 
more interactive (latency increase). Those two seem to be separable,
but we don't bother. Seems better to pass a more subtle hint to the
scheduler that this is interactive - nice seems like a very large
brick between the eyes.

>> There may be some more details around this, and I'd love to hear them,
>> but I fundmantally believe that explitit fiddling with particular
>> processes because we believe they're somehow magic is wrong (and so
>> does Linus, from previous discussions).
> 
> Well it would be nice if someone could find out how to do it, but I
> think that if we want X to be able to get 80% CPU when 2 other CPU hogs
> are running, you have to renice it.

OK. So you renice it ... then your two cpu jobs exit, and you kick off
xmms. Every time you waggle a window, X will steal the cpu back from
xmms, and it'll stall, surely? That's what seemed to happen before.
I don't see how you can fix anything by doing static priority alterations
(eg nice), because the workload changes.

I'm probably missing something ... feel free to slap me ;-)

M.

