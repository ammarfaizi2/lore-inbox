Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267413AbRGYXVU>; Wed, 25 Jul 2001 19:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267405AbRGYXVA>; Wed, 25 Jul 2001 19:21:00 -0400
Received: from jalon.able.es ([212.97.163.2]:42625 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S267390AbRGYXU4>;
	Wed, 25 Jul 2001 19:20:56 -0400
Date: Thu, 26 Jul 2001 01:25:23 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: "J . A . Magallon" <jamagallon@able.es>
Cc: Tom Rini <trini@kernel.crashing.org>,
        "J . A . Magallon" <jamagallon@able.es>,
        Alan Cox <laughing@shared-source.org>,
        Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i2c update to 2.6.0 for 2.4.7
Message-ID: <20010726012523.A1656@werewolf.able.es>
In-Reply-To: <20010725024629.E2308@werewolf.able.es> <20010724192805.A695@opus.bloom.county> <20010725105716.A6980@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20010725105716.A6980@werewolf.able.es>; from jamagallon@able.es on Wed, Jul 25, 2001 at 10:57:16 +0200
X-Mailer: Balsa 1.1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


On 20010725 J . A . Magallon wrote:
>
>On 20010725 Tom Rini wrote:
>>On Wed, Jul 25, 2001 at 02:46:29AM +0200, J . A . Magallon wrote:
>>> Hi.
>>> 
>>> This patch updates i2c support in kernel to 2.6.0. I have corrected original patch
>>> to use slab.h instead of malloc.h, a couple #endif's, and Comfigure.help references
>>> to other docs in <file:...> format.
>>
>>It appears to be missing new files.  The rpx and 405 bits aren't all there.
>>
>
>Correct, the original patch generator skips them, both in 2.6.0 and latest cvs.
>Why ?
>Will redo the patch...
>

I have been looking at that part, and seems like pretty half-done, even buggy.
Can't you live without it ?

For example, in mkpatch/Config.in:

   if [ "$CONFIG_8xx" = "y" ]; then
<well, there is a 8xx cpu variable in arch/ppc>
...
   if [ "$CONFIG_405" = "y" ]; then
<I found no _405, should not it be _4xx ?>
      dep_tristate 'PPC 405 I2C Algorithm' CONFIG_I2C_PPC405_ALGO $CONFIG_I2C
                               look at this ^^^^^^^^^^^^^^^^^^^^
      if [ "CONFIG_PPC405_I2C_ALGO" != "n" ]; then
     <vs this ^^^^^^^^^^^^^^^^^^^^ >
         dep_tristate '  PPC 405 I2C Adapter' CONFIG_I2C_PPC405_ADAP $CONFIG_I2C
_PPC405_ALGO

I would not trust that part still.

BTW, I sent the patches about slab/malloc to the mantainer time ago, and cvs
still uses malloc. 

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.1 (Cooker) for i586
Linux werewolf 2.4.7 #1 SMP Mon Jul 23 01:55:36 CEST 2001 i686
