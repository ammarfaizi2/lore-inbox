Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750816AbWD2V6V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbWD2V6V (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Apr 2006 17:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbWD2V6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Apr 2006 17:58:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62384 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750816AbWD2V6V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Apr 2006 17:58:21 -0400
Date: Sat, 29 Apr 2006 14:58:16 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Stephen Hemminger <shemminger@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: better leve triggered IRQ management needed
In-Reply-To: <1146345911.3302.36.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0604291453220.3701@g5.osdl.org>
References: <20060424114105.113eecac@localhost.localdomain>
 <1146345911.3302.36.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 29 Apr 2006, Alan Cox wrote:
> 
> Trying to guess the current IRQ level v edge on a PC is very hard.
> Trying to set it correctly from the driver is rather easier.

I disagree. It's not any easier at all.

On PC's (x86 and x86-64) we actually already set the ELCR as well as we 
can (look for "eisa_set_level_irq()"). And a driver _literally_ cannot 
change it from the system value, because of the polarity confusion.

In the other cases (IO-APIC) we usually have it level, but when we have it 
marked as an edge, there is almost always a real reason for that too (ie 
legacy interrupt, it really _is_ edge-high, not level-low).

		Linus
