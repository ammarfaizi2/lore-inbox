Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271821AbRICVDF>; Mon, 3 Sep 2001 17:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271819AbRICVCz>; Mon, 3 Sep 2001 17:02:55 -0400
Received: from [144.137.83.84] ([144.137.83.84]:3314 "EHLO e4.eyal.emu.id.au")
	by vger.kernel.org with ESMTP id <S271821AbRICVCp>;
	Mon, 3 Sep 2001 17:02:45 -0400
Message-ID: <3B93EE69.5674035F@eyal.emu.id.au>
Date: Tue, 04 Sep 2001 06:56:09 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.10-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jari Ruusu <jari.ruusu@pp.inet.fi>
CC: linux-kernel@vger.kernel.org
Subject: Re: Announce loop-AES-v1.4d file/swap crypto package
In-Reply-To: <3B93B32A.69D25916@pp.inet.fi>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jari Ruusu wrote:
> In short: If file and swap crypto is all you need, this package is a hassle
> free replacement for international crypto patch and HVR's crypto-api.

Some comments about the packaging (which I made once before).

1) It claims to allow you to specify the kernel sources dir, but it then
runs 'depmod' without a nominated version which is only valid if you
are building for the running kernel. I now have it doing
        depmod -ae $(KERNELRELEASE)

2) 'make' will also install the module. It would be nice to have an
explicit 'make install' instead.

3) The module is installed as loop.o, same as the standard kernel
module. I prefer to use different names for added modules.

Also, it ends up in
        /lib/modules/VERSION/block/loop.o
which is fine for 2.2, but 2.4 uses
        /lib/modules/VERSION/kernel/drivers/block/loop.o
so you now have two loop.o - do you know which one will be loaded?

I changed it to install as loop-aes.o:
        cp -p loop.o $(ML)/kernel/drivers/block/loop-aes.o
and I can now select a module in the modules config.

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.anu.edu.au/eyal/>
