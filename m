Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268026AbUIGNQ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268026AbUIGNQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 09:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268036AbUIGNOm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 09:14:42 -0400
Received: from mail.dif.dk ([193.138.115.101]:10952 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S268041AbUIGNKg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 09:10:36 -0400
Date: Tue, 7 Sep 2004 15:08:38 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Con Kolivas <kernel@kolivas.org>
Cc: arjanv@redhat.com,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: attribute warn_unused_result
In-Reply-To: <413DAD07.3030306@kolivas.org>
Message-ID: <Pine.LNX.4.61.0409071505210.28819@jjulnx.backbone.dif.dk>
References: <413DAD07.3030306@kolivas.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Sep 2004, Con Kolivas wrote:

> Date: Tue, 7 Sep 2004 14:43:51 +0200 
> From: Con Kolivas <kernel@kolivas.org>
> To: arjanv@redhat.com
> Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
>     Andrew Morton <akpm@osdl.org>
> Subject: Re: attribute warn_unused_result
> 
> Arjan van de Ven wrote:
> > On Tue, 2004-09-07 at 14:23, Con Kolivas wrote:
> > 
> >>Gcc3.4.1 has recently been complaining of a number of unused results 
> >>from function with attribute warn_unused_result set. I'm not sure of
> how 
> >>you want to tackle this so I'm avoiding posting patches. Should we 
> >>remove the attribute (seems the likely option) or set some dummy 
> >>variable (sounds stupid now that I ask it).
> > 
> > 
> > that attribute is supposed to only be set for functions you really
> ought
> > to check the result for.... so how about checking/using the result ?
> I understand the concept... these are functions that seem to work fine 
> without using the return value... unless of course the original coders 
> aren't yet aware of that fact then I'm sorry. Here's the list just with 
> my config on 2.6.9-rc1-bk13:
> fs/binfmt_elf.c: In function `padzero':
> fs/binfmt_elf.c:113: warning: ignoring return value of `clear_user', 
> declared with attribute warn_unused_result
> include/asm/uaccess.h: In function `create_elf_tables':
> fs/binfmt_elf.c:175: warning: ignoring return value of `__copy_to_user',
> 
> declared with attribute warn_unused_result
> fs/binfmt_elf.c:273: warning: ignoring return value of `copy_to_user', 
> declared with attribute warn_unused_result
> fs/binfmt_elf.c: In function `load_elf_binary':
> fs/binfmt_elf.c:750: warning: ignoring return value of `clear_user', 
> declared with attribute warn_unused_result
> fs/binfmt_elf.c: In function `fill_psinfo':
> fs/binfmt_elf.c:1216: warning: ignoring return value of 
> `copy_from_user', declared with attribute warn_unused_result

Just a small FYI
I'm currently working on a patch to attempt to fix these up in 
binfmt_elf.c expect that to apear on the list within ~24hrs.

copy_to_user and clear_user can fail, and if they do appropriate action 
needs to be taken (probably returning a fault, a short read or similar) - 
not checking the return value and not taking any action is an error as I 
see it.


--
Jesper Juhl <juhl-lkml@dif.dk>
