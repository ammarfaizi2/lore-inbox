Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317869AbSGPPpg>; Tue, 16 Jul 2002 11:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317868AbSGPPpf>; Tue, 16 Jul 2002 11:45:35 -0400
Received: from anchor-post-33.mail.demon.net ([194.217.242.91]:48912 "EHLO
	anchor-post-33.mail.demon.net") by vger.kernel.org with ESMTP
	id <S317865AbSGPPpe>; Tue, 16 Jul 2002 11:45:34 -0400
Date: Tue, 16 Jul 2002 16:48:17 +0100
From: Bob Dunlop <bob.dunlop@xyzzy.org.uk>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       Krzysztof Halasa <khc@pm.waw.pl>, linux-kernel@vger.kernel.org
Subject: Re: [GENERIC HDLC LAYER] Messages of a hdlc device
Message-ID: <20020716164817.B10878@xyzzy.org.uk>
References: <200207151111.22555.henrique@cyclades.com> <m37kjvg6nq.fsf@defiant.pm.waw.pl> <20020716135818.GB1231@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020716135818.GB1231@conectiva.com.br>; from acme@conectiva.com.br on Tue, Jul 16, 2002 at 03:57:52PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 16,  Arnaldo Carvalho de Melo wrote:
> Em Tue, Jul 16, 2002 at 03:10:33PM +0200, Krzysztof Halasa escreveu:
> > henrique <henrique@cyclades.com> writes:
> > 
> > > I'm using the generic hdlc layer with PPP protocol against a Lucent MAX6000. 
> > > Everything works OK but there a kernel message bothering me:
> > > 
> > > 	protocol 0008 is buggy, dev hdlc0
> > > 
> > > I get this message nearly once per minute.
> > > 
> > > Do anyone know what is this message about ?
>  
> > Not sure what exactly causes it. I was getting it while running tcpdump
> > on PPP device.
> 
> This is becoming a FAQ... see net/core/dev.c, line 907 on 2.5:
> 
>     /* skb->nh should be correctly
>        set by sender, so that the second statement is
>        just protection against buggy protocols.
>      */
>     skb2->mac.raw = skb2->data;
> 
>     if (skb2->nh.raw < skb2->data || skb2->nh.raw > skb2->tail) {
>             if (net_ratelimit())
>                     printk(KERN_DEBUG "protocol %04x is buggy, dev %s\n",
> 			   skb2->protocol, dev->name);
>             skb2->nh.raw = skb2->data;
>     }

Not exactly a FAQ answer though.  How about:

The error would appear to be benign.  Something in the protocol stack is
not setting one of the header fields correctly and this code has corrected
the fault.

This error is only seen when running network monitoring software such as
tcpdump as that is the only time the particular code path that detects
the error is followed.


Also shouldn't that be:
>                     printk(KERN_DEBUG "protocol %04x is buggy, dev %s\n",
>                          htons(skb2->protocol), dev->name);
-- 
        Bob Dunlop
