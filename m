Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263370AbTDSJn4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 05:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263372AbTDSJn4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 05:43:56 -0400
Received: from holomorphy.com ([66.224.33.161]:57740 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263370AbTDSJnz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 05:43:55 -0400
Date: Sat, 19 Apr 2003 02:55:26 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: Andy Chou <acc@CS.Stanford.EDU>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [CHECKER] 6 memory leaks
Message-ID: <20030419095526.GE12469@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Muli Ben-Yehuda <mulix@mulix.org>, Andy Chou <acc@CS.Stanford.EDU>,
	Linux-Kernel <linux-kernel@vger.kernel.org>
References: <20030419025025.GA32656@Xenon.Stanford.EDU> <20030419094445.GA7283@actcom.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030419094445.GA7283@actcom.co.il>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 19, 2003 at 12:44:45PM +0300, Muli Ben-Yehuda wrote:
> Index: net/irda/irttp.c
> ===================================================================
> RCS file: /home/cvs/linux-2.5/net/irda/irttp.c,v
> retrieving revision 1.12
> diff -u -r1.12 irttp.c
> --- net/irda/irttp.c	25 Feb 2003 05:02:46 -0000	1.12
> +++ net/irda/irttp.c	19 Apr 2003 08:50:00 -0000
> @@ -263,7 +263,7 @@
>  
>  	IRDA_DEBUG(2, "%s(), rx_sdu_size=%d\n",  __FUNCTION__,
>  		   self->rx_sdu_size);
> -	ASSERT(n <= self->rx_sdu_size, return NULL;);
> +	ASSERT(n <= self->rx_sdu_size, {dev_kfree_skb(skb); return NULL;});
>  
>  	/* Set the new length */
>  	skb_trim(skb, n);

I'm in terror. ASSERT()? return NULL in a macro argument?
Any chance of cleaning that up a bit while you're at it?


-- wli
