Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266218AbTAJSjc>; Fri, 10 Jan 2003 13:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265898AbTAJSaX>; Fri, 10 Jan 2003 13:30:23 -0500
Received: from [193.158.237.250] ([193.158.237.250]:14217 "EHLO
	mail.intergenia.de") by vger.kernel.org with ESMTP
	id <S265711AbTAJS3I>; Fri, 10 Jan 2003 13:29:08 -0500
Date: Fri, 10 Jan 2003 19:37:50 +0100
Message-Id: <200301101837.h0AIboA05604@mail.intergenia.de>
To: rusty@rustcorp.com.au
From: "Adam J. Richter" <adam@yggdrasil.com>
Subject: Re: Another idea for simplifying locking in kernel/module.c [rescued]
CC: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>In message <200301070219.SAA12905@adam.yggdrasil.com> you write:
>> 	Here is a way to replace all of the specialized "stop CPU"
>> locking code in kernel/module.c with an rw_semaphore by using
>> down_read_trylock in try_module_get() and down_write when beginning to
>> unload the module.

>And now you can't modularize netfilter modules.

	Why not?  Last time you went looking in the networking code
for an example of something that had to increment a module reference
in a context where blocking was not allowed you ended up conceding
that you example was incorrect.  If you've now found an example,
please let me know.

	I just booted my gateway machine to a kernel using my
aforemetioned patch and various netfilter modules.  I've surfed the
web, FTP'ed file and run irc through it.  It seems to be okay.
Here is the lsmod listing from it.

Module                  Size  Used by
iptable_nat            28324  1 [unsafe],
ip_conntrack           39788  2 iptable_nat,[unsafe],
ext2                   60712  0 -
pcmcia_core            55744  0 -
i810                   65816  0 -
atkbd                   6820  0 -
i8042                   8864  0 -
serio                   4564  2 atkbd,i8042,
autofs                 14992  1 -
ipt_TCPMSS              3568  1 [unsafe],
iptable_filter          2272  1 [unsafe],
ip_tables              17296  8 iptable_nat,ipt_TCPMSS,iptable_filter,[unsafe],
nfsd                  111824  1 [unsafe],
exportfs                6160  1 nfsd,
nfs                   132092  0 -
lockd                  58736  3 nfsd,nfs,[unsafe],
sunrpc                114136  4 nfsd,nfs,lockd,[unsafe],
pppoe                  14336  1 [unsafe],
pppox                   3480  1 pppoe,
af_packet              20760  2 [unsafe],
ppp_async              11296  0 -
ppp_generic            30264  5 pppoe,pppox,ppp_async,
slhc                    6576  1 ppp_generic,
ipv4                  392804  88 iptable_nat,ip_conntrack,sunrpc,af_packet,[unsafe],
unix                   23884  11 [unsafe],
sis_agp                 4224  0 -
agpgart                23248  2 sis_agp,
ohci_hcd               28400  0 -
usbcore               101108  3 ohci_hcd,
ac97_codec             12432  0 -
sis900                 16548  0 -
tulip                  52960  2 [unsafe],
crc32                   4272  2 sis900,tulip,
ext3                  112232  3 -
jbd                    65840  1 ext3,
mbcache                 7764  2 ext2,ext3,
ide_disk               17332  5 -
ide_mod               143684  1 ide_disk,[unsafe],


Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

