Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261348AbULHUUY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261348AbULHUUY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 15:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261350AbULHUUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 15:20:24 -0500
Received: from w130.z209220038.sjc-ca.dsl.cnc.net ([209.220.38.130]:38137 "EHLO
	mail.inostor.com") by vger.kernel.org with ESMTP id S261348AbULHUTw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 15:19:52 -0500
Message-ID: <41B76130.8030607@inostor.com>
Date: Wed, 08 Dec 2004 12:16:48 -0800
From: Tom Dickson <tdickson@inostor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040920
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel Panic removing psnap or p8022 module in 2.4.28  (appletalk
 dependencies)
References: <41B75BBF.8070004@inostor.com>
In-Reply-To: <41B75BBF.8070004@inostor.com>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------060404040502090507040202"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060404040502090507040202
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Next time I promise to finish the report before hitting send.

I'm using a Gentoo Linux system with the vanilla 2.4.28 sources installed. The
attached config file is what I'm using.

appletalk.o now has a dependency it didn't have in 2.4.26, which are the modules
psnap.o and p8022.o, which I can't find how to disable.

If I start netatalk, it modprobes appletalk.o, which loads psnap.o and p8022.o. If
I then stop appletalk, it removes appletalk.o (which works) and then psnap.o and
p8022.o (which kernel panics).

I can also get the kernel panic by modprobing p8022.o and then rmmodding it.

The kernel panic is as follows:

Oops: 0000
CPU:    0
EIP:    0010:[<c0238490>]    Not tainted
EFLAGS: 00010286
eax: 00000004   ebx: cc84a3c0   ecx: 41b75c48   edx: c1363b28
esi: cb6d65e0   edi: 00000400   ebp: 00013b56   esp: c030bf18
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0. stackpage=c030b000)
Stack: c030bfa0 0000e401 cc841cfd cbcbb400 00000000 00000040 c0238623 cb6d65e0
~       c0324d6c c0324ca8 00013b56 00000046 c0238734 c0324ca8 c030bf54 0000012c
~       00000001 c0324b70 fffffffb c011c775 c0324b70 c03249a0 00000005 c134ec60
Call Trace:    [<cc841cfd>] [<c0238623>] [<c0238734>] [<c011c775>] [<c010a5fa>]
~  [<c0106f30>] [<c010c978>] [<c0106f30>] [<c0106f53>] [<c0106fe2>] [<c0105000>]

Code: 66 39 3b 74 60 8b 5b 10 85 db 75 f4 85 d2 74 36 8b 7a 0c 85
~ <0>Kernel panic: Aiee, killing interrupt hander!
In interrupt handler - not syncing

This is a problem because we can't shutdown the machine without this occurring. It
seems that if we disable ipchains in the kernel, it goes away. It also occurs with
the 2.4.27 kernel.

A change we see is in the linux-2.4.28/net/Makefile

mod-subdirs :=  ipv4/netfilter ipv6/netfilter ipx irda bluetooth atm netlink sched
core sctp 802

whereas 2.4.26 has:

mod-subdirs :=  ipv4/netfilter ipv6/netfilter ipx irda bluetooth atm netlink sched
core sctp

This also happens on a number of other machines; mainly RedHat 7.3 machines with
this kernel.

I'm trying to get a ksymoops now, if I get it to work, I'll reply to this post.

You can see an image of the kernel panic (if such things excite you) at:

http://schnecke.bombcar.com/random/kernelpanic.jpg

Note that there is a short delay between removing the module and the panic. You
can also get the panic by removing appletalk, (which works) and then removing
psnap and waiting a few seconds.

Thank you!

- -Tom Dickson

Tom Dickson wrote:
| I've attached the config file used to compile the vanilla 2.4.28 kernel
| that produces the following panic:
|
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFBt2Ew2dxAfYNwANIRApVUAJ9IfJH7PJZLMsS8kidCD4myMyuVrgCdH2HP
BFEJHz1RlLf9k3hAbBX1FLk=
=7kKd
-----END PGP SIGNATURE-----

--------------060404040502090507040202
Content-Type: application/x-gzip;
 name="config.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="config.gz"

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
E8CZwziIXR3g/wHIn8ad+lYAAA==
--------------060404040502090507040202--
