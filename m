Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136208AbRECHyT>; Thu, 3 May 2001 03:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136182AbRECHyH>; Thu, 3 May 2001 03:54:07 -0400
Received: from smtp3.libero.it ([193.70.192.53]:62924 "EHLO smtp3.libero.it")
	by vger.kernel.org with ESMTP id <S136186AbRECHxq>;
	Thu, 3 May 2001 03:53:46 -0400
Message-ID: <3AF10E80.63727970@alsa-project.org>
Date: Thu, 03 May 2001 09:53:36 +0200
From: Abramo Bagnara <abramo@alsa-project.org>
Organization: Opera Unica
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19 i586)
X-Accept-Language: it, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: unsigned long ioremap()?
In-Reply-To: <Pine.LNX.4.05.10105030852330.9438-100000@callisto.of.borg> <15089.979.650927.634060@pizda.ninka.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
> Geert Uytterhoeven writes:
>  > Since you're not allowed to use direct memory dereferencing on ioremapped
>  > areas, wouldn't it be more logical to let ioremap() return an unsigned long
>  > instead of a void *?
>  >
>  > Of course we then have to change readb() and friends to take a long as well,
>  > but at least we'd get compiler warnings when someone tries to do a direct
>  > dereference.
> 
> There is a school of thought which believes that:
> 
> struct xdev_regs {
>         u32 reg1;
>         u32 reg2;
> };
> 
>         val = readl(&regs->reg2);
> 
> is cleaner than:
> 
> #define REG1 0x00
> #define REG2 0x04
> 
>         val = readl(regs + REG2);
> 
> I'm personally ambivalent and believe that both cases should be allowed.

The problem I see is that with the former solution nothing prevents from
to do:

	regs->reg2 = 13;

That's indeed the reason to change ioremap prototype for 2.5.

-- 
Abramo Bagnara                       mailto:abramo@alsa-project.org

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy

ALSA project               http://www.alsa-project.org
It sounds good!
