Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751409AbWHXNNg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbWHXNNg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 09:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbWHXNNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 09:13:36 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:24740 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751409AbWHXNNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 09:13:35 -0400
Subject: Re: [PATCH] BLOCK: Make it possible to disable the block layer
From: David Woodhouse <dwmw2@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: Jens Axboe <axboe@suse.de>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <32640.1156424442@warthog.cambridge.redhat.com>
References: <32640.1156424442@warthog.cambridge.redhat.com>
Content-Type: text/plain
Date: Thu, 24 Aug 2006 14:13:13 +0100
Message-Id: <1156425193.3012.32.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-24 at 14:00 +0100, David Howells wrote:
> Make it possible to disable the block layer.  Not all embedded devices require
> it, some can make do with just JFFS2, NFS, ramfs, etc - none of which require
> the block layer to be present.
> 
> This patch does the following:
> 
>  (*) Introduces CONFIG_BLOCK to disable the block layer, buffering and blockdev
>      support.

Excellent -- I've been meaning to do this (and occasionally hacking on
it half-heartedly before getting distracted by something else shiny) for
a _long_ time.

It looks good in general.

>  (*) The contents of a number of filesystem- and blockdev-specific header files
>      are now contingent on their own configuration options.  This includes:
>      Ext3/JBD, RAID, MSDOS and ReiserFS.

Why? Those header files shouldn't be included from anywhere _but_ the
code in question, and in fact should probably be just moved into fs/foo
instead of living in include/linux/foo_fs.h. 

And please, _never_ make anything dependent on CONFIG_foo_MODULE.

-- 
dwmw2

