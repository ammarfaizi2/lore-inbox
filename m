Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264774AbUDWJit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264774AbUDWJit (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 05:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264778AbUDWJit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 05:38:49 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:1037 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S264774AbUDWJir
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 05:38:47 -0400
Date: Fri, 23 Apr 2004 19:38:36 +1000
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SOFTWARE_SUSPEND as a module
Message-ID: <20040423093836.GA10550@gondor.apana.org.au>
References: <20040422120417.GA2835@gondor.apana.org.au> <20040423005617.GA414@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040423005617.GA414@elf.ucw.cz>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2004 at 02:56:18AM +0200, Pavel Machek wrote:
> 
> I can't see actual code changes because you do lots of renames... Is
> there way to keep them down?

Well I haven't really changed the code at all apart from the bits
to do with module loading and parsing the device name for resume.

What I've done is:

* Split swsusp.c into swsusp-core.c and the rest based on whether it
is called by do_magic() or not.
* Added EXPORTs for the symbols needed by what's left of swsusp.
* Added module parameter parsing.

The renames are part of the second step as the symbols
resume_device/suspend_name/resume_Name were too generic.  

> What is the point of this? Do you want launch resume after you

The point of this is to allow inclusion in distribution kernels where
block devices are built as modules.

As a side-effect it also allows you to resume from devices that couldn't
be done before due to the need for user-space setup.  Examples are LVM
and NBD.

> prepared for it in userland? In such case you need to add
> freeze_processes() to resume path.

Is that really necessary if the user-space caller ensures that all
disk accesses are shut down? After all the loading for resume will
occur in the initrd before any disk activity has occured.

Cheers,
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
