Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261353AbSJYKHI>; Fri, 25 Oct 2002 06:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261361AbSJYKHI>; Fri, 25 Oct 2002 06:07:08 -0400
Received: from boden.synopsys.com ([204.176.20.19]:29341 "HELO
	boden.synopsys.com") by vger.kernel.org with SMTP
	id <S261353AbSJYKHH>; Fri, 25 Oct 2002 06:07:07 -0400
Date: Fri, 25 Oct 2002 12:13:11 +0200
From: Alex Riesen <Alexander.Riesen@synopsys.com>
To: Florian Weimer <fw@deneb.enyo.de>
Cc: linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: [SECURITY] CERT/CC VU#464113, SYN plus RST/FIN
Message-ID: <20021025101311.GD3512@riesen-pc.gr05.synopsys.com>
Reply-To: Alexander.Riesen@synopsys.com
Mail-Followup-To: Florian Weimer <fw@deneb.enyo.de>,
	linux-kernel@vger.kernel.org, davem@redhat.com
References: <87vg3qq4ec.fsf@deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87vg3qq4ec.fsf@deneb.enyo.de>
User-Agent: Mutt/1.4i
Organization: Synopsys, Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2002 at 11:00:43AM +0200, Florian Weimer wrote:
> This patch prevents SYN+RST and SYN+FIN segments which arrive in the
> LISTEN state from initiating a three-way handshake.
> 
> I'm not sure if it is correct, but it's better than nothing (so far, I
> haven't seen any patch for this issue).
> 
> --- tcp_input.c	2002/10/25 08:45:20	1.1
> +++ tcp_input.c	2002/10/25 08:49:21
> @@ -3668,6 +3668,8 @@
>  	case TCP_LISTEN:
>  		if(th->ack)
>  			return 1;
> +		if(th->rst || th->fin)
> +			goto discard;
>  
>  		if(th->syn) {
>  			if(tp->af_specific->conn_request(sk, skb) < 0)
> 

You mean to place the check below "if(th->syn)", don't you?

-alex
