Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261597AbREOV5i>; Tue, 15 May 2001 17:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261615AbREOV52>; Tue, 15 May 2001 17:57:28 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:4349 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S261597AbREOV5Z>; Tue, 15 May 2001 17:57:25 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200105152157.f4FLvAw9021664@webber.adilger.int>
Subject: Re: Exporting symbols from a module.
In-Reply-To: <3B0172E6.2010808@fugmann.dhs.org> "from Anders Peter Fugmann at
 May 15, 2001 08:18:14 pm"
To: Anders Peter Fugmann <afu@fugmann.dhs.org>
Date: Tue, 15 May 2001 15:57:09 -0600 (MDT)
CC: linux-kernel <linux-kernel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anders Fugmann writes:
> I've got a simple question - how export symbols from one module, and use 
> them in another.
> 
> I have two modules - 'kvaser' and 'can_master'.
> 'kvaser' exports some functions, and 'can_master' needs to use call 
> these functions.
> 
> I used EXPORT_SYMBOL, and declared the function extern,
> but i still get unresolved symbols.
> 
>  > insmod kvaser.o
>  > insmod can_master.o
> can_master.o: unresolved symbol can_hw_no_messages
> can_master.o: unresolved symbol can_hw_register
> can_master.o: unresolved symbol can_hw_get_message
> can_master.o: unresolved symbol can_hw_unregister
> can_master.o: unresolved symbol can_hw_listen
> can_master.o: unresolved symbol can_hw_block
> can_master.o: unresolved symbol can_hw_send_message
> 
> 
> Looking in /proc/ksyms, i can find the exported symbols from the kvaser 
> driver, but it they are in a different format than all the others.
> 
> d3d27070 can_hw_register_R__ver_can_hw_register [kvaser]
> d3d27090 can_hw_unregister_R__ver_can_hw_unregister     [kvaser]
> d3d270b0 can_hw_listen_R__ver_can_hw_listen     [kvaser]
> d3d270c4 can_hw_block_R__ver_can_hw_block       [kvaser]
> d3d270e8 can_hw_send_message_R__ver_can_hw_send_message [kvaser]
> d3d270f8 can_hw_get_message_R__ver_can_hw_get_message   [kvaser]
> d3d27108 can_hw_no_messages_R__ver_can_hw_no_messages   [kvaser]
> d3d27000 
> __insmod_kvaser_O/home/afu/cvs/dtu/49422/canbus/src/kvaser.o_M3B01709C_V132100 
I just recently had this problem, and your Makefile is missing:

export-objs := <file name>.o

where <file name>.o is the compiled object file from <file name>.c, and
not the module name (if it is different).

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
