Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263718AbUEWXFW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263718AbUEWXFW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 19:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263725AbUEWXFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 19:05:22 -0400
Received: from fw.osdl.org ([65.172.181.6]:16067 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263718AbUEWXFP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 19:05:15 -0400
Date: Sun, 23 May 2004 16:04:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: hugh@veritas.com, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] export swapper_space
Message-Id: <20040523160439.0aad94a2.akpm@osdl.org>
In-Reply-To: <1085352637.10930.42.camel@mulgrave>
References: <1085352637.10930.42.camel@mulgrave>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley <James.Bottomley@SteelEye.com> wrote:
>
> This is now used as part of the page_mapping() macro.  However, certain
> filesystems, such as ext3, make use of this.  If it's not exported, they
> can't be compiled as modules.

I'd be a bit reluctant to do this.  filesystems actually have no need for
page_mapping() - page->mapping is always correct in that context and
page_mapping() has additional overhead.  So if poss we should avoid this
export so as to force filesystems to avoid page_mapping().

parisc broke because its flush_dcache_page() is inlined, and it uses
page_mapping().  I'd suggest that parisc and arm uninline that function -
it's quite large anyway.


