Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268108AbUIPOkJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268108AbUIPOkJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 10:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268117AbUIPOho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 10:37:44 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:15046 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268108AbUIPOeP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 10:34:15 -0400
Subject: Re: Having problem with mmap system call!!!
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: root@chaos.analogic.com
Cc: "Srinivas G." <srinivasg@esntechnologies.co.in>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.53.0409160958070.12146@chaos>
References: <4EE0CBA31942E547B99B3D4BFAB348111078FE@mail.esn.co.in>
	 <Pine.LNX.4.53.0409160958070.12146@chaos>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1095341494.22744.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 16 Sep 2004 14:31:36 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-09-16 at 15:07, Richard B. Johnson wrote:
>     if((vp = mmap((caddr_t) HINT, len, PROT, FLAGS, fd, addr)) == SHM_FAIL)
>     {
>         fprintf(stderr, "Can't access shared memory\n");
>         exit(EXIT_FAILURE);

SHM_FAIL is the wrong error check btw.

It is much better to do this in the driver than do nasty user mode hacks
using /dev/mem. When you do it kernel driver side you end up with a
cleaner mmap interface, a sensible permissions model and the hardware
device pages mapped directly and nicely into the app

