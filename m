Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750725AbWJLUdV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbWJLUdV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 16:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbWJLUdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 16:33:21 -0400
Received: from gw.goop.org ([64.81.55.164]:47853 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1750725AbWJLUdU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 16:33:20 -0400
Message-ID: <452EA700.9060009@goop.org>
Date: Thu, 12 Oct 2006 13:35:12 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20061004)
MIME-Version: 1.0
To: John Richard Moser <nigelenki@comcast.net>
CC: Chris Friesen <cfriesen@nortel.com>, linux-kernel@vger.kernel.org
Subject: Re: Can context switches be faster?
References: <452E62F8.5010402@comcast.net> <452E9E47.8070306@nortel.com> <452EA441.6070703@comcast.net>
In-Reply-To: <452EA441.6070703@comcast.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Richard Moser wrote:
> That's a load more descriptive :D
>
> 0.890 uS, 0.556uS/cycle, that's barely 2 cycles you know.  (Pentium M)
> PPC performs similarly, 1 cycle should be about 1uS.
>   

No, you're a factor of 1000 off - these numbers show the context switch 
is around 1600-75000 cycles.  And that doesn't really tell the whole 
story: if caches/TLB get flushed on context switch, then the newly 
switched-to task will bear the cost of having cold caches, which isn't 
visible in the raw context switch time.

But modern x86 processors have a very quick context switch time, and I 
don't think there's much room for improvement aside from 
micro-optimisations (though that might change if the architecture grows 
a way to avoid flushing the TLB on switch).

    J
