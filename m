Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132936AbRDJGHo>; Tue, 10 Apr 2001 02:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132940AbRDJGHf>; Tue, 10 Apr 2001 02:07:35 -0400
Received: from ns.suse.de ([213.95.15.193]:6404 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S132938AbRDJGHV>;
	Tue, 10 Apr 2001 02:07:21 -0400
Date: Tue, 10 Apr 2001 08:07:13 +0200
From: Andi Kleen <ak@suse.de>
To: Imran.Patel@nokia.com
Cc: netfilter-devel@us5.samba.org, netdev@oss.sgi.com,
        linux-kernel@vger.kernel.org
Subject: Re: skb allocation problems
Message-ID: <20010410080713.B9549@gruyere.muc.suse.de>
In-Reply-To: <2D6CADE9B0C6D411A27500508BB3CBD063CF07@eseis15nok>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <2D6CADE9B0C6D411A27500508BB3CBD063CF07@eseis15nok>; from Imran.Patel@nokia.com on Mon, Apr 09, 2001 at 07:03:46PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 09, 2001 at 07:03:46PM +0300, Imran.Patel@nokia.com wrote:
> I have written a test module which closely mirrors what my code tries to
> do(attached below). This is what i get:
> 
> PRE_R: old skb:c371ee40  new skb:c371ee30 

I guess oldskb->len is <=0xc, and the slab allocator packs them near together
in the same zone.

>         printk("\nPRE_R: old skb:%p", (*pskb)->data);
> 
> /* translation happens in the real code here */
> 
>         skb = alloc_skb((*pskb)->len, GFP_ATOMIC);
>         if(!skb)
>                 printk("alloc failed");

I guess you want a return here.

>         skb_reserve(skb, 16);

You cannot do that if you didn't make sure that the old skb had enough
room for it (or rather it'll sometimes panic) 


-Andi
