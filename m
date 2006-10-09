Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964842AbWJIUmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964842AbWJIUmN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 16:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964841AbWJIUmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 16:42:13 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:49320 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964835AbWJIUmM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 16:42:12 -0400
Date: Mon, 9 Oct 2006 21:42:13 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Josef Sipek <jsipek@fsl.cs.sunysb.edu>, linux-kernel@vger.kernel.org,
       notting@redhat.com, torvalds@osdl.org, hch@infradead.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Introduce vfs_listxattr
Message-ID: <20061009204213.GZ29920@ftp.linux.org.uk>
References: <20061009201048.GA4707@filer.fsl.cs.sunysb.edu> <20061009133332.5c8285ce.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061009133332.5c8285ce.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2006 at 01:33:32PM -0700, Andrew Morton wrote:
> On Mon, 9 Oct 2006 16:10:48 -0400
> Josef Sipek <jsipek@fsl.cs.sunysb.edu> wrote:
> 
> > This patch moves code out of fs/xattr.c:listxattr into a new function -
> > vfs_listxattr. The code for vfs_listxattr was originally submitted by Bill
> > Nottingham <notting@redhat.com> to Unionfs.
> 
> That tells us what the patch does.  In general, please be sure to also tell
> us *why* you prepared a patch.
> 
> Does this patch allow unionfs to be loaded into an otherwise unpatched
> kernel.org kernel?  If so, that seems to be a good reason for including
> this patch into the mainline kernel.

Generally I'd say that it makes sense.  Anything that wants to
access the method in question would either have to play with
set_fs() or open-code it; neither is good.

It makes sense to localize calls of a method when we have pretty
much mandatory framing for it (security_... stuff).

So the only question is whether it makes sense for anything other
than syscall itself to access the method in question.  AFAICS,
the answer's yes...
