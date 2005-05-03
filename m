Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261247AbVECAY7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261247AbVECAY7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 20:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbVECAY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 20:24:59 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31895 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261247AbVECAY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 20:24:57 -0400
Date: Tue, 3 May 2005 01:25:21 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/22] UML - Include the linker script rather than symlink it
Message-ID: <20050503002521.GA18977@parcelfarce.linux.theplanet.co.uk>
References: <200505012112.j41LC9fa016385@ccure.user-mode-linux.org> <20050502170654.248b11ea.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050502170654.248b11ea.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2005 at 05:06:54PM -0700, Andrew Morton wrote:
> That file doesn't exist and I think this patch doesn't want to patch it
> anyway.
> 
> I'll just drop the vmlinux.lds.S chunk...

Correct patch is on ftp.linux.org.uk/pub/people/viro/UM0-uml-ldscript-RC12-rc3

Short version of the story: current tree plays with a symlink from
vmlinux.lds.S to one of two files, depending on the config.  That doesn't
work well and confused vmlinux.lds.S chunk is actually a demonstration of
breakage - symlink had not been properly cleaned up.

New variant has _fixed_ vmlinux.lds.S - real file with
#include <linux/config.h>
#ifdef CONFIG_LD_SCRIPT_STATIC
#include "uml.lds.S"
#else
#include "dyn.lds.S"
#endif
in it and no symlink magic in makefiles.  Since we feed it through cpp
anyway, we can simply let cpp do all work - including picking the right
script depending on config.
