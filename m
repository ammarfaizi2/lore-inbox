Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261272AbULEHUz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261272AbULEHUz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 02:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261273AbULEHUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 02:20:54 -0500
Received: from brown.brainfood.com ([146.82.138.61]:48019 "EHLO
	gradall.private.brainfood.com") by vger.kernel.org with ESMTP
	id S261272AbULEHU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 02:20:27 -0500
Date: Sun, 5 Dec 2004 01:20:14 -0600 (CST)
From: Adam Heath <doogie@debian.org>
X-X-Sender: adam@gradall.private.brainfood.com
To: Rudolf Usselmann <rudi@asics.ws>
cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9, 64bit, 4GB memory => panics ...
In-Reply-To: <1102230225.3778.75.camel@cpu0>
Message-ID: <Pine.LNX.4.58.0412050118230.2173@gradall.private.brainfood.com>
References: <1102072834.31282.1450.camel@cpu0>  <20041203113704.GD2714@holomorphy.com>
 <1102225183.3779.15.camel@cpu0>  <Pine.LNX.4.61.0412042321080.6378@montezuma.fsmlabs.com>
 <1102230225.3778.75.camel@cpu0>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Dec 2004, Rudolf Usselmann wrote:

> int mem[10000];
> int i, n;
>
> for(i=0;i<2000;i++) {
> 	printf("Doing alloc %0d ...\n",i);
> 	mem[i] = (int)malloc(1024*1024*1024);

allocate a 1 gig block, but store it in an int array?  That's wrong.

> 	if(mem[i] == NULL)
> 		printf("Malloc failed ...\n");
> 	else
> 		for(n=0;n<(1024*1024*1024);n=n+640)	mem[i] = n;

You alter n, but then always only set mem[i], without varying i.

Your program is buggy, and memleaks.

Plus, the kernel uses overcommit by default, and since you aren't actually
touching the memory you are allocating, you are only limited by the address
space size allowed per process(depends on how you configured the kernel).

