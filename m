Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750770AbVKRC7E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbVKRC7E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 21:59:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbVKRC7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 21:59:04 -0500
Received: from smtp.osdl.org ([65.172.181.4]:14233 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750770AbVKRC7D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 21:59:03 -0500
Date: Thu, 17 Nov 2005 18:55:29 -0800
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] mark virt_to_bus/bus_to_virt as __deprecated on
 i386
Message-Id: <20051117185529.31d33192.akpm@osdl.org>
In-Reply-To: <20051118024433.GN11494@stusta.de>
References: <20051118014055.GK11494@stusta.de>
	<20051117175015.6aa99fcf.akpm@osdl.org>
	<20051118020640.GM11494@stusta.de>
	<20051117182047.5fe1a5eb.akpm@osdl.org>
	<20051118024433.GN11494@stusta.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
>
> > 
> > I believe that the main reason for this is that the developers simply don't
> > notice the new warning amongst all the noise.
> 
> There are few areas in the kernel that spit that many warnings that you 
> might not see new ones .
> 
> The developers not noticing the warnings might often be the same 
> developers who send patches that don't compile...

Some architectures generate a lot more warnings than x86.

> > > If you dislike the warnings, you could move the whole __deprecated und a 
> > > config option.
> > > 
> > > In the case of virt_to_bus/bus_to_virt I had the hope that e.g. the ATM 
> > > drivers that seem to have an active maintainer might get fixed.
> > 
> > That would be good - but perhaps a better approach would be to send pointed
> > emails to the maintainer.  Or to merge lameo patches to remove
> > virt_to_bus() so he has to fix it for real ;)
> 
> In the case of virt_to_bus/bus_to_virt there are stil many places in the 
> kernel using it, and several of them are well maintained.
> 
> IMHO the warnings are the best solution for getting a vast amount fixed, 
> and then it's time to think about the rest.

But the warnings don't *work*.  I'm *still* staring at stupid pm_register
and intermodule_foo warnings.  How long has that been?

> > > But I'm not religious regarding this issue as long as you accept my 
> > > -Werror-implicit-function-declaration patch...
> > 
> > Problem is, I'm the sucker who takes the brunt of that change.  It'd be
> > best to fix up the warnings _before_ adding the make-it-break patch.
> 
> -Werror-implicit-function-declaration doesn't add new warnings, it turns 
> a specific kind of warnings that can indicate nasty runtime errors into 
> compile errors.

I know, that's why the patch hurts so much.  As I say, we'd be better off
fixing up all the warnings we can before turning them into build errors.

