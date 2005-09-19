Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750781AbVISLaW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbVISLaW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 07:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750818AbVISLaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 07:30:21 -0400
Received: from nproxy.gmail.com ([64.233.182.198]:38600 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750781AbVISLaV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 07:30:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WD9722iYInGXiWZkG2bHP9OpMsmvzPcioTxDWdJK+JBuDrd4Ko8hCzF744qwLgPYDD+lYnxLRYfRHqMc4ukn24uibkeYdlwPCkGCSQ0SdBvmbLmkUVjI/Pk8pIqhTIA2af5FrTT9tspXQK2gQIfs1+I7rEM0GPNo81rphva0mNE=
Message-ID: <2cd57c90050919043041ed5cc@mail.gmail.com>
Date: Mon, 19 Sep 2005 19:30:19 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: coywolf@gmail.com
To: Ustyugov Roman <dr_unique@ymg.ru>
Subject: Re: [BUG] module-init-tools
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200509191432.58736.dr_unique@ymg.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200509191432.58736.dr_unique@ymg.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/19/05, Ustyugov Roman <dr_unique@ymg.ru> wrote:
> Hello!
> 
> I found a bug in module-init-tools.
> 
> 'lsmod' shows a wrong module name, when module name complied with some
> "define" at one of kernel header files.
> 
> For example,
> 
> File "current.c"
> =======================
> #include <linux/kernel.h>
> #include <linux/module.h>
> 
> int init_module(void) {
> 
>   return 0;
> }
> 
> void cleanup_module() {
> }
> 
> MODULE_LICENSE("GPL");
> =======================
> 
> Makefile:
> 
> =======================
> obj-m += current.o
> =======================
> 
> Make this module and type commands:
> 
> insmod current.ko
> lsmod
> 
> And we can see:
> 
> Module Size Used by
> get_current() 1152 0 <---- Oops, must be 'current'
> smbfs 61432 2
> hfsplus 56708 0
> nls_cp866 5120 1
> nls_iso8859_1 4096 0
> nls_cp437 5760 0
> vfat 12800 0
> fat 37916 1 vfat
> nls_utf8 2048 1
>   .....
> 
> File <asm/current.h>:
> 
> ===================
>   ...
> #define current get_current()
>   ...
> ===================
> 
> Try to remove module:
> 
> romanu:/current # rmmod current
> ERROR: Module current does not exist in /proc/modules
> romanu:/current # rmmod -v "get_current()"
> rmmod get_current(), wait=no
> romanu:/current #
> 
> I can't remove module with 'rmmod current',
> but can with
> rmmod "get_current()"
> 
> Is it a bug?

Yes, it's a bug. But it's a bad idea too to use well known kernel
symbols as module names.
-- 
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
