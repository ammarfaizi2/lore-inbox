Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262671AbSJGUBw>; Mon, 7 Oct 2002 16:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262693AbSJGUAl>; Mon, 7 Oct 2002 16:00:41 -0400
Received: from smtp-outbound.cwctv.net ([213.104.18.10]:53073 "EHLO
	smtp.cwctv.net") by vger.kernel.org with ESMTP id <S262699AbSJGUAC>;
	Mon, 7 Oct 2002 16:00:02 -0400
From: <Hell.Surfers@cwctv.net>
To: rmk@arm.linux.org.uk, george@mvista.com, nico@cam.org, mark@mark.mielke.cc,
       davem@redhat.com, simon@baydel.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Date: Mon, 7 Oct 2002 21:04:29 +0100
Subject: RE: The end of embedded Linux?
MIME-Version: 1.0
X-Mailer: Liberate TVMail 2.6
Content-Type: multipart/mixed;
 boundary="1034021069594"
Message-ID: <07ac352022007a2DTVMAIL8@smtp.cwctv.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1034021069594
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Then shouldn't the thing thats different from the norm be programmed into a header file which contains how certain functions should be handled differently, which can be dynamically switched by a config option?

Cheers, Dean.

On 	Mon, 7 Oct 2002 20:11:11 +0100 	Russell King <rmk@arm.linux.org.uk> wrote:

--1034021069594
Content-Type: message/rfc822
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Received: from vger.kernel.org ([209.116.70.75]) by smtp.cwctv.net  with Microsoft SMTPSVC(5.5.1877.447.44);
	 Mon, 7 Oct 2002 20:17:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262596AbSJGTFi>; Mon, 7 Oct 2002 15:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262598AbSJGTFi>; Mon, 7 Oct 2002 15:05:38 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:64269 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262596AbSJGTFg>; Mon, 7 Oct 2002 15:05:36 -0400
Received: from flint.arm.linux.org.uk ([3ffe:8260:2002:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with asmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.04)
	id 17ydHd-0001ZY-00; Mon, 07 Oct 2002 20:11:13 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.04)
	id 17ydHb-0005GW-00; Mon, 07 Oct 2002 20:11:11 +0100
Date: Mon, 7 Oct 2002 20:11:11 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: george anzinger <george@mvista.com>
Cc: Nicolas Pitre <nico@cam.org>, Mark Mielke <mark@mark.mielke.cc>,
	"David S. Miller" <davem@redhat.com>, simon@baydel.com,
	alan@lxorguk.ukuu.org.uk, lkml <linux-kernel@vger.kernel.org>
Subject: Re: The end of embedded Linux?
Message-ID: <20021007201111.C5381@flint.arm.linux.org.uk>
References: <Pine.LNX.4.44.0210071307420.913-100000@xanadu.home> <3DA1D87E.81A1351C@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DA1D87E.81A1351C@mvista.com>; from george@mvista.com on Mon, Oct 07, 2002 at 11:54:54AM -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Return-Path: linux-kernel-owner+Hell.Surfers=40cwctv.net@vger.kernel.org

On Mon, Oct 07, 2002 at 11:54:54AM -0700, george anzinger wrote:
> Nicolas Pitre wrote:
> > #ifdef CONFIG_ASSABET_NEPONSET
> > 
> > /*
> >  * These functions allow us to handle IO addressing as we wish - this
> >  * ethernet controller can be connected to a variety of busses.  Some
> >  * busses do not support 16 bit or 32 bit transfers.  --rmk
> >  */
> > static inline u8 smc_inb(u_int base, u_int reg)
> > {
> >         u_int port = base + reg * 4;
> > 
> >         return readb(port);
> > }
> > 
> > static inline u16 smc_inw(u_int base, u_int reg)
> > {
> >         u_int port = base + reg * 4;
> > 
> >         return readb(port) | readb(port + 4) << 8;
> > }
> > 
> > static inline void smc_outb(u8 val, u_int base, u_int reg)
> > {
> >         u_int port = base + reg * 4;
> > 
> >         writeb(val, port);
> > }
> > 
> > static inline void smc_outw(u16 val, u_int base, u_int reg)
> > {
> >         u_int port = base + reg * 4;
> > 
> >         writeb(val, port);
> >         writeb(val >> 8, port + 4);
> > }
> > 
> > #endif
> > 
> > As you can see such code duplicated multiple times for all bus arrangements
> > in existence out there is just not pretty and was refused by Alan.  We lack
> > a global lightweight IO abstraction to nicely override the default IO macros
> > for individual drivers at compile time to fix that problem optimally and
> > keep the driver proper clean.
> 
> Uh, what about stuff like this (from tulip.h):
>  
> #ifndef USE_IO_OPS
> #undef inb
> #undef inw
> #undef inl
> #undef outb
> #undef outw
> #undef outl
> #define inb(addr) readb((void*)(addr))
> #define inw(addr) readw((void*)(addr))
> #define inl(addr) readl((void*)(addr))
> #define outb(val,addr) writeb((val), (void*)(addr))
> #define outw(val,addr) writew((val), (void*)(addr))
> #define outl(val,addr) writel((val), (void*)(addr))
> #endif /* !USE_IO_OPS */

No, you don't quite get it.  The above code Nico pasted supports _one_
ARM machine type only (the one I have here, hence why its in my tree)
where the SMC chip is configured to be in 8-bit mode.

We also have the same device connected in 16-bit mode on other machines,
with different ways to set it up:

http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=734/1

Now imagine the case when you have 100 different machine types, all
different, using this device where each hardware designer has decided to
connect the chip up differently.

Is putting this crud into drivers going to be maintainable?  No.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
--1034021069594--


