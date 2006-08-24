Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751519AbWHXNen@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751519AbWHXNen (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 09:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751513AbWHXNen
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 09:34:43 -0400
Received: from mx1.redhat.com ([66.187.233.31]:52413 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751460AbWHXNem (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 09:34:42 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1156425193.3012.32.camel@pmac.infradead.org> 
References: <1156425193.3012.32.camel@pmac.infradead.org>  <32640.1156424442@warthog.cambridge.redhat.com> 
To: David Woodhouse <dwmw2@infradead.org>
Cc: David Howells <dhowells@redhat.com>, Jens Axboe <axboe@suse.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] BLOCK: Make it possible to disable the block layer 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Thu, 24 Aug 2006 14:34:16 +0100
Message-ID: <778.1156426456@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org> wrote:

> >  (*) The contents of a number of filesystem- and blockdev-specific header
> >      files are now contingent on their own configuration options.  This
> >      includes: Ext3/JBD, RAID, MSDOS and ReiserFS.
> 
> Why? Those header files shouldn't be included from anywhere _but_ the
> code in question,

Go and look at fs/compat_ioctl.c.

> and in fact should probably be just moved into fs/foo instead of living in
> include/linux/foo_fs.h.

Definitely.  Patches please:-)

> And please, _never_ make anything dependent on CONFIG_foo_MODULE.

Ah, but...  The core kernel makes use of the certain header files, even when
their actual intended target is compiled as a module.  If I just use
"CONFIG_foo" only, then the module won't compile as a module.

David
