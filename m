Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261154AbVFJSZm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbVFJSZm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 14:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261163AbVFJSZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 14:25:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:34721 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261154AbVFJSZf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 14:25:35 -0400
Date: Fri, 10 Jun 2005 11:25:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: Stephen Lord <lord@xfs.org>
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: Race condition in module load causing undefined symbols
Message-Id: <20050610112515.691dcb6e.akpm@osdl.org>
In-Reply-To: <42A99D9D.7080900@xfs.org>
References: <42A99D9D.7080900@xfs.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Lord <lord@xfs.org> wrote:
>
> I am having troubles getting any recent kernel to boot successfully
>  on one of my machines, a generic 2.6GHz P4 box with HT enabled
>  running an updated Fedora Core 3 distro. This is present in
>  2.6.12-rc6. It does not manifest itself with the Fedora Core
>  kernels which have identical initrd contents as far as the
>  init script and the set of modules included goes.
> 
>  The problem manifests itself as various undefined symbols from
>  module loads.

Peculiar.  Module loading is all synchronous, isn't it?

> ...
>  The failures are different on different boots, sometimes the ata_piix
>  module cannot find symbols from libata, sometimes ext3 cannot find jbd
>  symbols, sometimes dm modules cannot find things from dm-mod, usually
>  it is a combination of these. End result is a panic when it cannot
>  find the root device.
> 
>   From the behavior, it appears that a module load is returning
>  control to user space before the previous one has got its symbols
>  loaded.

I wonder if rather than the intermittency being time-based, it is
load-address-based?  For example, suppose there's a bug in the symbol
lookup code?

Have you tried using a different gcc version?
