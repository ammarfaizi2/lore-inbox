Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263313AbSKTX0G>; Wed, 20 Nov 2002 18:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263760AbSKTX0F>; Wed, 20 Nov 2002 18:26:05 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:44303 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S263313AbSKTXZi>; Wed, 20 Nov 2002 18:25:38 -0500
Date: Thu, 21 Nov 2002 00:32:40 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Petr Vandrovec <vandrove@vc.cvut.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] module fs or how to not break everything at once
In-Reply-To: <20021120220338.GA6079@vana>
Message-ID: <Pine.LNX.4.44.0211210014500.2113-100000@serv>
References: <Pine.LNX.4.44.0211202013000.2113-100000@serv> <20021120220338.GA6079@vana>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 20 Nov 2002, Petr Vandrovec wrote:

> ... now when we have setxattr() in kernel, what about using
> setxattr() on module directory instead of separate control file? 
> I know, you cannot manage it with "echo" then, but it looks

A normal file is easier for testing.

> strange that mkdir automatically creates control file while
> rmdir does not remove it automatically... and without control

Indeed, rmdir should probably also remove the control file.

> You are skipping security_ops hooks. Can you use vfs_mkdir() instead
> of modfs_mkdir(), just to make sure that if someone adds some new
> features into vfs_mkdir(), you'll not miss them ?

The system calls are only a temporary solution, so skipping security hooks 
is no real loss. :)

> And one minor comment: do you really need both module_dir->module
> and module_data->module? Do you use it only to make sure that
> sys_delete_module will not operate on modules not created by
> sys_init_module? 

module_dir->module is an optimization to get quickly to the module file 
created by sys_create_module(). module_data->module is the pointer to the 
real module data.

> It has unfortunate feature that sys_create_module(); 
> sys_delete_module() (without suceeding sys_init_module between
> them) will return -ENOENT, and you'll have to use rm/rmdir to get 
> rid of module :-(

As the system calls are only temporary, they don't have to be perfect, but 
why should it return -ENOINT, AFAICS it should fail for other reason.
Anyway, the module state management needs a overhaul, this is just a 
copy&paste from the old code.

bye, Roman

