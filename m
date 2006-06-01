Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964944AbWFAU30@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964944AbWFAU30 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 16:29:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965294AbWFAU30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 16:29:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:29096 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964944AbWFAU3Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 16:29:25 -0400
From: Chris Mason <mason@suse.com>
To: Olaf Hering <olh@suse.de>
Subject: Re: [PATCH] cramfs corruption after BLKFLSBUF on loop device
Date: Thu, 1 Jun 2006 16:29:19 -0400
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Al Viro <viro@ftp.linux.org.uk>
References: <20060529214011.GA417@suse.de> <200606011617.03166.mason@suse.com> <20060601202045.GA32423@suse.de>
In-Reply-To: <20060601202045.GA32423@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606011629.20663.mason@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 01 June 2006 16:20, Olaf Hering wrote:
>  On Thu, Jun 01, Chris Mason wrote:
> > I think this will work (but have not tested it).  Another option is to
> > create a read_cache_page that pins the page via a page flag
> > that invalidate_mapping_pages will honor.
>
> PageLocked or PageDirty, the latter only with a mb().

The problem is we need the bit to be set before we set the page up to date.  A 
locked page will never make it through the readpage() mechanisms and a dirty 
page that isn't up to date is not quite legal.

For cramfs, dirty would work I suppose.

-chris
