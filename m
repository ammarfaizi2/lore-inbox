Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136867AbREJRbX>; Thu, 10 May 2001 13:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136866AbREJRbN>; Thu, 10 May 2001 13:31:13 -0400
Received: from ns.suse.de ([213.95.15.193]:40717 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S136864AbREJRbC>;
	Thu, 10 May 2001 13:31:02 -0400
Date: Thu, 10 May 2001 19:30:47 +0200
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Ulrich.Weigand@de.ibm.com, linux-kernel@vger.kernel.org,
        schwidefsky@de.ibm.com
Subject: Re: Deadlock in 2.2 sock_alloc_send_skb?
Message-ID: <20010510193047.A22970@gruyere.muc.suse.de>
In-Reply-To: <C1256A48.00451BD1.00@d12mta11.de.ibm.com> <E14xq0v-0004j0-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14xq0v-0004j0-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, May 10, 2001 at 01:57:49PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2001 at 01:57:49PM +0100, Alan Cox wrote:
> > If that happens, and the socket uses GFP_ATOMIC allocation, the while (1)
> > loop in sock_alloc_send_skb() will endlessly spin, without ever calling
> > schedule(), and all the time holding the kernel lock ...
> 
> If the socket is using GFP_ATOMIC allocation it should never loop. That is
> -not-allowed-. 

It is just not clear why any socket should use GFP_ATOMIC. I can understand
it using GFP_BUFFER e.g. for nbd, but GFP_ATOMIC seems to be rather radical
and fragile.

-Andi

