Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264922AbUFLVAo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264922AbUFLVAo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 17:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264923AbUFLVAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 17:00:43 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:49704 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S264922AbUFLVA3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 17:00:29 -0400
Date: Sat, 12 Jun 2004 23:08:20 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andi Kleen <ak@muc.de>
Cc: Steve Hemond <steve.hemond@sympatico.ca>, linux-kernel@vger.kernel.org
Subject: Re: Inserting a module (2.6 kernel)
Message-ID: <20040612210820.GA2405@mars.ravnborg.org>
Mail-Followup-To: Andi Kleen <ak@muc.de>,
	Steve Hemond <steve.hemond@sympatico.ca>,
	linux-kernel@vger.kernel.org
References: <24Zio-6xX-3@gated-at.bofh.it> <m3oentkqpd.fsf@averell.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3oentkqpd.fsf@averell.firstfloor.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2004 at 11:47:58AM +0200, Andi Kleen wrote:
> 
> Now since 2.6.5 or so it needs: 
> 
> /* MODULE is not needed anymore */
> #define __KERNEL__1 
> #include <linux/module.h>
> 
> int init_module(void)
> {
>         printk("Hello world\n");
>         return 0;
> }
> 
> struct module __this_module
> __attribute__((section(".gnu.linkonce.this_module"))) = {
>         .name = "hello",
>         .init = init_module,
> };

Most of the glue above can be deleted if you just accept to use kbuild when
building modules.
So to compile your module use a simple Makefile:
obj-m := mymodule.o

Then to compile the module use:
make -C path/to/kernel/src M=`pwd`

And to install it use:
make -C path/to/kernel/src M=`pwd` modules_install

And to clean up in the directory where the module is being compiled:
make -C path/to/kernel/src M=`pwd` clean

	Sam
