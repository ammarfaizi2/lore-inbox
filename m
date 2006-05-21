Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751492AbWEUG6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751492AbWEUG6n (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 02:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751493AbWEUG6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 02:58:43 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.83]:47232 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id S1751492AbWEUG6m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 02:58:42 -0400
Message-ID: <44701017.8000803@cmu.edu>
Date: Sun, 21 May 2006 03:00:39 -0400
From: George Nychis <gnychis@cmu.edu>
User-Agent: Thunderbird 1.5.0.2 (X11/20060503)
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: cannot load *any* modules with 2.4 kernel
References: <446F3F6A.9060004@cmu.edu> <20060520162529.GT11191@w.ods.org> <446FAEE3.6060003@cmu.edu> <20060521054826.GA14334@w.ods.org>
In-Reply-To: <20060521054826.GA14334@w.ods.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for all the help Willy,

Nothing from the grep:
[root@emu-5 net]# grep 8390.o /lib/modules/2.4.32/modules.dep
[root@emu-5 net]#

Exact list:
enable_irq
eth_type_trans
__kfree_skb
alloc_skb
ether_setup
crc32_le
kmalloc
cpu_raise_softirq
alloc_netdev
__out_of_line_bug
disable_irq_nosync
netif_rx
skb_over_panic
bitreverse
jiffies
softnet_data
prink
__const_udelay

Grepping 2 or 3:
[root@emu-5 net]# grep enable_irq /proc/ksyms
c010a5e0 enable_irq_R__ver_enable_irq
c0343610 matroxfb_enable_irq_R__ver_matroxfb_enable_irq
[root@emu-5 net]# grep printk /proc/ksyms
c011aee0 printk_R__ver_printk
[root@emu-5 net]# grep kmalloc /proc/ksyms
c0132c60 kmalloc_R__ver_kmalloc
c03c07e0 sock_kmalloc_R__ver_sock_kmalloc

binutils version: 2.15.92.0.2 20040927
gcc: 3.4.2 20041017

My .config can be found here:
http://www.andrew.cmu.edu/user/gnychis/.config

And I will try taking out CONFIG_MODVERSIONS support and let you know
how it goes!

By the way, i'm not keen on inserting 8390.o into the kernel, it was
simply the first thing i saw in my /lib/modules/2.4.32 directory, my
goal is to get any module at all to insert, because it seems none will
insert.

Thanks again!
George

Willy Tarreau wrote:
> On Sat, May 20, 2006 at 08:05:55PM -0400, George Nychis wrote:
>> Okay, so heres what I did.  I downloaded modutils version 2.4.27 and
>> extracted it to /usr/local/modutils
>>
>> Then in my 2.4.32 kernel's Makefile, I changed the DEPMOD variable to
>> point to /usr/local/modutils/sbin/depmod
>>
>> Then I build the kernel with:
>> make dep && make bzImage modules modules_install && make install
>>
>> So then my initrd gets generated, I reboot to the 2.4.32 kernel, and
>> thats where i'm at now.
>>
>> So then for instance I goto /lib/modules/2.4.32/net and do:
>> /usr/local/modutils/sbin/insmod 8390.o
>>
>> and I see all those unresolved symbols
> 
> Hmmm 8390.o needs crc32.o (or maybe you built it into your kernel).
> Could you please :
>   - grep 8390.o /lib/modules/2.4.32/modules.dep
>   - post the exact list of unresolved symbols that insmod outputs
>   - grep 2 or 3 of them in /proc/ksyms (eg: printk)
>   - post your .config so that we can find a way to reproduce your problem.
> 
>> So maybe now that you have more info, we can figure something out.
> 
> By the time you do this, it would also be interesting to retry without
> CONFIG_MODVERSIONS. Oh, and please report your gcc and binutils versions
> so that we can be as close as possible to your conditions when trying
> to reproduce.
> 
>> Thanks!
>> George
> 
> Regards,
> willy
> 
> 
