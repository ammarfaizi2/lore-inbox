Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262934AbVCWVKJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262934AbVCWVKJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 16:10:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261269AbVCWVIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 16:08:54 -0500
Received: from mx1.redhat.com ([66.187.233.31]:15764 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262918AbVCWUmw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 15:42:52 -0500
Subject: Re: [CHECKER] ext3 bug in ftruncate() with O_SYNC?
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Stephen Tweedie <sct@redhat.com>, blp@cs.stanford.edu, mc@cs.stanford.edu,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>
In-Reply-To: <20050321195128.60839eea.akpm@osdl.org>
References: <87y8chft5j.fsf@benpfaff.org>
	 <20050321195128.60839eea.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1111610558.1998.193.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Wed, 23 Mar 2005 20:42:38 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 2005-03-22 at 03:51, Andrew Morton wrote:

> The spec says "Write I/O operations on the file descriptor shall complete
> as defined by synchronized I/O file integrity completion".
> 
> Is ftruncate a "write I/O operation"?  No.

SUS seems to be pretty clear on this.  The syscall descriptions for
write(2) and pwrite(2) explicitly describe O_SYNC as requiring
synchronized I/O file integrity completion.  ftruncate() has no such
requirement.

It would certainly be a reasonable thing to do, but I don't think it
strictly counts as a bug that we're not honouring O_SYNC here.

--Stephen


