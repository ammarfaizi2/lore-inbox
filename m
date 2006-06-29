Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751244AbWF2S0I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbWF2S0I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 14:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbWF2S0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 14:26:07 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:54915 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751244AbWF2S0G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 14:26:06 -0400
Date: Thu, 29 Jun 2006 11:24:07 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org,
       "Theodore Ts'o" <tytso@mit.edu>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, vs@namesys.com, neilb@suse.de,
       Justin Forbes <jmforbes@linuxtx.org>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Randy Dunlap <rdunlap@xenotime.net>, Dave Jones <davej@redhat.com>,
       schwidefsky@de.ibm.com, Chuck Wolber <chuckw@quantumlinux.com>,
       alan@lxorguk.ukuu.org.uk
Subject: Re: [stable] [PATCH 25/25] generic_file_buffered_write(): deadlock on vectored write
Message-ID: <20060629182407.GZ11588@sequoia.sous-sol.org>
References: <20060627200745.771284000@sous-sol.org> <20060627201837.477852000@sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060627201837.477852000@sous-sol.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Chris Wright (chrisw@sous-sol.org) wrote:
> From: Vladimir V. Saveliev <vs@namesys.com>
> 
> generic_file_buffered_write() prefaults in user pages in order to avoid
> deadlock on copying from the same page as write goes to.
> 
> However, it looks like there is a problem when write is vectored:
> fault_in_pages_readable brings in current segment or its part (maxlen). 
> OTOH, filemap_copy_from_user_iovec is called to copy number of bytes
> (bytes) which may exceed current segment, so filemap_copy_from_user_iovec
> switches to the next segment which is not brought in yet.  Pagefault is
> generated.  That causes the deadlock if pagefault is for the same page
> write goes to: page being written is locked and not uptodate, pagefault
> will deadlock trying to lock locked page.

This is dropped for now, as it causes another problem with 0 length
iovecs.  Andrew has written a fix and once it's baked in Linus' tree for
a bit we can take back this one plus the fix.

thanks,
-chris
