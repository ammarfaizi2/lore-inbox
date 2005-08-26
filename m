Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030249AbVHZT74@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030249AbVHZT74 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 15:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030250AbVHZT74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 15:59:56 -0400
Received: from ms-smtp-02-smtplb.rdc-nyc.rr.com ([24.29.109.6]:61674 "EHLO
	ms-smtp-02.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id S1030249AbVHZT7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 15:59:55 -0400
Date: Fri, 26 Aug 2005 20:08:51 +0000
From: Kent Robotti <dwilson24@nyc.rr.com>
To: Chris Wedgwood <cw@f00f.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Initramfs and TMPFS!
Message-ID: <20050826200851.GA851@Linux.nyc.rr.com>
Reply-To: dwilson24@nyc.rr.com
References: <200508260139.j7Q1dFME000555@ms-smtp-03.rdc-nyc.rr.com> <20050826190647.GA12296@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050826190647.GA12296@taniwha.stupidest.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2005 at 12:06:47PM -0700, Chris Wedgwood wrote:
> On Thu, Aug 25, 2005 at 09:39:15PM -0400, dwilson24@nyc.rr.com wrote:
> 
> > Wouldn't it be better to put overmount_rootfs in initramfs.c
> > and call it only if there's a initramfs?
> 
> I don't see what or how that helps.  Yes we can shuffle some code
> about but the real problem still exists.
> 
> That is is that (by design) the early userspace is unpacked as soon as
> possible before all kernel subsystems are up.

Overmount_rootfs shouldn't take place until you know for sure the
kernel detects an initramfs.

I know the patch only has one purpose and you can assume the user is
using it just for that, but if the user uses the patched kernel without
an initramfs it runs overmount_rootfs anyway.

Also, in shmem.c init_tmpfs isn't run because it assumes that
overmount_rootfs will be, so if the kernel is being used in a
non initramfs way (tmpfs isn't registered). 

   #ifndef CONFIG_EARLYUSERSPACE_ON_TMPFS
   module_init(init_tmpfs)
   #endif /* !CONFIG_EARLYUSERSPACE_ON_TMPFS */
