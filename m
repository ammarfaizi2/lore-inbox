Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267122AbRGJTvw>; Tue, 10 Jul 2001 15:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267116AbRGJTvl>; Tue, 10 Jul 2001 15:51:41 -0400
Received: from u-57-20.karlsruhe.ipdial.viaginterkom.de ([62.180.20.57]:24822
	"EHLO dea.waldorf-gmbh.de") by vger.kernel.org with ESMTP
	id <S267112AbRGJTvb>; Tue, 10 Jul 2001 15:51:31 -0400
Date: Tue, 10 Jul 2001 18:29:36 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Chris Wedgwood <cw@f00f.org>
Cc: Christoph Hellwig <hch@ns.caldera.de>, linux-kernel@vger.kernel.org,
        hpa@zytor.com
Subject: Re: How many pentium-3 processors does SMP support?
Message-ID: <20010710182936.A31341@bacchus.dhis.org>
In-Reply-To: <20010710161943.A7785@caldera.de> <20010711022509.C31966@weta.f00f.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010711022509.C31966@weta.f00f.org>; from cw@f00f.org on Wed, Jul 11, 2001 at 02:25:09AM +1200
X-Accept-Language: de,en,fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2001 at 02:25:09AM +1200, Chris Wedgwood wrote:

>     The number of CPUs is currently globally limited to 32 by NR_CPUS in
>     include/linux/threads.h.
> 
> Really?
> 
> <pause>

A define which can easily be changed.

> Ah, so it is... yes, making this architecture dependant might be a
> good idea. Large PPC and MIPS boxen need to adjust this already. Also,
> someone did a starfire port, I think that had 64 processors, not sure.

The next limit are bitfields for processors in a number of places.  They're
stored in unsigned long variables, so this limits the kernel to 32
processors on 32-bit machines and 64 on 64-bit machines.  Kanoj once
fixed that and we had Linux booting on a 128p Origin but I'm not sure
if those fixes went back to Linus.  Once this is fixed there is a number
of arrays with NR_CPUS elements in struct task_struct.  Once you reach
an estimated number of 200-300 processors (for 16kb kernel stacks) those
make task_struct that large that the kernel stack may overflow.  I
haven't really researched all the gotchas that may cause problems with
the kernel when going to machines of more than 128 processors.

  Ralf
