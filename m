Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136566AbREAEYK>; Tue, 1 May 2001 00:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136567AbREAEYB>; Tue, 1 May 2001 00:24:01 -0400
Received: from adsl-63-206-198-42.dsl.snfc21.pacbell.net ([63.206.198.42]:34768
	"EHLO adsl-63-206-198-42.dsl.snfc21.pacbell.net") by vger.kernel.org
	with ESMTP id <S136566AbREAEXq>; Tue, 1 May 2001 00:23:46 -0400
Date: Mon, 30 Apr 2001 20:42:19 -0700 (PDT)
From: Francois Gouget <fgouget@free.fr>
To: Keith Owens <kaos@ocs.com.au>
cc: "Michael H. Warfield" <mhw@wittsend.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, Ookhoi <ookhoi@dds.nl>,
        Elmer Joandi <elmer@linking.ee>, linux-kernel@vger.kernel.org
Subject: Re: Aironet doesn't work 
In-Reply-To: <18097.988678844@kao2.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.21.0104301915080.3153-100000@amboise.dolphin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 May 2001, Keith Owens wrote:

> On Mon, 30 Apr 2001 18:10:56 -0400, 
> "Michael H. Warfield" <mhw@wittsend.com> wrote:
> >On Mon, Apr 30, 2001 at 01:22:59PM -0700, Francois Gouget wrote:
> >> Apr 30 13:19:34 oleron cardmgr[148]: initializing socket 0
> >> Apr 30 13:19:34 oleron cardmgr[148]: socket 0: Aironet PC4800
> >> Apr 30 13:19:34 oleron cardmgr[148]: executing: 'modprobe aironet4500_core'
> >> Apr 30 13:19:34 oleron cardmgr[148]: + Warning: /lib/modules/2.4.4/kernel/drivers/net/aironet4500_core.o 
> >> symbol for parameter rx_queue_len not found
> 
> Bug in drivers/net/aironet4500_core.c.  It has
>   MODULE_PARM(rx_queue_len,"i");
> but rx_queue_len is never defined.  Only a warning.

   Ok, so a fix would be:

--- cut here ---
--- aironet4500_core.c.orig     Mon Apr 30 19:14:38 2001
+++ aironet4500_core.c  Mon Apr 30 19:14:47 2001
@@ -2564,10 +2564,9 @@
 #if LINUX_VERSION_CODE >= 0x20100
 
 MODULE_PARM(awc_debug,"i");
-MODULE_PARM(rx_queue_len,"i");
 MODULE_PARM(tx_rate,"i");
 MODULE_PARM(channel,"i");
-MODULE_PARM(tx_full_rate,"i");
+//MODULE_PARM(tx_full_rate,"i");
 MODULE_PARM(adhoc,"i");
 MODULE_PARM(master,"i");
 MODULE_PARM(slave,"i");
--- cut here ---

   And if someone knows that tx_full_rate will never be used again then
there's 2 other commented lines to remove.


> >> Apr 30 13:19:34 oleron cardmgr[148]: executing: 'modprobe aironet4500_proc'
> >> Apr 30 13:19:34 oleron cardmgr[148]: executing: 'modprobe aironet4500_cs'
> >> Apr 30 13:19:35 oleron cardmgr[148]: get dev info on socket 0
> >> failed: Resource temporarily unavailable
> 
> Separate problem, the aironet4500_cs driver could not get its
> resources.

   I thought it was supposed to display more messages if it cannot get
its resources. From the pcmcia-howto:
         RequestIO: Resource in use
         RequestIRQ: Resource in use
         RequestWindow: Resource in use
         GetNextTuple: No more items
         could not allocate nn IO ports for CardBus socket n
         could not allocate nnK memory for CardBus socket n
         could not allocate interrupt for CardBus socket n


--
Francois Gouget         fgouget@free.fr        http://fgouget.free.fr/
                     Linux: the choice of a GNU generation




