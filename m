Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129597AbQLSWUF>; Tue, 19 Dec 2000 17:20:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129562AbQLSWTz>; Tue, 19 Dec 2000 17:19:55 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:59003
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S129525AbQLSWTi>; Tue, 19 Dec 2000 17:19:38 -0500
Date: Tue, 19 Dec 2000 22:49:04 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: Torben Mathiasen <torben@kernel.dk>
Cc: Francois Romieu <romieu@cogenit.fr>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] Converting drivers/net/rcpci45.c to new PCI API
Message-ID: <20001219224904.D639@jaquet.dk>
In-Reply-To: <20001219004604.B761@jaquet.dk> <20001219095906.A5764@se1.cogenit.fr> <20001219220530.A1643@torben>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20001219220530.A1643@torben>; from torben@kernel.dk on Tue, Dec 19, 2000 at 10:05:30PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 19, 2000 at 10:05:30PM +0100, Torben Mathiasen wrote:
> 
> You should release the irq when the adapter is closed, not removed,
> unless there's some special case that can't be handled if you take
> ints during init.

You seem to be right. I have moved the free_irq to the close function.

> 
> And why would you unregister your netdev after releasing resources?
> 

Instead of doing it before? Beats me :) I merely/blindly copied the 
existing sequence, but after RTFS'ing I changed the sequence to:

	unregister_netdev(dev);
	iounmap((void *)dev->base_addr);
	kfree(dev);

Thank you for your comments.
-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

Freedom of the press is limited to those who own one.
                                 - A.J. Liebling 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
