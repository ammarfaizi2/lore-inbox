Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265951AbUEUWmU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265951AbUEUWmU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 18:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264828AbUEUWlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 18:41:10 -0400
Received: from denise.shiny.it ([194.20.232.1]:52189 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id S266030AbUEUWdi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 18:33:38 -0400
Date: Thu, 20 May 2004 16:08:31 +0200 (CEST)
From: Giuliano Pochini <pochini@denise.shiny.it>
To: "Jinu M." <jinum@esntechnologies.co.in>
cc: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org,
       "Surendra I." <surendrai@esntechnologies.co.in>
Subject: Re: protecting source code in 2.6
In-Reply-To: <1118873EE1755348B4812EA29C55A97222FD0E@esnmail.esntechnologies.co.in>
Message-ID: <Pine.LNX.4.58.0405201544480.16114@denise.shiny.it>
References: <1118873EE1755348B4812EA29C55A97222FD0E@esnmail.esntechnologies.co.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 20 May 2004, Jinu M. wrote:

> We are developing a block device driver on linux-2.6.x kernel. We want
> to distribute our driver as sum of source code and librabry/object code.
>
> We have divided the source code into two parts. The os interface module
> and the device interface module. The os interface module (osint.c) has
> all the os interface functions (init, exit, open, close, ioctl, request
> queue handling etc). The device interface module (devint.c) on the other
> hand has all the device interface functions (initialize device, read,
> write etc), these don't use system calls or kernel APIs.
>
> The device interface module is proprietary source and we don't intend to
> distribute it with source code on GPL license.

Kernel-space software that is not open source is a problems source. There
are many example around.


> What we intend to do is, distribute the os interface module (osint.c) with
> source code and the device interface module as object code or library.
> The user will compile the os interface module on the target box and link it
> with the device interface module to generate the .ko (loadable module).
>
> We are not very sure of how to achieve this.

It's simple. Just create the devint.o object file for all the supported
architectures multiplied by two or three different gcc revisions
(because of ABI changes, which are arch-dependent). Then the Makefile
has to compile osint.c and link it to the .o . The only difference is
that the Makefile skips the compilation of devint.c .

Out of curiosity, why the driver code must be top secret ?


--
Giuliano.
