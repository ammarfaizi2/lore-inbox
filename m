Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751587AbWHJU2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751587AbWHJU2x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750953AbWHJU1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 16:27:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25272 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751143AbWHJU10 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 16:27:26 -0400
Date: Thu, 10 Aug 2006 13:27:20 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: Badari Pulavarty <pbadari@us.ibm.com>, cmm@us.ibm.com,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/5] Forking ext4 filesystem from ext3 filesystem
Message-Id: <20060810132720.4d9fced4.akpm@osdl.org>
In-Reply-To: <44DB936D.2080909@garzik.org>
References: <1155172622.3161.73.camel@localhost.localdomain>
	<20060809233914.35ab8792.akpm@osdl.org>
	<44DB8036.5020706@us.ibm.com>
	<44DB936D.2080909@garzik.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2006 16:13:33 -0400
Jeff Garzik <jeff@garzik.org> wrote:

> The sooner we kill buffer heads and use submit_bio(), the better :)

A buffer_head is a caching entity and a bio is an IO container.  They're
quite separate concepts.

A buffer_head is the kernel's sole abstraction of a disk block. 
Filesystems use disk blocks a lot, and they need such an abstraction.

If one was to replace buffer_heads with direct-to-BIO operations then the
filesytem would need to internally track the mapping from

	page+offset+length -> disk block

and it would need to internally track the page+offset+length<->disk block
coherency state and it would need to internally perform serialisation of
access to each page+offset+length hunk of pagecache and etc and etc and
etc.  Create a data structure with which to do all that and voila,
buffer_heads reinvented.
