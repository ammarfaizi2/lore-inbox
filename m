Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265102AbUETN4V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265102AbUETN4V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 09:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265128AbUETN4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 09:56:21 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:7551 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S265102AbUETN4T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 09:56:19 -0400
Date: Thu, 20 May 2004 16:08:09 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "Jinu M." <jinum@esntechnologies.co.in>
Cc: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org,
       "Surendra I." <surendrai@esntechnologies.co.in>
Subject: Re: protecting source code in 2.6
Message-ID: <20040520140809.GA2228@mars.ravnborg.org>
Mail-Followup-To: "Jinu M." <jinum@esntechnologies.co.in>,
	linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org,
	"Surendra I." <surendrai@esntechnologies.co.in>
References: <1118873EE1755348B4812EA29C55A97222FD0E@esnmail.esntechnologies.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118873EE1755348B4812EA29C55A97222FD0E@esnmail.esntechnologies.co.in>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What we intend to do is, distribute the os interface module (osint.c)
> with
> source code and the device interface module as object code or library.
> The
> user will compile the os interface module on the target box and link it
> with the device interface module to generate the .ko (loadable module).
> 
> We are not very sure of how to achieve this. 
> Please help us address this issue.

Not a popolar topic on this mailing list..

>From a technical point of view what you need to do is simple.

You just need to distribute it as an external module, and provide the
dev.o file as part of this.
The dev.o file must be named 'dev.o_shipped'

Then you need a makefile like this:
obj-m := jinu.o
jinu-y := dev.o osinit.o

You can add a few more trick to enable use of plain make - see
article about external modules on the kernel page on lwn.net a few weeks ago.

What you need to compile the external module is simply:
make -C $KERNELSRC M=$PWD

Where KERNELSRC is a kernel with 'make module_prepare' executed.

	Sam
