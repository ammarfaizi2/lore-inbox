Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275988AbRJKLD5>; Thu, 11 Oct 2001 07:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276032AbRJKLDq>; Thu, 11 Oct 2001 07:03:46 -0400
Received: from [212.169.100.200] ([212.169.100.200]:32240 "EHLO
	sexything.nextframe.net") by vger.kernel.org with ESMTP
	id <S275988AbRJKLDi>; Thu, 11 Oct 2001 07:03:38 -0400
Date: Thu, 11 Oct 2001 13:03:07 +0200
From: Morten Helgesen <admin@nextframe.net>
To: Daniel Kollar <dkollar@fmph.uniba.sk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: parport compile error
Message-ID: <20011011130307.A126@sexything>
Reply-To: admin@nextframe.net
In-Reply-To: <Pine.LNX.4.21.0110111233520.2633-100000@javier.dnp.fmph.uniba.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0110111233520.2633-100000@javier.dnp.fmph.uniba.sk>
User-Agent: Mutt/1.3.22.1i
X-Editor: VIM - Vi IMproved 6.0
X-Keyboard: PFU Happy Hacking Keyboard
X-Operating-System: Slackware Linux (of course)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Tim Waugh posted the following patch to "unbrake" the parport stuff : 

.. snip ..

--- linux/drivers/parport/ieee1284_ops.c.orig   Thu Oct 11 09:40:39 2001
+++ linux/drivers/parport/ieee1284_ops.c        Thu Oct 11 09:40:42 2001
@@ -362,7 +362,7 @@
        } else {
                DPRINTK (KERN_DEBUG "%s: ECP direction: failed to reverse\n",
                         port->name);
-               port->ieee1284.phase = IEEE1284_PH_DIR_UNKNOWN;
+               port->ieee1284.phase = IEEE1284_PH_ECP_DIR_UNKNOWN;
        }

        return retval;
@@ -394,7 +394,7 @@
                DPRINTK (KERN_DEBUG
                         "%s: ECP direction: failed to switch forward\n",
                         port->name);
-               port->ieee1284.phase = IEEE1284_PH_DIR_UNKNOWN;
+               port->ieee1284.phase = IEEE1284_PH_ECP_DIR_UNKNOWN;
        }


.. snip ..

== Morten

On Thu, Oct 11, 2001 at 12:43:29PM +0200, Daniel Kollar wrote:
> 
> I get following error message when compiling parport as a module in
> 2.4.12:
> 
> gcc -D__KERNEL__ -I/usr/src/linux-2.4.12/include -Wall -Wstrict-prototypes
> -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
> -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE   -c -o
> ieee1284_ops.o ieee1284_ops.c
> ieee1284_ops.c: In function `ecp_forward_to_reverse':
> ieee1284_ops.c:365: `IEEE1284_PH_DIR_UNKNOWN' undeclared (first use in
> this function)
> ieee1284_ops.c:365: (Each undeclared identifier is reported only once
> ieee1284_ops.c:365: for each function it appears in.)
> ieee1284_ops.c: In function `ecp_reverse_to_forward':
> ieee1284_ops.c:397: `IEEE1284_PH_DIR_UNKNOWN' undeclared (first use in
> this function)
> 
> D.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
mvh
Morten Helgesen 
UNIX System Administrator & C Developer 
Nextframe AS
admin@nextframe.net / 93445641
http://www.nextframe.net
