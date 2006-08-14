Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751407AbWHNNpk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbWHNNpk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 09:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbWHNNpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 09:45:40 -0400
Received: from wx-out-0506.google.com ([66.249.82.233]:52286 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751407AbWHNNpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 09:45:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PrCQH4KdxXNZGK2xJ/rffe5+pzKxiz0nLKD+vOwoX4HmzVnzCmNvQatHtu51rZ5S6qG6Pq0eo6D8u2G+rq1ltwm2xzJCgtUlQUn4momIBinAo/bU8qjhi4gNtzGwLfQFPOcc6OEW+GNuTh2ISfRB4+UqLHgSYu40gUvWrXR9zD8=
Message-ID: <d120d5000608140645y585d987fj1d4927879e9b180e@mail.gmail.com>
Date: Mon, 14 Aug 2006 09:45:29 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Ben B" <kernel@bb.cactii.net>
Subject: Re: 2.6.18-rc4-mm1
Cc: "Andrew Morton" <akpm@osdl.org>,
       "Maciej Rutecki" <maciej.rutecki@gmail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060814120316.GB13159@cactii.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060813012454.f1d52189.akpm@osdl.org>
	 <20060813121126.b1dc22ee.akpm@osdl.org>
	 <20060813224413.GA21959@cactii.net>
	 <200608132000.21132.dtor@insightbb.com>
	 <20060814120316.GB13159@cactii.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/14/06, Ben B <kernel@bb.cactii.net> wrote:
> Dmitry Torokhov <dtor@insightbb.com> uttered the following thing:
> > On Sunday 13 August 2006 18:44, Ben Buxton wrote:
> > > > Could be i8042-get-rid-of-polling-timer-v4.patch. Please try the below
> > > > reversion patch, on top of rc4-mm1, thanks.
> > >
> > > Acking the same issue. Applied the revert patch and my keyboard now
> > > works. Also, it turns out that my keyboard is now the only thing that
> > > failed to resume from S3 on my HP Nc6400, but adding "irqpoll" has fixed
> > > that for now.
> > >
> >
> > Can I please have dmesg of booting unpatched -rc4-mm1 with i8042.debug=1?
>
> I've got masses of these messages - about 100-200 per second filling my
> logs. It seems that they came through as such a rate that the dmesg
> buffer emptied of everything else before syslogd started.
>
> Aug 14 12:53:23 gromit kernel: [   23.070229] drivers/input/serio/i8042.c: Interrupt 1, without any data [4669]
> Aug 14 12:53:23 gromit kernel: [   23.070249] drivers/input/serio/i8042.c: Interrupt 12, without any data [4669]
> Aug 14 12:53:23 gromit kernel: [   23.074223] drivers/input/serio/i8042.c: Interrupt 1, without any data [4670]
> Aug 14 12:53:23 gromit kernel: [   23.074243] drivers/input/serio/i8042.c: Interrupt 12, without any data [4670]
> Aug 14 12:53:23 gromit kernel: [   23.078216] drivers/input/serio/i8042.c: Interrupt 1, without any data [4671]
> Aug 14 12:53:23 gromit kernel: [   23.078237] drivers/input/serio/i8042.c: Interrupt 12, without any data [4671]
> Aug 14 12:53:23 gromit kernel: [   23.082210] drivers/input/serio/i8042.c: Interrupt 1, without any data [4672]
>
> I can try to get a full boot log later when I get home.
>

Please.

> The interrupt counts don't actually seem to increase, I checked
> /proc/interrupts several times in a row and there's no change to the
> 8042 interrupt counts:
>
> root@gromit:~# cat /proc/interrupts
>           CPU0       CPU1
>  0:      66050          0    IO-APIC-edge  timer
>  1:         10          0    IO-APIC-edge  i8042
>  8:          3          0    IO-APIC-edge  rtc
>  9:         10          0   IO-APIC-level  acpi
>  12:       1796          0    IO-APIC-edge  i8042
               ^^^^^^^

It loos like it does (on AUX port)

-- 
Dmitry
