Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129454AbQKFRe0>; Mon, 6 Nov 2000 12:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129649AbQKFReQ>; Mon, 6 Nov 2000 12:34:16 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:30294 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129454AbQKFReA>; Mon, 6 Nov 2000 12:34:00 -0500
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page]
To: alonz@usa.net (Alon Ziv)
Date: Mon, 6 Nov 2000 17:34:30 +0000 (GMT)
Cc: dwmw2@infradead.org (David Woodhouse), linux-kernel@vger.kernel.org
In-Reply-To: <03da01c04816$8b178a30$650201c0@guidelet> from "Alon Ziv" at Nov 06, 2000 07:25:22 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13sqAB-0006RI-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 1. Before auto-unload of the driver, run a small utility which will read
> mixer settings
>    and save them somewhere
> 2. When auto-loading the driver, use driver arguments which are initialized
> from the
>    settings saved above
> All that's missing is the method of passing data from step 1 to step 2.

A simple more generic solution is to do this


struct things_to_keep my_bits
{
	..
};

struct things_to_keep __persistent card_info[NUM_CARDS]
{
}

and have insmod do

	load module up
	open /var/run/moduledata/$modname
	if exists && is from this boot then && is right size
		read data into __persistent ELF section
	endif
	load into kernel
	init module

and rmmod
	cleanup module
	open /var/run/moduledata/$modname
	write data from __persistent segment into file
	
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
