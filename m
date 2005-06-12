Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261478AbVFLGtI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261478AbVFLGtI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 02:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261888AbVFLGtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 02:49:08 -0400
Received: from ozlabs.org ([203.10.76.45]:59336 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261478AbVFLGtE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 02:49:04 -0400
Subject: Re: Race condition in module load causing undefined symbols
From: Rusty Russell <rusty@rustcorp.com.au>
To: Stephen Lord <lord@xfs.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <42A99D9D.7080900@xfs.org>
References: <42A99D9D.7080900@xfs.org>
Content-Type: text/plain
Date: Sun, 12 Jun 2005 16:49:02 +1000
Message-Id: <1118558942.31631.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-06-10 at 09:03 -0500, Stephen Lord wrote:
> Hi,
> 
> I am having troubles getting any recent kernel to boot successfully
> on one of my machines, a generic 2.6GHz P4 box with HT enabled
> running an updated Fedora Core 3 distro. This is present in
> 2.6.12-rc6. It does not manifest itself with the Fedora Core
> kernels which have identical initrd contents as far as the
> init script and the set of modules included goes.
> 
> The problem manifests itself as various undefined symbols from
> module loads.  Here is the relevant section from the init script

Module loading is synchronous.  All I can think of is that a module is
pulling in another module which requires it asynchronously (you need to
do this because your own module symbols are not available until *after*
init succeeds), or a hotplug interaction (hotplug is async, too).

Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

