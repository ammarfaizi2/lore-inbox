Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316668AbSGGXqm>; Sun, 7 Jul 2002 19:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316672AbSGGXql>; Sun, 7 Jul 2002 19:46:41 -0400
Received: from jalon.able.es ([212.97.163.2]:18653 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S316668AbSGGXqe>;
	Sun, 7 Jul 2002 19:46:34 -0400
Date: Mon, 8 Jul 2002 01:49:06 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19rc1aa1
Message-ID: <20020707234906.GA6080@werewolf.able.es>
References: <20020629023459.GA1531@inspiron.ols.wavesec.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20020629023459.GA1531@inspiron.ols.wavesec.org>; from andrea@suse.de on Sat, Jun 29, 2002 at 04:35:00 +0200
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.06.29 Andrea Arcangeli wrote:
>Only booted it on the laptop so far.
>
>URL:
>
>	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19rc1aa1.gz
>	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19rc1aa1/
>
>Changelog:
>

I think the build system for e100 is buggy. You end up with 2 copies of e100.o:

werewolf:/usr/src/linux# make -n modules_install | grep e100
cp ne2k-pci.o 8390.o e100/e100.o ... /lib/modules/2.4.19-rc1-jam1/kernel/drivers/net/
                     ^^^^^^^^^^^
make -C e100 modules_install
make[3]: Entering directory `/usr/src/linux-2.4.19-rc1-jam1/drivers/net/e100'
Makefile:21: warning: overriding commands for target `e100.o'
/usr/src/linux-2.4.19-rc1-jam1/Rules.make:97: warning: ignoring old commands for target `e100.o'
mkdir -p /lib/modules/2.4.19-rc1-jam1/kernel/drivers/net/e100/
cp e100.o /lib/modules/2.4.19-rc1-jam1/kernel/drivers/net/e100/
   ^^^^^^
make[3]: Leaving directory `/usr/src/linux-2.4.19-rc1-jam1/drivers/net/e100'

Unconditional 

obj-$(CONFIG_E100) += e100.o

breaks if == obj-m.

tulip, for example, does a:

ifeq ($(CONFIG_TULIP),y)
  obj-y += tulip/tulip.o
endif

??

TIA

-- 
J.A. Magallon             \   Software is like sex: It's better when it's free
mailto:jamagallon@able.es  \                    -- Linus Torvalds, FSF T-shirt
Linux werewolf 2.4.19-rc1-jam1, Mandrake Linux 8.3 (Cooker) for i586
gcc (GCC) 3.1.1 (Mandrake Linux 8.3 3.1.1-0.7mdk)
