Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267327AbUJBHDW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267327AbUJBHDW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 03:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267326AbUJBHDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 03:03:22 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:33594 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S267327AbUJBHDU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 03:03:20 -0400
Date: Sat, 2 Oct 2004 11:04:09 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andre Bonin <kernel@bonin.ca>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Module building oddities with <module>-objs under Kernel 2.6.8.1
Message-ID: <20041002090409.GA9043@mars.ravnborg.org>
Mail-Followup-To: Andre Bonin <kernel@bonin.ca>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <415E3912.3000900@bonin.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <415E3912.3000900@bonin.ca>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 02, 2004 at 01:13:54AM -0400, Andre Bonin wrote:
> Here is the Makefile.

It is preferred to guard the kbuild specific stuff inside
ifeq ($(KERNELRELEASE),)
Normal stuff
else
kbuild stuff
endif

> ----------------------------------------------------
> KDIR         := /usr/src/linux
> PWD          := $(shell pwd)
> 
> obj-m        += datasim.o
> datasim-objs := status.o
This is wrong, you cannot use same name for a .o file and the final module.

Name your .c file datasim_core.c or similar and use:
obj-m        := datasim.o
datasim-objs := datasim_core.o status.o

	Sam
