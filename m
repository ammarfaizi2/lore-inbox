Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129294AbQJZXDJ>; Thu, 26 Oct 2000 19:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129314AbQJZXC7>; Thu, 26 Oct 2000 19:02:59 -0400
Received: from jalon.able.es ([212.97.163.2]:51871 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129294AbQJZXCm>;
	Thu, 26 Oct 2000 19:02:42 -0400
Date: Fri, 27 Oct 2000 00:57:01 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Marc_Schneider@ers.com
Cc: lkml@dm.ultramaster.com, linux-kernel@vger.kernel.org
Subject: Re: Problem with msgsnd
Message-ID: <20001027005701.A788@werewolf.cps.unizar.es>
In-Reply-To: <932AAD1413276B60852569840052D0B1.0052D14385256984@ers.com> <39F84A92.BDCB869C@ers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <39F84A92.BDCB869C@ers.com>; from Marc_Schneider@ers.com on Thu, Oct 26, 2000 at 17:15:30 +0200
X-Mailer: Balsa 1.0.pre2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 26 Oct 2000 17:15:30 Marc Schneider wrote:
> lkml@dm.ultramaster.com wrote:
> > 
> > Marc Schneider wrote:
> > >
> > > msgsnd seems to be corrupting memory around the msgbuf pointer.
> > >
> > > for example I have the following code:
> > >
> > > pMsgBuf = malloc(iPacketLen + 4 + 8);
> > > bzero(pMsgBuf, iPacketLen + 4 + 8);
> > > pMsgBuf += 4; /* Build a guard band */
> > >
> > > printf("PMQ:pMsgBuf: %p\n",pMsgBuf);
> > > printf("PMQ:-4: %p\n", *(pMsgBuf-4));
> > >

Silly question: why do you :

printf("PMQ:-4: %p\n", *(pMsgBuf-4));

instead of:
                !!!
printf("PMQ:-4: %d\n", *(pMsgBuf-4));, or whatever applies...(typeof pMsgBuf?)

If you use %p, printf expects a pointer in stack, and depending on type of
pMsgBuf (is a char * ?), *pMsgBuf can be passed as a char (I don't think so,
C passes chars as ints, and I dont remenber any kind of option to modify this)
or a short or an int...

So, perhaps you dont put enough data on stack for a pointer and printf gets
incorrect data (the zero in pMsgBuf plus the return value that stored in rc...).

-- 
Juan Antonio Magallon Lacarta                          mailto:jamagallon@able.es

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
