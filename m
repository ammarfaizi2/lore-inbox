Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262131AbUCVRST (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 12:18:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262133AbUCVRST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 12:18:19 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:50115 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262131AbUCVRSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 12:18:17 -0500
Date: Mon, 22 Mar 2004 17:51:44 +0100 (MET)
From: Armin Schindler <armin@melware.de>
To: Arjan van de Ven <arjanv@redhat.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ISDN Eicon driver: restructured capi list and lock
 handling
In-Reply-To: <20040322163307.GA22295@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.31.0403221748190.7358-100000@phoenix.one.melware.de>
Organization: Cytronics & Melware
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:4f0aeee4703bc17a8237042c4702a75a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Mar 2004, Arjan van de Ven wrote:
>
> On Mon, Mar 22, 2004 at 05:32:42PM +0100, Arjan van de Ven wrote:
> > On Sun, 2004-03-21 at 17:55, Linux Kernel Mailing List wrote:
> > > ChangeSet 1.1828, 2004/03/21 08:55:24-08:00, armin@melware.de
> > >
> > > 	[PATCH] ISDN Eicon driver: restructured capi list and lock handling
> > >
> > > 	Restructered the CAPI code of list handling and lock.
> > >
> > > 	Removed obsolete code.
> >
> > this patch is broken:
> > Error: ./drivers/isdn/hardware/eicon/capifunc.o .altinstructions refers
> > to 00000018 R_386_32          .exit.text
> > Error: ./drivers/isdn/hardware/eicon/capifunc.o .init.text refers to
> > 0000015d R_386_PC32        .exit.text
> >
> > eg you call __exit functions from __init functions, which is
> > incorrect....
>
> and the fix:
>
> --- linux-2.6.4/drivers/isdn/hardware/eicon/capifunc.c~	2004-03-22 17:12:30.868043408 +0100
> +++ linux-2.6.4/drivers/isdn/hardware/eicon/capifunc.c	2004-03-22 17:12:30.868043408 +0100
> @@ -455,7 +455,7 @@
>  /*
>   * remove cards
>   */
> -static void DIVA_EXIT_FUNCTION divacapi_remove_cards(void)
> +static void divacapi_remove_cards(void)
>  {
>  	DESCRIPTOR d;
>  	struct list_head *tmp;
>

Yes, you are correct. I wonder why my compiler didn't complain about this.
It works here and I don't know why. What configuration did you use?

I will create a correct incremental patch (another patch for this file is
already send to Linus) for Linus/Andrew.

Thanks for pointing out.

Armin

