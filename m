Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316258AbSEVRHG>; Wed, 22 May 2002 13:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316260AbSEVRHF>; Wed, 22 May 2002 13:07:05 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:29188 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S316258AbSEVRHE>; Wed, 22 May 2002 13:07:04 -0400
Subject: Re: multithreaded device driver
To: zwane@linux.realnet.co.sz (Zwane Mwaikambo)
Date: Wed, 22 May 2002 18:26:54 +0100 (BST)
Cc: lylai@csie.nctu.edu.tw (lylai),
        linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <Pine.LNX.4.44.0205221829430.23578-100000@netfinity.realnet.co.sz> from "Zwane Mwaikambo" at May 22, 2002 06:31:27 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17AZt0-0002Il-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On 23 May 2002, lylai wrote:
> > Does linux kernel provide kernel level thread headers that I can use to
> > write a multithreaded device driver?
> > 
> > Do I need to program a device driver to be multithreaded to achieve
> > paralle I/O?
> > 
> > Thank you for your help.
> 
> Worth looking at linux/drivers/net/8139too.c, that uses threads. Other 
> methods of offloading work from a central point like an ISR could be done 
> with Bottom Halves (tasklets) but that won't be parallelised.

Generally speaking you want to avoid threads for anything which is not
fantastically slow, polled and messy. Any normal code path wants to be in
the ISR handlers and when it has to deal with state coded properly as
state machines.
