Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261222AbREOSck>; Tue, 15 May 2001 14:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261226AbREOS2z>; Tue, 15 May 2001 14:28:55 -0400
Received: from cpe.atm0-0-0-122182.bynxx2.customer.tele.dk ([62.243.2.100]:44131
	"HELO marvin.athome.dk") by vger.kernel.org with SMTP
	id <S261225AbREOSSR>; Tue, 15 May 2001 14:18:17 -0400
Message-ID: <3B0172E6.2010808@fugmann.dhs.org>
Date: Tue, 15 May 2001 20:18:14 +0200
From: Anders Peter Fugmann <afu@fugmann.dhs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.4-ac9 i686; en-US; rv:0.9+) Gecko/20010513
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Exporting symbols from a module.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I've got a simple question - how export symbols from one module, and use 
them in another.

I have two modules - 'kvaser' and 'can_master'.
'kvaser' exports some functions, and 'can_master' needs to use call 
these functions.

I used EXPORT_SYMBOL, and declared the function extern,
but i still get unresolved symbols.

 > insmod kvaser.o
 > insmod can_master.o
can_master.o: unresolved symbol can_hw_no_messages
can_master.o: unresolved symbol can_hw_register
can_master.o: unresolved symbol can_hw_get_message
can_master.o: unresolved symbol can_hw_unregister
can_master.o: unresolved symbol can_hw_listen
can_master.o: unresolved symbol can_hw_block
can_master.o: unresolved symbol can_hw_send_message


Looking in /proc/ksyms, i can find the exported symbols from the kvaser 
driver, but it they are in a different format than all the others.

d3d27070 can_hw_register_R__ver_can_hw_register [kvaser]
d3d27090 can_hw_unregister_R__ver_can_hw_unregister     [kvaser]
d3d270b0 can_hw_listen_R__ver_can_hw_listen     [kvaser]
d3d270c4 can_hw_block_R__ver_can_hw_block       [kvaser]
d3d270e8 can_hw_send_message_R__ver_can_hw_send_message [kvaser]
d3d270f8 can_hw_get_message_R__ver_can_hw_get_message   [kvaser]
d3d27108 can_hw_no_messages_R__ver_can_hw_no_messages   [kvaser]
d3d27000 
__insmod_kvaser_O/home/afu/cvs/dtu/49422/canbus/src/kvaser.o_M3B01709C_V132100 
[kvaser]

the modules are compiled with:
-D__KERNEL__ -DMODULE -Wall -O2 -Wall -Wstrict-prototypes 
-fomit-frame-pointer -fno-strict-aliasing -DEXPORT_SYMTAB

Any ideas appreciated.

Regards Anders Fugmann


