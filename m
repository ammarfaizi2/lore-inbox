Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287838AbSANRoW>; Mon, 14 Jan 2002 12:44:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287848AbSANRoG>; Mon, 14 Jan 2002 12:44:06 -0500
Received: from ns.ithnet.com ([217.64.64.10]:39952 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S287838AbSANRnt>;
	Mon, 14 Jan 2002 12:43:49 -0500
Date: Mon, 14 Jan 2002 18:43:34 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Memory problem with bttv driver
Message-Id: <20020114184334.0a1712d4.skraw@ithnet.com>
In-Reply-To: <E16QB5s-0002J9-00@the-village.bc.nu>
In-Reply-To: <20020114181210.67650995.skraw@ithnet.com>
	<E16QB5s-0002J9-00@the-village.bc.nu>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jan 2002 17:40:24 +0000 (GMT)
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> > yesterday we came across another MM related problem. This time its related
to> > the bttv-driver. We do very simple things:
> 
> Do you trust your kernel build ?

Yes.

> The bt848 drivers are working beautifully
> for me in 2.4.18pre

Well, I had a quick look at the code, and it seems that vmalloc is just
failing, the source line is obvious./proc/meminfo before modprobe and xawtv:

        total:    used:    free:  shared: buffers:  cached:
Mem:  1054728192 120070144 934658048        0 10420224 65257472
Swap: 1085652992        0 1085652992
MemTotal:      1030008 kB
MemFree:        912752 kB
MemShared:           0 kB
Buffers:         10176 kB
Cached:          63728 kB
SwapCached:          0 kB
Active:          26056 kB
Inactive:        73692 kB
HighTotal:      131056 kB
HighFree:        36720 kB
LowTotal:       898952 kB
LowFree:        876032 kB
SwapTotal:     1060208 kB
SwapFree:      1060208 kB

And afterwards:

        total:    used:    free:  shared: buffers:  cached:
Mem:  1054728192 120537088 934191104        0 10612736 65273856
Swap: 1085652992        0 1085652992
MemTotal:      1030008 kB
MemFree:        912296 kB
MemShared:           0 kB
Buffers:         10364 kB
Cached:          63744 kB
SwapCached:          0 kB
Active:          26140 kB
Inactive:        73812 kB
HighTotal:      131056 kB
HighFree:        36608 kB
LowTotal:       898952 kB
LowFree:        875688 kB
SwapTotal:     1060208 kB
SwapFree:      1060208 kB

Can this be highmem-related?

Regards,
Stephan


