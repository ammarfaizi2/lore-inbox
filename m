Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267048AbSKSSPW>; Tue, 19 Nov 2002 13:15:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267050AbSKSSPW>; Tue, 19 Nov 2002 13:15:22 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:424 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id <S267048AbSKSSPU>;
	Tue, 19 Nov 2002 13:15:20 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Matt Reppert <arashi@arashi.yi.org>
Date: Tue, 19 Nov 2002 19:21:54 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [PATCH] mii module broken under new scheme
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au, jgarzik@pobox.com
X-mailer: Pegasus Mail v3.50
Message-ID: <7FA2FEC6B51@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Nov 02 at 12:15, Matt Reppert wrote:
> On Tue, 19 Nov 2002 12:51:44 -0500
> Jeff Garzik <jgarzik@pobox.com> wrote:
> 
> > Matt Reppert wrote:
> > 
> > > drivers/net/mii.c doesn't export module init/cleanup functions. That 
> > > means it
> > > can't be loaded under the new module scheme. This patch adds do-nothing
> > > functions for it, which allows it to load. (8139too depends on mii, so
> > > without this I don't have network.)
> > 
> > ahhh!   I was wondering what was up, but since I was busy with other 
> > things I just compiled it into the kernel and continued on my way.
> > 
> > That's a bug in the new module loader.
> 
> Not so sure I agree ... recompiled the kernel with debugging output in
> module.c and when I try to insert mii.o without above patch it complains
> "Module has no name!" and returns -ENOEXEC from the syscall. I think
> naming mii.o would be a good idea. This may not be the best way to do
> it, but it works. (Granted, I'm not terribly familiar with all the
> modules code changes yet, but ... ) Having anonymous output in lsmod
> would be somewhat confusing :) ("Well, whatever it is, 8139too needs
> it, don't touch it!")

I think that retrieving module name from module's binary is wrong: I
need to have dummy.o (network driver) insmodded two times to get my
test environment up. 

I do not think that it is correct that I must add multiple device support 
to the dummy due to new module loader, and creating two dummy.o,
with different .modulename sections, also does not look like reasonable
solution to me.
                                            Best regards,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz

