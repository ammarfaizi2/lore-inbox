Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267036AbSKSSHL>; Tue, 19 Nov 2002 13:07:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267034AbSKSSHL>; Tue, 19 Nov 2002 13:07:11 -0500
Received: from x101-201-249-dhcp.reshalls.umn.edu ([128.101.201.249]:2944 "EHLO
	arashi.yi.org") by vger.kernel.org with ESMTP id <S267036AbSKSSHK>;
	Tue, 19 Nov 2002 13:07:10 -0500
Date: Tue, 19 Nov 2002 12:15:21 -0600
From: Matt Reppert <arashi@arashi.yi.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: [PATCH] mii module broken under new scheme
Message-Id: <20021119121521.3789388a.arashi@arashi.yi.org>
In-Reply-To: <3DDA7A30.4010403@pobox.com>
References: <20021119115041.11ece7dc.arashi@arashi.yi.org>
	<3DDA7A30.4010403@pobox.com>
Organization: Yomerashi
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-message-flag: : This mail sent from host minerva, please respond.
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Nov 2002 12:51:44 -0500
Jeff Garzik <jgarzik@pobox.com> wrote:

> Matt Reppert wrote:
> 
> > drivers/net/mii.c doesn't export module init/cleanup functions. That 
> > means it
> > can't be loaded under the new module scheme. This patch adds do-nothing
> > functions for it, which allows it to load. (8139too depends on mii, so
> > without this I don't have network.)
> 
> ahhh!   I was wondering what was up, but since I was busy with other 
> things I just compiled it into the kernel and continued on my way.
> 
> That's a bug in the new module loader.

Not so sure I agree ... recompiled the kernel with debugging output in
module.c and when I try to insert mii.o without above patch it complains
"Module has no name!" and returns -ENOEXEC from the syscall. I think
naming mii.o would be a good idea. This may not be the best way to do
it, but it works. (Granted, I'm not terribly familiar with all the
modules code changes yet, but ... ) Having anonymous output in lsmod
would be somewhat confusing :) ("Well, whatever it is, 8139too needs
it, don't touch it!")

Just noticed above patch is -p0. Whoops.

Matt
