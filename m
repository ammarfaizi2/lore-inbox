Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267298AbUIXE0U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267298AbUIXE0U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 00:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267259AbUIXE0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 00:26:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:8593 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267176AbUIXE0N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 00:26:13 -0400
Date: Thu, 23 Sep 2004 21:19:33 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Donald Duckie <schipperke2000@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: snull_load insmod: unresolved symbol
Message-Id: <20040923211933.726d0d25.rddunlap@osdl.org>
In-Reply-To: <20040916044514.38729.qmail@web53606.mail.yahoo.com>
References: <20040915100527.60a05e24.rddunlap@osdl.org>
	<20040916044514.38729.qmail@web53606.mail.yahoo.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Sep 2004 21:45:14 -0700 (PDT) Donald Duckie wrote:

| 
| hi!
| 
| now, i am quite confused with what was informed
| because it seems that it is none from those.
| 
| here is what was done:
| i compiled the snull source file on 2.4.18-sh which i
| got from
| http://www.oreilly.com.tw/editor_column/a138_read.html.
| it was mentioned in that site that snull was compiled
| with 2.4.24.
| 
| anyway, compilation with 2.4.18-sh was successful,
| but upon running insmod on 2.4.18-sh, i got those
| unresolved errors. 
| 
| any help/information are very  much welcome.

I just tested on 2.4.current (2.4.28-pre3).  No problems.
Or had you already solved most of this one?

| i have some questions though (i am not quite familiar
| with the workarounds of linux):
| 
| (1)  what does it mean if the functions cannot be
| found on /proc/ksyms? almost all but the "insmod:
| unresolved symbol jiffies_R0da02d67" are not defined
| in that file.

Is "jiffies" in /proc/ksyms or in the System.map file for the
kernel that you are running/testing?  The Rxxxxxxx is a
CRC or checksum of (some) kernel header files.  This is done
when CONFIG_MODVERSIONS is enabled in the kernel .config,
so that modules must be built for precisely the same kernel
into which they are loaded.  FWIW, I don't use CONFIG_MODVERSIONS:
# CONFIG_MODVERSIONS is not set
so I bypass this problem, but you are certainly not the first
person to have this problem.  I thought it was in the FAQ (see end
of any lkml email), but I didn't find it there.

Check other symbols for [near] presence in /proc/ksyms or System.map
also.

| (2) i am cross-compiling. i also tried running "depmod
| -a" prior to compilation, but depmod wrote into
| /lib/modules/2.4.24, instead of
| /lib/modules/2.4.18-sh. both directories exists.
| do i really need to run depmod? how will i made it
| update the /lib/modules/2.4.18-sh directory instead of
| the /lib/modules/2.4.24 directory?

What kernel source tree top-level directory were you in when you
ran 'depmod'?

'depmod' should be used to put kernel-tree modules into
/lib/modules/v.x.y.  However, for modules such as snull, which
aren't needed for booting, you don't need to use depmod.
Just cd to the directory containing the .o file and load it.

| (3) and what is meant by "i need to determine which is
| the case/problem and change some part of that config."
| which/what config should i change? 

Probably CONFIG_MODVERSIONS.  You can build the kernel and modules
with CONFIG_MODVERSIONS disabled (off), or you can build them all
with CONFIG_MODVERSIONS=y.  You can't mix them, which is what it
looks like you did.

| i am waiting for your good insights . . .
| thank you very much.
| 
| 
| --- "Randy.Dunlap" <rddunlap@osdl.org> wrote:
| 
| > On Wed, 15 Sep 2004 04:34:34 -0700 (PDT) Donald
| > Duckie wrote:
| > 
| > | hi!
| > | 
| > | has anyone ever tried compiling and running snull
| > on
| > | Linux2.4.18-sh?
| > | 
| > | i tried compiling snull(without any modification)
| > on
| > | Linux2.4.18-sh.
| > | upon running snull_load, i got the following:
| > | Using
| > /lib/modules/2.4.18-sh/kernel/drivers/net/snull.
| > | insmod: unresolved symbol kmalloc_R93d4cfe6
| > | insmod: unresolved symbol
| > skb_under_panic_R69955398
| > | insmod: unresolved symbol
| > register_netdev_R09e03f58
| > | insmod: unresolved symbol eth_type_trans_R0a4e7a1c
| > | insmod: unresolved symbol
| > unregister_netdev_R98eda3f8
| > | insmod: unresolved symbol printk_Rdd132261
| > | insmod: unresolved symbol __udivsi3_i4
| > | insmod: unresolved symbol memcpy_R11f7ce5e
| > | insmod: unresolved symbol jiffies_R0da02d67
| > | insmod: unresolved symbol alloc_skb_R0177038c
| > | insmod: unresolved symbol softnet_data_R258cb892
| > | insmod: unresolved symbol
| > cpu_raise_softirq_R4d09166c
| > | insmod: unresolved symbol __kfree_skb_R1741771d
| > | insmod: unresolved symbol memset_R2bc95bd4
| > | insmod: unresolved symbol kfree_R037a0cba
| > | insmod: unresolved symbol netif_rx_R8316ccd0
| > | insmod: unresolved symbol ether_setup_R586ea93a
| > | insmod: unresolved symbol skb_over_panic_R4bb59969
| > | 
| > | can someone please tell me what's wrong with this,
| > | and how to fix this without chaning Linux
| > versions?
| > 
| > You are building the module with module versioning
| > turned on,
| > but your kernel is built without module versions, or
| > it is built
| > with module versions, but they don't match your
| > current kernel
| > source code.
| > 
| > You'll need to determine which is the case/problem
| > and change
| > some part of that config.

--
~Randy
