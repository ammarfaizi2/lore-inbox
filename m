Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932160AbWA3JYF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbWA3JYF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 04:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932161AbWA3JYF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 04:24:05 -0500
Received: from dsl092-035-012.lax1.dsl.speakeasy.net ([66.92.35.12]:44995 "EHLO
	arrau.morison.org") by vger.kernel.org with ESMTP id S932160AbWA3JYD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 04:24:03 -0500
Message-ID: <20060130012402.7lz1zujtkpc8cgco@webmail.morison.biz>
Date: Mon, 30 Jan 2006 01:24:02 -0800
From: Rod Morison <rod@morison.biz>
To: WSteffen <wsteffen@comcast.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: IRQ problems??
References: <43D55EC9.10605@comcast.net>
In-Reply-To: <43D55EC9.10605@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	DelSp="Yes";
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) H3 (4.2-cvs)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the same amount of reply when I posted a similar problem  
("mptable irq info wrong on Tyan S5112, need advice") a few days  
before you.

What I have debugged is (for the 2.4 kernel) the motherboard IRQ  
tables that are passed to the kernel via mpparse.c are dead wrong. In  
my case, I was able to hack the kernel and hunt down the correct  
interrupt. I'm actually surprised that there aren't more systematic  
IRQ debug utilities out there in the Linux world, given how many  
problems go unsolved across many lists.

I'm trying to build a small knowledge base on this breed of problem  
(bad IRQ assignments due to motherboard snafus). I've got a couple  
writeups in the works, but the first is about a very useful utility  
that dumps the mobo IRQ info (the mptable data, to be specific):  
http://www.morison.biz/technotes/articles/view.php/12

Rod



Quoting WSteffen:

> I am working with an HP Pavilion a1210n the mother board is
> an ASUS A8AE-LE, which has an ATI IXP SB440 and a Realtek
> ethernet controller. The processor is an AMD Athlon 64 3500+.
> The USB controllers will not function unless ACPI is enabled
> in the kernel.
> If ACPI is enabled in the kernel the realtek ethernet is not
> usable. If I do a ping to a working device on the same net,
> I can see ARP requests going out and replies coming back.
> However I get "host unreachable" error messages.
> When looking at the interrupts in each case it appears to me
> that there is an IRQ assignment problem. (my guess is the
> Realtek driver) or is there something I am doing wrong??
> Below are the contents of /proc/interrupts:
>
> With ACPI set:
>          CPU0
>   0:     135197          XT-PIC  timer
>   1:        315          XT-PIC  i8042
>   2:          0          XT-PIC  cascade
>   5:          8          XT-PIC  eth1
>   7:          0          XT-PIC  parport0
>   9:          3          XT-PIC  acpi
>  11:        208          XT-PIC  libata, ehci_hcd:usb1, ohci_hcd:usb2,
> ohci_hcd:usb3, eth0
>  12:       5202          XT-PIC  i8042
>  15:       4451          XT-PIC  ide1
> NMI:          0
> ERR:          0
>
>  	CPU0
>   0:      37706          XT-PIC  timer
>   1:        225          XT-PIC  i8042
>   2:          0          XT-PIC  cascade
>   5:          8          XT-PIC  eth1
>  10:          6          XT-PIC  eth0
>  11:          2          XT-PIC  libata
>  12:        110          XT-PIC  i8042
>  15:       4398          XT-PIC  ide1
> NMI:          0
> ERR:          0
>
> With ACPI not set:
>
> If there is something I am doing wrong, please let me know!!
>
> Thanks
> Warren Steffen
> wsteffen@comcast.net
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


