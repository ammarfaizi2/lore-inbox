Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262238AbRE0U7t>; Sun, 27 May 2001 16:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262242AbRE0U7j>; Sun, 27 May 2001 16:59:39 -0400
Received: from chromium11.wia.com ([207.66.214.139]:52229 "EHLO
	neptune.kirkland.local") by vger.kernel.org with ESMTP
	id <S262238AbRE0U73>; Sun, 27 May 2001 16:59:29 -0400
Message-ID: <3B116BAC.F45612F3@chromium.com>
Date: Sun, 27 May 2001 14:03:40 -0700
From: Fabio Riccardi <fabio@chromium.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.5-ac1 won't boot with 4GB bigmem option
In-Reply-To: <01052722010200.01106@beastie>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Same here, I have a dual 1GHz PIII with 4G, I don't get an oops but an infinite
loop of:

 > mm: critical shortage of bounce buffers.

Indeed this message has been pestering me in all the recent .4-acx kernels when
the machine is under heavy FS pressure.

In these kernels I observe a significative (5-10%) performance degradation as
soon as the FS cache fills up all the available memory, at this moment "kswapd"
starts to take lots of CPU time (10-20%) and I keep getting plenty of the above
messages.

I'm running SpecWeb with the X15 webserver, which uses sendfile to send its
content, and a very large file set (8-9G, more than twice as much as the
physical RAM).

2.4.2-acx and early 2.4.3-acx kernles were much better in this respect and a lot
more stable.

 - Fabio

Ben Twijnstra wrote:

> Hi,
>
> I compiled and booted the 2.4.5-ac1 kernel with the CONFIG_HIGHMEM4G=y option
> and got an oops in __alloc_pages() (called by alloc_bounce() called by
> schedule()). Everything works fine if I turn the 4GB mode off.
>
> Machine is a Dell Precision with 2 Xeons and 2GB of RAM.
>
> 2.4.5 works fine with the 4GB. Any idea what changed between the two?
>
> Grtz,
>
> Ben
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

