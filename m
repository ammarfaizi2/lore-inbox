Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261916AbUKCVfT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261916AbUKCVfT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 16:35:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261894AbUKCVdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 16:33:04 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:51127 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S261890AbUKCVcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 16:32:12 -0500
Date: Wed, 3 Nov 2004 14:32:10 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Chris Wedgwood <cw@f00f.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       urban@teststation.com
Subject: Re: [PATCH 2.6.10-rc1] Fix building of samba userland
Message-ID: <20041103213210.GJ381@smtp.west.cox.net>
References: <20041103190345.GI381@smtp.west.cox.net> <20041103205548.GA10756@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041103205548.GA10756@taniwha.stupidest.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2004 at 12:55:48PM -0800, Chris Wedgwood wrote:
> On Wed, Nov 03, 2004 at 12:03:45PM -0700, Tom Rini wrote:
> 
> > Hello.  After 2.6.8.1, samba userland would no longer build with
> > current kernel headers, as it needs some of the samba kernel headers
> > to work,
> 
> what? the samba userland which i assume is portable and not at all
> linux specific needs linux kernel headers?

Portability questions aside (I'm not a Samba person, nor do I play one
on TV), the code in question isn't, as it needs <asm/types.h> and
<linux/smb_fs.h> (if not needs, at least uses as of 3.0.7).

> > +++ edited/include/linux/smb_fs.h	2004-11-03 12:00:07 -07:00
> > @@ -12,7 +12,6 @@
> >  #include <linux/smb.h>
> >  #include <linux/smb_fs_i.h>
> >  #include <linux/smb_fs_sb.h>
> > -#include <linux/fs.h>
> >  
> >  /*
> >   * ioctl commands
> > @@ -26,6 +25,7 @@
> >  
> >  #ifdef __KERNEL__
> >  
> > +#include <linux/fs.h>
> >  #include <linux/pagemap.h>
> >  #include <linux/vmalloc.h>
> >  #include <linux/smb_mount.h>
> 
> that patch seems harmless enough, but im not sure why it should be
> necessary really, i dont see why samba should be including such
> headers at all --- it's a bad idea in almost all cases

Digging around a bit, it needs SMB_CASE_DEFAULT (enum) and
SMB_IOC_NEWCONN.

-- 
Tom Rini
http://gate.crashing.org/~trini/
