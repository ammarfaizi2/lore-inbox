Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129455AbQLUJzp>; Thu, 21 Dec 2000 04:55:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129732AbQLUJzZ>; Thu, 21 Dec 2000 04:55:25 -0500
Received: from p3EE3C7D4.dip.t-dialin.net ([62.227.199.212]:24838 "HELO
	emma1.emma.line.org") by vger.kernel.org with SMTP
	id <S129455AbQLUJzO>; Thu, 21 Dec 2000 04:55:14 -0500
Date: Thu, 21 Dec 2000 10:16:56 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Steve Grubb <ddata@gate.net>
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [Patch] performance enhancement for simple_strtoul
Message-ID: <20001221101656.B8388@emma1.emma.line.org>
Mail-Followup-To: Steve Grubb <ddata@gate.net>,
	Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <000e01c06a8e$6945db60$bc1a24cf@master>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <000e01c06a8e$6945db60$bc1a24cf@master>; from ddata@gate.net on Wed, Dec 20, 2000 at 09:09:03 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Dec 2000, Steve Grubb wrote:

> +                        while (isdigit(c)) {
> +                                result = (result*10) + (c & 0x0f);
> +                                c = *(++cp);
> +                        }

x * 10 can be written as:

(x << 2 + x) << 1   = (4x+x) * 2
(x << 3) + (x << 1) = 8x + 2x 

Not sure if that/which one is faster, you may want to benchmark.
However, on machines that I have seen, multiplication times are either
constant or depend on the count of set bits in the second divisor, so
it's something like 6 + 2s.

However, I have only m68k data books here, and it will gain nothing on
an 'C68060 since those beasts ram down multiplications in 2 cycles, so
we'd gain nothing on those chips (OK, the shifts take 1 cycles each and
are scheduled in parallel, and the add takes an additional cycle after
the shifts have completed). Not sure about the ix86, alpha or sparc
series.

-- 
Matthias Andree
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
