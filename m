Return-Path: <linux-kernel-owner+w=401wt.eu-S1762782AbWLKKsD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762782AbWLKKsD (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 05:48:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762780AbWLKKsD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 05:48:03 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:54825 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762778AbWLKKsB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 05:48:01 -0500
Date: Mon, 11 Dec 2006 10:47:56 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Andrew MChuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "Linus Torvalds orton <akpm@osdl.org>" <torvalds@osdl.org>
Subject: Re: [patch] pipe: Don't oops when pipe filesystem isn't mounted
Message-ID: <20061211104756.GG4587@ftp.linux.org.uk>
References: <20061211005557.04643a75.akpm@osdl.org> <20061211011327.f9478117.akpm@osdl.org> <20061211092130.GB4587@ftp.linux.org.uk> <20061211012545.ed945cbd.akpm@osdl.org> <20061211093314.GC4587@ftp.linux.org.uk> <20061211014727.21c4ab25.akpm@osdl.org> <20061211100301.GD4587@ftp.linux.org.uk> <20061211021718.a6954106.akpm@osdl.org> <20061211102207.GE4587@ftp.linux.org.uk> <20061211023436.258bb3ea.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061211023436.258bb3ea.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2006 at 02:34:36AM -0800, Andrew Morton wrote:

> There are plenty of drivers in there using subsys_initcall, arch_initcall,
> postcore_initcall, core_initcall and even one pure_initcall.
> 
> Heaven knows why.  They're drivers :(
 
> A heck of a lot of things can trigger an /sbin/hotplug run.  It could well
> be that Andrew's driver didn't want to run hotplug at all, but the kernel
> did it anwyay.  But as soon as the script appeared at /sbin/hotplug, and it
> happened to use foo|bar: boom.

Again, I agree with moving pipes up, but keep in mind that any caller
of /sbin/hotplug either
	* doesn't need it or
	* really handles failure or
	* really should _not_ be run before populate_rootfs()
