Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284037AbRLXVXF>; Mon, 24 Dec 2001 16:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285337AbRLXVW4>; Mon, 24 Dec 2001 16:22:56 -0500
Received: from colorfullife.com ([216.156.138.34]:42508 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S284037AbRLXVWp>;
	Mon, 24 Dec 2001 16:22:45 -0500
Message-ID: <003301c18cc1$2aa7eeb0$010411ac@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: "Frank van Maarseveen" <F.vanMaarseveen@inter.NL.net>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <002101c18cb7$f575b3c0$010411ac@local> <20011224215615.A22826@iapetus.localdomain>
Subject: Re: <=2.4.17 deadlock (RedHat 7.2, SMP, ext3 related?) (2)
Date: Mon, 24 Dec 2001 22:22:53 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Frank van Maarseveen" <F.vanMaarseveen@inter.NL.net>
> 
> 0xc03fe0b1 <stext_lock+7289>: cmpb   $0x0,0xc05dd400
> 0xc03fe0b8 <stext_lock+7296>: repz nop 
> 0xc03fe0ba <stext_lock+7298>: jle    0xc03fe0b1 <stext_lock+7289>
> 0xc03fe0bc <stext_lock+7300>: jmp    0xc013fde0 <get_chrfops+240>

I assume 0xd05dd400 is kernel_flag.

> 0xc0403068 <stext_lock+27696>: cmpb   $0x0,0xc057d540
> 0xc040306f <stext_lock+27703>: repz nop 
> 0xc0403071 <stext_lock+27705>: jle    0xc0403068 <stext_lock+27696>
> 0xc0403073 <stext_lock+27707>: jmp    0xc0292df0 <ppp_destroy_interface+68>

And 0xc057d540 is all_ppp_lock.

The only obvious abuse is that both ppp_destroy_interface and ppp_create_interface
call rtnl_lock (that's a semaphore) with the spinlock acquired.

--
    Manfred

