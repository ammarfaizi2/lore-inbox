Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932463AbVKQSra@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932463AbVKQSra (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 13:47:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932480AbVKQSra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 13:47:30 -0500
Received: from ip213-185-39-113.laajakaista.mtv3.fi ([213.185.39.113]:2493
	"HELO dag.newtech.fi") by vger.kernel.org with SMTP id S932463AbVKQSra convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 13:47:30 -0500
Message-ID: <20051117184728.2863.qmail@dag.newtech.fi>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-0.27
To: Nish Aravamudan <nish.aravamudan@gmail.com>
cc: Dag Nygren <dag@newtech.fi>, linux-kernel@vger.kernel.org, dag@newtech.fi
Subject: Re: nanosleep with small value 
In-Reply-To: Message from Nish Aravamudan <nish.aravamudan@gmail.com> 
   of "Thu, 17 Nov 2005 09:12:58 PST." <29495f1d0511170912x2cceac78w766f0c800ee3f718@mail.gmail.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Date: Thu, 17 Nov 2005 20:47:28 +0200
From: Dag Nygren <dag@newtech.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On 11/17/05, Dag Nygren <dag@newtech.fi> wrote:

> 
> Which kernel, what value of HZ?

Sorry, the kernel is 2.6.13 and HZ is 250.

> In either case, it's absurd to assume
> that the kernel is going to provide you 1 microsecond resolution in
> 2.6 mainline, as the best HZ value is 1000 (1 millisecond). And we
> don't busy-wait ever in nanosleep().

Not?
The man page for nanosleep saya that times under 2 us are implemented
by a busywait and  this is why I expected it to work.

> So the fastest your loop can run
> is 1000 * 1 ms = 1 second. That's assuming the only time-consuming
> thing is sleeping (minimal overhead). But, in sys_nanosleep(), we
> convert nanoseconds to jiffies and add 1 if you requested any sleep
> time. So,
> 
> HZ = 100
>      1000 * (10 + 1 ms) = 11 s
> HZ = 250
>      1000 * (4 + 1 ms) = 5 s
> HZ = 1000
>      1000 * (1 + 1 ms) = 2 s (which is what Dick Johnson reported).
> 
> Note, that with HZ=250, there might be some extra rounding occurring
> timespec_to_jiffies() that I've forgotten.
> 
> So 8 s may not be terribly unreasonable. I don't know, though, what's
> add the 3 seconds if you're using 250.

OK, in that case the manpage should be changed. And an alternative
has to be worked out by me ;-).

Thankyou
Dag

