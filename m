Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261719AbVE3Tlr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261719AbVE3Tlr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 15:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbVE3Tla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 15:41:30 -0400
Received: from colin.muc.de ([193.149.48.1]:30483 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S261719AbVE3TiZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 15:38:25 -0400
Date: 30 May 2005 21:38:23 +0200
Date: Mon, 30 May 2005 21:38:23 +0200
From: Andi Kleen <ak@muc.de>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] x86-64: Use SSE for copy_page and clear_page
Message-ID: <20050530193823.GD25794@muc.de>
References: <20050530181626.GA10212@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050530181626.GA10212@kvack.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The SSE clear page fuction is almost twice as fast as the kernel's 
> current clear_page, while the copy_page implementation is roughly a 
> third faster.  This is likely due to the fact that SSE instructions 
> can keep the 256 bit wide L2 cache bus at a higher utilisation than 
> 64 bit movs are able to.  Comments?

Any use of write combining is wrong here because it forces
the destination out of cache, which causes performance issues later on. 
Believe me we went through this years ago.

If you can code up a better function for P4 that does not use
write combining I would be happy to add. I never tuned the functions
for P4. 

One simple experiment would be to just test if P4 likes the
simple rep ; movsq / rep ; stosq loops and enable them.

-Andi
