Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267130AbSKSSaQ>; Tue, 19 Nov 2002 13:30:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267129AbSKSSaP>; Tue, 19 Nov 2002 13:30:15 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27908 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267130AbSKSSaO>;
	Tue, 19 Nov 2002 13:30:14 -0500
Message-ID: <3DDA84D2.5050009@pobox.com>
Date: Tue, 19 Nov 2002 13:37:06 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Reppert <arashi@arashi.yi.org>
CC: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: [PATCH] mii module broken under new scheme
References: <20021119115041.11ece7dc.arashi@arashi.yi.org>	<3DDA7A30.4010403@pobox.com> <20021119121521.3789388a.arashi@arashi.yi.org>
In-Reply-To: <20021119115041.11ece7dc.arashi@arashi.yi.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Reppert wrote:

> On Tue, 19 Nov 2002 12:51:44 -0500
> Jeff Garzik  wrote:
>
>
> >Matt Reppert wrote:
> >
> >
> >>drivers/net/mii.c doesn't export module init/cleanup functions. That
> >>means it


> >ahhh!   I was wondering what was up, but since I was busy with other
> >things I just compiled it into the kernel and continued on my way.
> >
> >That's a bug in the new module loader.
>
>
> Not so sure I agree ... recompiled the kernel with debugging output in
> module.c and when I try to insert mii.o without above patch it complains
> "Module has no name!" and returns -ENOEXEC from the syscall. I think
> naming mii.o would be a good idea. This may not be the best way to do
> it, but it works. (Granted, I'm not terribly familiar with all the
> modules code changes yet, but ... ) Having anonymous output in lsmod
> would be somewhat confusing :) ("Well, whatever it is, 8139too needs
> it, don't touch it!")



Your patch is fine to get people going... I'm glad you posted it on lkml 
for others to benefit.

However, for inclusion in the kernel, it is not needed.  Quite simply, 
mii.c is essentially a library, and it needs absolutely no 
initialization nor cleanup at all.  Thus, it is a bug in the module 
loader that any code changes at all are required.

There exists a no_module_init tag, which is in theory the proper fix for 
this problem under rusty's system, but that is itself a bug:  it's 
redundant just like the silly EXPORT_NO_SYMBOLS tag -- it's stating the 
obvious.  The module loader needs to notice a lack of init_module and 
exit_module and handle it accordingly.

	Jeff



