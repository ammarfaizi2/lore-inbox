Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271329AbRIYVl5>; Tue, 25 Sep 2001 17:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269641AbRIYVls>; Tue, 25 Sep 2001 17:41:48 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:16314 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S271329AbRIYVli>; Tue, 25 Sep 2001 17:41:38 -0400
Date: Tue, 25 Sep 2001 17:42:04 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Chris Newton <newton@unb.ca>
Cc: Andrew Morton <akpm@zip.com.au>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: excessive interrupts on network cards
Message-ID: <20010925174203.C19494@redhat.com>
In-Reply-To: <3BB11992@webmail1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BB11992@webmail1>; from newton@unb.ca on Tue, Sep 25, 2001 at 06:38:31PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2001 at 06:38:31PM -0300, Chris Newton wrote:
> Yea, it is a single port card... I had meant to mention that in the email I 
> sent out...  ie: that it wasn't reporting correctly... but, I didnt really 
> think it was related, since the eepro was doing the same thing.
> 
>   As for comparing with ifconfig, I ran 'watch 1 ifconfig -a', and sure 
> enough, I have about ~7000-7500 packets coming in right now.  And, the 
> 'procinfo -D', reports ~21000-22000 interrupts per second.

This is heavily dependant on the interrupt mitigation features that a card  
has.  At least for the ns83820 driver, I'm testing a technique where the 
driver essentially switches to polled mode once the interrupt load goes 
above a certain threshold, thereby limiting the load to ~2500 irq/sec.  
Combined with carefully placed data prefetching, I'm seeing a huge increase 
in performance.  Of course, this comes at the expense of latency.

		-ben
