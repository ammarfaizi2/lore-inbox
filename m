Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318357AbSHEJei>; Mon, 5 Aug 2002 05:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318358AbSHEJeh>; Mon, 5 Aug 2002 05:34:37 -0400
Received: from [195.63.194.11] ([195.63.194.11]:60426 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S318357AbSHEJeh>; Mon, 5 Aug 2002 05:34:37 -0400
Message-ID: <3D4E464F.3000306@evision.ag>
Date: Mon, 05 Aug 2002 11:33:03 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Petr Vandrovec <vandrove@vc.cvut.cz>
CC: martin@dalecki.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IDE udma_status = 0x76 and 2.5.30...
References: <20020804222542.GH13053@ppc.vc.cvut.cz>
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Petr Vandrovec napisa?:
> Hi,
>    patch below fixes troubles with PDC20265 reporting udma_status = 0x76
> with kernels since pcidma cleanup (it was already reported here, but
> I did not found patch for it). Code before change (IDE110) set highest
> bit of last dword to 1 on all devices except TRM290. New code
> set it only on TRM290 devices, which breaks at least mine PDC20265.
> Please send it to Linus in your next update.

Yes it is obviously correct.

>    BTW, are there any TRM290 owners using 2.5.30? Old code set length to
> ((length >> 2) - 1) << 16, while new code does not have special handling
> for TRM290. Or do I miss something?

The new code is overwriting those values in the host controller driver
itself.

>    And BTW#2, mine problematic Toshiba disk works fine with PDC20265 with
> 512B request size... It breaks with i845 and i440BX, under any UDMA.

Hmm... It is very well possible that the Toshiba doesn't like the
fact that the intel chipsets cheat and do something like UDMA88 instead 
of UDMA100. Could you verify this by checking whatever forcing them to 
UDMA66 helps please? Vojtech?

