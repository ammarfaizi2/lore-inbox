Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932338AbVIJWcj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338AbVIJWcj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 18:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932340AbVIJWcj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 18:32:39 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:57770 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S932338AbVIJWci
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 18:32:38 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [GIT PATCH] More PCI patches for 2.6.13
Date: Sat, 10 Sep 2005 23:32:54 +0100
User-Agent: KMail/1.8.90
Cc: Linus Torvalds <torvalds@osdl.org>, David Woodhouse <dwmw2@infradead.org>,
       Alan Stern <stern@rowland.harvard.edu>, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L0.0509101655520.7081-100000@netrider.rowland.org> <Pine.LNX.4.58.0509101410300.30958@g5.osdl.org> <43235707.7050909@pobox.com>
In-Reply-To: <43235707.7050909@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509102332.54619.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 10 September 2005 22:58, Jeff Garzik wrote:
> Linus Torvalds wrote:
> > Case closed.
> >
> > Bogus warnings are a _bad_ thing. They cause people to write buggy code.
> >
> > That drivers/pci/pci.c code should be simplified to not look at the error
> > return from pci_set_power_state() at all. Special-casing EIO is just
> > another bug waiting to happen.
>
> As a tangent, the 'foo is deprecated' warnings for pm_register() and
> inter_module_register() annoy me, primarily because they never seem to
> go away.
>
> The only user of inter_module_xxx is CONFIG_MTD -- thus the deprecated
> warning is useless to 90% of us, who will never use MTD.  As for
> pm_register(), there are tons of users remaining.  As such, for the
> forseeable future, we will continue to see pm_register() warnings and
> ignore them -- thus they are nothing but useless build noise.
>
> I've attached a patch, just tested, which addresses inter_module_xxx by
> making its build conditional on the last remaining user.  This solves
> the deprecated warning problem for most of us, and makes the kernel
> smaller for most of us, at the same time.

Though external modules using these functions will be hung out to dry. But 
only if you don't select CONFIG_MTD? That's not particularly intuitive.

It's better to mark it deprecated (which has been done), then officially 
remove it (and all in-tree users) once and for all. Compiling the code 
conditionally just to avoid a few warnings is a silly idea.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
