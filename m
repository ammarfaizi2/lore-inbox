Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262409AbTCVMWZ>; Sat, 22 Mar 2003 07:22:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262158AbTCVMWZ>; Sat, 22 Mar 2003 07:22:25 -0500
Received: from village.ehouse.ru ([193.111.92.18]:56072 "EHLO mail.ehouse.ru")
	by vger.kernel.org with ESMTP id <S262152AbTCVMWY>;
	Sat, 22 Mar 2003 07:22:24 -0500
From: "Sergey S. Kostyliov" <rathamahata@php4.ru>
Illegal-Object: Syntax error in Reply-To: address found on vger.kernel.org:
	Reply-To:	Sergey S.Kostyliov <rathamahata@php4.ru>
			^	^-missing end of address
			 \-extraneous tokens in address
To: latten@austin.ibm.com, root@chaos.analogic.com
Subject: Re: eth0: Bus master arbitration failure
Date: Sat, 22 Mar 2003 15:33:06 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, Maurice Volaski <mvolaski@aecom.yu.edu>,
       spotter@cs.columbia.edu
References: <200303141741.h2EHfSpm021569@faith.austin.ibm.com>
In-Reply-To: <200303141741.h2EHfSpm021569@faith.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303221533.06980.rathamahata@php4.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

On Friday 14 March 2003 20:41, latten@austin.ibm.com wrote:
> >On Thu, 13 Mar 2003 latten@austin.ibm.com wrote:
> >
> >> I was wondering if anyone knew if this had been resolved
> >> or see this problem too. I am having the same problem. 
> >> However, I am using 2.5.64 kernel and I have tried 
> >> both an eepro100 and a 3com-tornado ethernet card.
> >> 
> >
> >I think the problem is probably all those "printk()" calls
> >within timing-sensitive code (really). A Bus master arbitration
> >failure is supposed to result in a retry. It is not supposed to
> >be fatal. For kicks, just comment out the printk() and see if
> >the box starts to work. If that makes it work, an appropriate
> >permanent fix would be to just keep track of the number of
> >such failures just like the dropped-packet and collision count.
> >
> >If removing the printk() doesn't fix it, there may be a retained
> >spin-lock on an error exit path.
> >
> 
> I did go and take a look at that printk :-) and realized it was in
> pcnet32.c and that it was my pcnet32 card complaining and not
> my eepro100 or 3com card. Whew! Sorry about that mistake. 
> I am going to try and install kdb and see if it will help 
> locate where the lockup is occuring.

I just want to clear things out.
This check was in kernels before 2.4.19 too.

if (csr0 & 0x0800) {
            printk(KERN_ERR "%s: Bus master arbitration failure, status %4.4x.\n",
                   dev->name, csr0);
            /* unlike for the lance, there is no restart needed */
        }

But I've never seen nor this message neither kernel lockups before
2.4.19. And even for kernels > 2.4.19 it seems UP systems are not
affected (There are no such problems on my UP Netfinity 5100 so far).

> 
> Thanks,
> Joy

-- 
                   Best regards,
                   Sergey S. Kostyliov <rathamahata@php4.ru>
                   Public PGP key: http://sysadminday.org.ru/rathamahata.asc
