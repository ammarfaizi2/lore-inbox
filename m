Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318687AbSHAJm7>; Thu, 1 Aug 2002 05:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318686AbSHAJlz>; Thu, 1 Aug 2002 05:41:55 -0400
Received: from [195.63.194.11] ([195.63.194.11]:14340 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S318687AbSHAJjs>; Thu, 1 Aug 2002 05:39:48 -0400
Message-ID: <3D4849E3.30604@evision.ag>
Date: Wed, 31 Jul 2002 22:34:43 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: "Adam J. Richter" <adam@yggdrasil.com>
CC: martin@dalecki.de, linux-kernel@vger.kernel.org
Subject: Re: Patch?: linux-2.5.29-ide109 small bio-based cleanup
References: <200207302254.PAA00504@baldur.yggdrasil.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam J. Richter wrote:
> 	linux-2.5.29/drivers/ide/pcidma.c has a bunch of code in
> udma_new_table to work around transfers that cross 64kB boundaries
> and transfers that are exactly 64kB when the IDE chipset might only
> be able to handle transfers of *less than* 64kB.  However, the current
> bio code already has limits that you can set to tell it never to send
> IO requests with those problems (blk_queue_segement_boundary and
> blk_queue_max_segment_size).
> 
> 	The following patch makes the IDE code use the bio facilities
> to set these limits, and deletes the code that was needed to work
> around these cases.  This shrinks the code by a net of 29 lines,
> and may allow for a tiny bit of space savings in the future,
> now that we know that none of the scatterlist entries that
> pci_map_sg returns will have to be split. 
> 
> 	I also got rid of an unnecessary variable and some
> extra data clearing and copying in init_hw_data.
> 
> 	I am running this code now on the main that I'm using
> to compose this email.

Thanks! Great! Code immediately swallowed, since obviously correct :-).
However I will drop the CONFIG_CHIPSET outdefs, since at some
point in time we will make *every* host chip controller code
loadable at runtime.


