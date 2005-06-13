Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261267AbVFMUKu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261267AbVFMUKu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 16:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261266AbVFMUKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 16:10:35 -0400
Received: from smtp-out2.blueyonder.co.uk ([195.188.213.5]:25222 "EHLO
	smtp-out2.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S261267AbVFMUJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 16:09:20 -0400
From: Edward Macfarlane Smith <snowfire@blueyonder.co.uk>
To: "Ilan S." <ilan_sk@netvision.net.il>
Subject: Re: 'hello world' module
Date: Mon, 13 Jun 2005 21:09:44 +0100
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <200506111511.02581.ilan_sk@netvision.net.il>
In-Reply-To: <200506111511.02581.ilan_sk@netvision.net.il>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506132109.46012.snowfire@blueyonder.co.uk>
X-OriginalArrivalTime: 13 Jun 2005 20:09:54.0997 (UTC) FILETIME=[DD753650:01C57053]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 11 June 2005 13:11, Ilan S. wrote:
> Hello dear professionals!
>
> I would be very thankful if anybody prompt me what's wrong.
> I'm trying to build the "Hello world" module from O'Reilly's "Linux device
> drivers" and that is what I get:
>
> [ilanso@Netvision Kernel]$ make -C /home/ilanso/src/linux-2.6.11.11 M=`pwd`
> make: Entering directory `/home/ilanso/src/linux-2.6.11.11'
>   Building modules, stage 2.
>   MODPOST
> make: Leaving directory `/home/ilanso/src/linux-2.6.11.11'
> [ilanso@Netvision Kernel]$ ls
> hello.c  Makefile
> [ilanso@Netvision Kernel]$
>

Hi Ilan,
I've been working through this book too, not sure why it's not working for 
you. Have you actually built the kernel in the directory you're pointing it 
at? I was able to use the command:
make -C /usr/src/linux M=`pwd`
where my Makefile had
        obj-m := eaglenet.o
The makefile I've generally used that works fine (so you can just type make) 
was:
ifneq ($(KERNELRELEASE),)
        obj-m := eaglenet.o
else
        KERNELDIR ?= /lib/modules/$(shell uname -r)/build
        PWD := $(shell pwd)

default:
        $(MAKE) -C $(KERNELDIR) M=$(PWD) modules

endif
Where my module was eaglenet.
Regards,
Edward
