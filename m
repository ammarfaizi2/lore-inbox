Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263823AbTEZAtd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 20:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263824AbTEZAtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 20:49:33 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36495 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263823AbTEZAtc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 20:49:32 -0400
Date: Mon, 26 May 2003 02:02:41 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Andries.Brouwer@cwi.nl
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] change get_sb prototype
Message-ID: <20030526010241.GL6270@parcelfarce.linux.theplanet.co.uk>
References: <UTC200305260039.h4Q0dxZ03906.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <UTC200305260039.h4Q0dxZ03906.aeb@smtp.cwi.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 26, 2003 at 02:39:59AM +0200, Andries.Brouwer@cwi.nl wrote:
> The boring patch below does not change behaviour.
> It does two things:
> 
> (i) The prototypes for free_vfsmnt(), alloc_vfsmnt(), do_kern_mount()
> so far occurred in several individual c files. Now they are in
> <linux/mount.h>.
> 
> (ii) do_kern_mount() has a third argument name that is typically
> a constant. It is called with "rootfs", "nfsd", type->name, "capifs",
> "usbdevfs", "binfmt_misc" etc. So, it should have a prototype that
> expresses this:
> 
> do_kern_mount(const char *fstype, int flags, const char *name, void *data);
> 
> This makes the ugly cast
> 
> -       return do_kern_mount(type->name, 0, (char *)type->name, NULL);
> +       return do_kern_mount(type->name, 0, type->name, NULL);
> 
> go away. Now do_kern_mount() calls type->get_sb(), so also get_sb()
> must have a const third argument. That is what the patch below does.

Eeek...   What for?  It's _much_ easier to kill silly const char * in
struct file_system_type.  And no, I don't believe that const is of any
value in that case.
