Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136184AbRECHu3>; Thu, 3 May 2001 03:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136182AbRECHuT>; Thu, 3 May 2001 03:50:19 -0400
Received: from geos.coastside.net ([207.213.212.4]:65165 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S136174AbRECHuI>; Thu, 3 May 2001 03:50:08 -0400
Mime-Version: 1.0
Message-Id: <p05100308b716bb9ed170@[207.213.214.37]>
In-Reply-To: <3AF10648.C5986A8E@mandrakesoft.com>
In-Reply-To: <Pine.LNX.4.05.10105030852330.9438-100000@callisto.of.borg>
 <15089.979.650927.634060@pizda.ninka.net>
 <3AF10648.C5986A8E@mandrakesoft.com>
Date: Thu, 3 May 2001 00:46:09 -0700
To: Jeff Garzik <jgarzik@mandrakesoft.com>,
        "David S. Miller" <davem@redhat.com>
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: unsigned long ioremap()?
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 3:18 AM -0400 2001-05-03, Jeff Garzik wrote:
>"David S. Miller" wrote:
>>  There is a school of thought which believes that:
>>
>  > struct xdev_regs {
>>          u32 reg1;
>>          u32 reg2;
>>  };
>  >
>>          val = readl(&regs->reg2);
>>
>>  is cleaner than:
>>
>>  #define REG1 0x00
>>  #define REG2 0x04
>>
>>          val = readl(regs + REG2);
>>
>>  I'm personally ambivalent and believe that both cases should be allowed.
>
>Agreed...  Tangent a bit, I wanted to plug using macros which IMHO make
>code even more readable:
>
>	val = RTL_R32(REG2);
>	RTL_W32(REG2, val);
>
>Since these are driver-private, if you are only dealing with one chip
>you could even shorten things to "R32" and "W32", if that doesn't offend
>any sensibilities :)

With a little arithmetic behind the scenes and a NULL pointer to the 
struct xdev, you could have:

struct xdev_regs {
         u32 reg1;
         u32 reg2;
} *xdr = 0;

#define RTL_R32(REG) readl(cookie+(unsigned long)(&xdr->REG))

cookie = ioremap(blah, blah);

val = RTL_R32(reg2);

...and have the benefits of the R32 macro as well as the use of 
structure members.
-- 
/Jonathan Lundell.
