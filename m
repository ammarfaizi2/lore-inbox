Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288355AbSACWmM>; Thu, 3 Jan 2002 17:42:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288361AbSACWmD>; Thu, 3 Jan 2002 17:42:03 -0500
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:43787 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S288355AbSACWlv>; Thu, 3 Jan 2002 17:41:51 -0500
Date: Thu, 3 Jan 2002 22:41:43 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org
Subject: Re: Who uses hdx=bswap or hdx=swapdata?
Message-ID: <20020103224143.D13173@flint.arm.linux.org.uk>
In-Reply-To: <3C34D6FC.9090207@colorfullife.com> <E16MGPf-0001I3-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16MGPf-0001I3-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Jan 03, 2002 at 10:32:39PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2002 at 10:32:39PM +0000, Alan Cox wrote:
> > Is the hdx=bswap or hdx=swapdata option actually in use?
> > When is it needed?
> 
> Certain M68K machines

Is this parameter actually used on these machines, or do we rely on
the code in atapi_{input,output}_bytes:

#if defined(CONFIG_ATARI) || defined(CONFIG_Q40)
        if (MACH_IS_ATARI || MACH_IS_Q40) {
                /* Atari has a byte-swapped IDE interface */
                insw_swapw(IDE_DATA_REG, buffer, bytecount / 2);
                return;
        }
#endif /* CONFIG_ATARI */

and:

#if defined(CONFIG_ATARI) || defined(CONFIG_Q40)
        if (MACH_IS_ATARI || MACH_IS_Q40) {
                /* Atari has a byte-swapped IDE interface */
                outsw_swapw(IDE_DATA_REG, buffer, bytecount / 2);
                return;
        }
#endif /* CONFIG_ATARI */

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

