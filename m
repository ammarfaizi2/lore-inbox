Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268336AbUIBUQq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268336AbUIBUQq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 16:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268415AbUIBUON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 16:14:13 -0400
Received: from pegasus.allegientsystems.com ([208.251.178.236]:46603 "EHLO
	pegasus.lawaudit.com") by vger.kernel.org with ESMTP
	id S268929AbUIBUNp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 16:13:45 -0400
Message-ID: <41377EF6.4010902@optonline.net>
Date: Thu, 02 Sep 2004 16:13:42 -0400
From: Nathan Bryant <nbryant@optonline.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040806
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: William Lee Irwin III <wli@holomorphy.com>,
       LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] i386 reduce spurious interrupt noise
References: <20040902192820.GA6427@taniwha.stupidest.org> <20040902193454.GI5492@holomorphy.com> <20040902194739.GA6673@taniwha.stupidest.org>
In-Reply-To: <20040902194739.GA6673@taniwha.stupidest.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
> On Thu, Sep 02, 2004 at 12:34:54PM -0700, William Lee Irwin III wrote:
> 
> 
>>Please check printk_ratelimit().
> 
> 
> I don't want them displayed by default at *all* --- it wakes up the
> monitor on console machines and that's annoying.
> 
> You get about 1 or 2 a day --- rate limiting isn't useful, nor is
> reporting them IMO.

Right, spurious interrupts aren't a big deal on i386. They happen now 
and then with some devices because some hardware timing tolerances are a 
little too tight. See for example sections 5.7.1.3/5.7.4 of the intel 
850 chipset databook 
(http://developer.intel.com/design/chipsets/datashts/29068702.pdf) :

"6. Upon receiving the second internally generated INTA# pulse, the PIC 
returns the interrupt vector. If no interrupt request is present because 
the request was too short in duration, the PIC will return vector 7 from 
the master controller."

"In both the edge-triggered and level-triggered modes, the IRQ inputs 
must remain active until after the falling edge of the first internal 
INTA#. If the IRQ input goes inactive before this time, a default IRQ7 
vector will be returned."

> 
> 
>   --cw
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

