Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264383AbTDPNzz (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 09:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264388AbTDPNzz 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 09:55:55 -0400
Received: from zero.aec.at ([193.170.194.10]:45316 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S264383AbTDPNzx 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 09:55:53 -0400
Date: Wed, 16 Apr 2003 16:07:15 +0200
From: Andi Kleen <ak@muc.de>
To: "David S. Miller" <davem@redhat.com>
Cc: ak@muc.de, akpm@digeo.com, linux-kernel@vger.kernel.org, anton@samba.org,
       schwidefsky@de.ibm.com, davidm@hpl.hp.com, matthew@wil.cx,
       ralf@linux-mips.org, rth@redhat.com
Subject: Re: Reduce struct page by 8 bytes on 64bit
Message-ID: <20030416140715.GA2159@averell>
References: <20030415112430.GA21072@averell> <20030416.054521.26525548.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030416.054521.26525548.davem@redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 16, 2003 at 02:45:21PM +0200, David S. Miller wrote:
>    From: Andi Kleen <ak@muc.de>
>    Date: Tue, 15 Apr 2003 13:24:30 +0200
>    
>    I worked around this by declaring a new data type atomic_bitmask32
>    with matching set_bit32/clear_bit32 etc. interfaces. Currently only 
>    on x86-64 aomitc_bitmask32 is defined to unsigned, everybody else
>    still uses unsigned long. The other 64bit architectures can define it to
>    unsigned too if they can confirm that it's ok to do.
> 
> I have no problem with this.
> 
> If you are clever, you can define a generic version even for the
> "unsigned long" 64-bit platforms.  It's left as an exercise to
> the reader :-)

How so? Of course I could write an generic set_bit32, but the question
is if these bit operations would be still atomic on SMP and not conflict with
fields occuping the same 8 byte slot. I remember you flaming someone 
some time ago because he used set_bit in an atomic fashion on a type smaller
than unsigned long for example.

-Andi
