Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161097AbWGIGNV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161097AbWGIGNV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 02:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161098AbWGIGNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 02:13:21 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:29421
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1161097AbWGIGNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 02:13:20 -0400
Date: Sat, 08 Jul 2006 23:13:51 -0700 (PDT)
Message-Id: <20060708.231351.43413202.davem@davemloft.net>
To: torvalds@osdl.org
Cc: kaos@ocs.com.au, ak@suse.de, jh@suse.cz, rth@redhat.com, mingo@elte.hu,
       akpm@osdl.org, linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [patch] spinlocks: remove 'volatile' 
From: David Miller <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.64.0607082041400.5623@g5.osdl.org>
References: <31410.1152414469@ocs3.ocs.com.au>
	<Pine.LNX.4.64.0607082041400.5623@g5.osdl.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@osdl.org>
Date: Sat, 8 Jul 2006 20:58:37 -0700 (PDT)

> We can certainly write
> 
> 	...
> 	:"=m" (*ptr)
> 	:"m" (*ptr)
> 	...
> 
> instead of the much simpler
> 
> 	:"+m" (*ptr)
> 
> but we've been using that "+m" format for a long time already (and I 
> _think_ we did so at the suggestion of gcc people), and it would be much 
> better if the gcc documentation was just fixed here.

I honestly don't know why that language is there about '+' saying to
only use it when the constraints allow a register.  Perhaps there are
some implications for reload.
