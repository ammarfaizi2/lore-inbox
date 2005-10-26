Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932554AbVJZGNw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932554AbVJZGNw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 02:13:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932557AbVJZGNw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 02:13:52 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:21408 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932554AbVJZGNv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 02:13:51 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: Alan Stern <stern@rowland.harvard.edu>
cc: Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Notifier chains are unsafe 
In-reply-to: Your message of "Mon, 24 Oct 2005 16:48:58 -0400."
             <Pine.LNX.4.44L0.0510241634410.4448-100000@iolanthe.rowland.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 26 Oct 2005 16:11:46 +1000
Message-ID: <7908.1130307106@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Oct 2005 16:48:58 -0400 (EDT), 
Alan Stern <stern@rowland.harvard.edu> wrote:
>Has anyone been bothered by the fact that notifier chains are not safe 
>with regard to registration and unregistration while the chain is in use?
>The notifier_chain_register and notifier_chain_unregister routines have 
>writelock protections, but the corresponding readlock is never taken!
>
>It shouldn't be hard to make this work safely, even allowing such things
>as notifier routines unregistering themselves as they run.  The patch
>below contains an example implementation, showing one way to do it.
>
>But doing this correctly requires knowing how notifier chains are used.  
>
>	Are they always called in process context, with interrupts enabled?
>
>	Or do some get called in interrupt context?

Register and unregister should only be called from contexts that can
sleep, although that may not be documented.  notifier_call_chain() can
be called in any context, it must not take any locks.

