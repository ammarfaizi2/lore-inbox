Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287585AbSALWEq>; Sat, 12 Jan 2002 17:04:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287588AbSALWEh>; Sat, 12 Jan 2002 17:04:37 -0500
Received: from pc1-camc5-0-cust78.cam.cable.ntl.com ([80.4.0.78]:2950 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S287585AbSALWEc>;
	Sat, 12 Jan 2002 17:04:32 -0500
Message-Id: <m16PWFF-000OVeC@amadeus.home.nl>
Date: Sat, 12 Jan 2002 22:03:21 +0000 (GMT)
From: arjan@fenrus.demon.nl
To: jussi.laako@kolumbus.fi (Jussi Laako)
Subject: Re: [PATCH] Additions to full lowlatency patch
cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C40AF23.18C811A8@kolumbus.fi>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.3-6.0.1 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3C40AF23.18C811A8@kolumbus.fi> you wrote:
> --- linux-2.4.17-lowlatency/drivers/net/eepro100.c      Fri Dec 21 19:41:54 2001
> +++ linux-2.4.17-lowlatency-jl/drivers/net/eepro100.c   Mon Dec 31 22:41:42 2001
> @@ -324,7 +324,11 @@
> static inline void wait_for_cmd_done(long cmd_ioaddr)
> {
>        int wait = 1000;
> -       do  udelay(1) ;
> +       do
> +       {
> +                       conditional_schedule();
> +                       udelay(1) ;
> +       }
>        while(inb(cmd_ioaddr) && --wait >= 0);
> #ifndef final_version
>        if (wait < 0)

Did you audit all uses of this function ? It sort of looks like you're doing
"hey there's a udelay lets add a schedule".. ok that's a bit rude but I'm
not totally convinced that this function isn't called with spinlocks helt...
