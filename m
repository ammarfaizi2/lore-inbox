Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261714AbVAXWuE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261714AbVAXWuE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 17:50:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261707AbVAXWr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 17:47:29 -0500
Received: from mail.ocs.com.au ([202.147.117.210]:7109 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S261712AbVAXWod (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 17:44:33 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: davidm@hpl.hp.com
Cc: bgerst@didntduck.org, Terence Ripperda <tripperda@nvidia.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: inter_module_get and __symbol_get 
In-reply-to: Your message of "Mon, 24 Jan 2005 14:36:10 -0800."
             <16885.30810.787188.591830@napali.hpl.hp.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 25 Jan 2005 09:44:18 +1100
Message-ID: <30494.1106606658@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jan 2005 14:36:10 -0800, 
David Mosberger <davidm@napali.hpl.hp.com> wrote:
>Keith,
>
>I didn't see any followup to your message.  My apologies if I missed
>something.
>
>You wrote:
>
> Keith> inter_module_* and __symbol_* solve these class of problems:
>
> Keith> Module A can use module B if B is loaded, but A does not
> Keith> require module B to do its work.  B is optional.
>
> Keith> The kernel can use code in module C is C is loaded, but the
> Keith> base kernel does not require module C.  C is optional.
>
>Why isn't this handled via weak references?  If the reference comes
>out as 0, you know the underlying module/facility isn't there and
>proceed accordingly.

Weak references are only done once, when the module is loaded.  We
already use weak references for static determination of symbol
availability.  inter_module_* and __symbol_* are aimed at the dynamic
reference problem, not static.

Module A can use module B if B is loaded, but A does not require module
B to do its work.  B can be loaded at any time, or even unloaded at any
time, although that is much rarer.  Dynamic references require a
register/unregister style interface, thus inter_module_* and
__symbol_*.

Does the kernel code really need optional dynamic references between
modules or kernel -> modules?  That depends on how people code their
modules.  If the rest of the kernel no longer needs dynamic symbol
reference then drop inter_module_* and __symbol_*.

