Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136144AbRECHTG>; Thu, 3 May 2001 03:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136146AbRECHS4>; Thu, 3 May 2001 03:18:56 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:62153 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S136138AbRECHSn>;
	Thu, 3 May 2001 03:18:43 -0400
Message-ID: <3AF10648.C5986A8E@mandrakesoft.com>
Date: Thu, 03 May 2001 03:18:32 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: unsigned long ioremap()?
In-Reply-To: <Pine.LNX.4.05.10105030852330.9438-100000@callisto.of.borg> <15089.979.650927.634060@pizda.ninka.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
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

Agreed...  Tangent a bit, I wanted to plug using macros which IMHO make
code even more readable:

	val = RTL_R32(REG2);
	RTL_W32(REG2, val);

Since these are driver-private, if you are only dealing with one chip
you could even shorten things to "R32" and "W32", if that doesn't offend
any sensibilities :)

-- 
Jeff Garzik      | Game called on account of naked chick
Building 1024    |
MandrakeSoft     |
