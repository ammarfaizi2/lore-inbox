Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267034AbSKSSH0>; Tue, 19 Nov 2002 13:07:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267039AbSKSSH0>; Tue, 19 Nov 2002 13:07:26 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:58023 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id <S267034AbSKSSHZ>;
	Tue, 19 Nov 2002 13:07:25 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Jeff Garzik <jgarzik@pobox.com>
Date: Tue, 19 Nov 2002 19:14:07 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [PATCH] mii module broken under new scheme
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au, arashi@arashi.yi.org
X-mailer: Pegasus Mail v3.50
Message-ID: <7FA0E2B042A@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Nov 02 at 12:51, Jeff Garzik wrote:
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

Rusty told me that it is intentional. Add

no_module_init;

at the end of module. He even sent patch which fixes dozen of such
modules (15 I had on my system...) to Linus, but it get somehow lost.

Only question is whether we want to have it this way or no. And if
yes, whether we do not want to move no_module_init from linux/init.h to 
linux/module.h: all of affected modules were already including
module.h to get MODULE_LICENSE() & other, but almost none of them
included init.h.
                                        Petr Vandrovec
                                        vandrove@vc.cvut.cz
                                        
