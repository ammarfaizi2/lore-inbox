Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266842AbSKUQ4Q>; Thu, 21 Nov 2002 11:56:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266876AbSKUQ4Q>; Thu, 21 Nov 2002 11:56:16 -0500
Received: from vger.timpanogas.org ([216.250.140.154]:34261 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S266842AbSKUQ4P>; Thu, 21 Nov 2002 11:56:15 -0500
Date: Thu, 21 Nov 2002 11:05:16 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Robert Olsson <Robert.Olsson@data.slu.se>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: e1000 fixes (NAPI)
Message-ID: <20021121110516.A31286@vger.timpanogas.org>
References: <15835.56316.564937.169193@robur.slu.se> <20021120164319.A26918@vger.timpanogas.org> <15836.47295.808423.41648@robur.slu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15836.47295.808423.41648@robur.slu.se>; from Robert.Olsson@data.slu.se on Thu, Nov 21, 2002 at 11:43:11AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I've been using the driver from Intel's website.   :-)  Where is this new extension so I can test it.

:-)

Jeff

P.S.  I've been working heads down on new projects with Linux is where 
I've been.  Sounds like other folks have seen this and addressed it.



On Thu, Nov 21, 2002 at 11:43:11AM +0100, Robert Olsson wrote:
> 
> Jeff V. Merkey writes:
>  > 
>  > Need another fix.  You need to reinstrument the tasklet schedule in the 
>  > fill_rx_ring instread of doing the whole thing from interrupt.  When the 
>  > system is loaded at 100% saturation on gigbit with 300 byte packets or 
>  > smaller, the driver does not allow any processes to run, and you cannot 
>  > log in via ssh or any user space apps.  This is severely busted.   
>  > 
>  > The later versions of the driver > 4.3.15 all exhibit this behavior and 
>  > are extremely broken.
> 
>  Where have you been? :-)
> 
>  NAPI does RX processing in softirq. RX interrupts are just used to indicate 
>  work. At high loads the consecutive RX polls gets run via ksoftirqd which
>  is under scheduler control also the RX softirq breakes for other work. This 
>  makes the NAPI network stuff as very well behaved kernel citizen and also 
>  gives network performance at any load.
> 
>  More details is in the usenix paper;
>  http://www.cyberus.ca/~hadi/usenix-paper.tgz
> 
>  Cheers.
> 						--ro
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
