Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276132AbRJPNGW>; Tue, 16 Oct 2001 09:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276135AbRJPNGM>; Tue, 16 Oct 2001 09:06:12 -0400
Received: from [195.63.194.11] ([195.63.194.11]:41735 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S276132AbRJPNF6>; Tue, 16 Oct 2001 09:05:58 -0400
Message-ID: <3BCC2F60.1753212@evision-ventures.com>
Date: Tue, 16 Oct 2001 15:00:16 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-12 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Martin Devera <devik@cdi.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: sendto syscall is slow
In-Reply-To: <Pine.LNX.4.10.10110161438140.13894-100000@luxik.cdi.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Devera wrote:
> 
> Hello,
> 
> i'm doing new qos discipline developement and use own
> mesurment tool. It simply uses PF_PACKET and then
> doing sendto/recv simulating various flows.
> (I use both lo and eth0 where I short-connected RX-TX
>  pins in single ethcard)
> 
> I can't get beyond 25 000 packets per second. gprof:
> Each sample counts as 0.01 seconds.
>   %   cumulative   self              self     total
>  time   seconds   seconds    calls  ms/call  ms/call  name
>  35.67      5.39     5.39   498750     0.01     0.01  sendto
>  26.67      9.42     4.03  1000826     0.00     0.00  poll
>  19.06     12.30     2.88   498750     0.01     0.01  recv
> 
> Is there any faster way to force raw packets to kernel ? I need
> to push qos discipline to its edge but I can't because send
> syscall is bottleneck.
> Is it possible to tx multiple packets in sinhle call or should
> I extend kernel myself for this testing purpose ?

Increase the HZ constant in the kernel, which is determining the
sceduler frequency, which is apparently due to BH handling acting
as a low-pass filder for your siganls here. However please
beware of
many possible sideffects this may have on your system.
