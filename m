Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269330AbSISNtx>; Thu, 19 Sep 2002 09:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269456AbSISNtx>; Thu, 19 Sep 2002 09:49:53 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:59653 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S269330AbSISNtw>; Thu, 19 Sep 2002 09:49:52 -0400
Date: Thu, 19 Sep 2002 15:54:40 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Rusty Russell <rusty@rustcorp.com.au>
cc: kaos@ocs.com.au, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] In-kernel module loader 1/7 
In-Reply-To: <20020919125906.21DEA2C22A@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0209191532110.8911-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 19 Sep 2002, Rusty Russell wrote:

> If every single object in the kernel is reference counted, *yes* you
> can do this.  But they're not, and they will never be.  Changing them
> over to use try_module_get() is feasible, though.

Rusty, slowly I'm pissed. :(
I already said often enough, a module has only to answer the simple
question: Is it safe to unload the module? Reference counts is the
simplest way, but I'm sure even you can come up with other methods.
On the other hand you force on _everyone_ to use try_module_get(), which
are nothing else than reference counts. As I already wrote in my last
mail:
This is simple resource management, everyone writing kernel code has to do
this anyway, adding modules to this picture doesn't change it much. As
long as you have control over all your objects, you also know easily
whether it's safe to unload or not, but only the driver knows this, the
module code can only guess or it has to be told explicitely via
try_module_get().
In other words: If you get it right with try_module_get(), you will more
easily get it right with reference counts.

bye, Roman


