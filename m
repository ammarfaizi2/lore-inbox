Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263127AbTEGKle (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 06:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263128AbTEGKle
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 06:41:34 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50361 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263127AbTEGKld
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 06:41:33 -0400
Date: Wed, 7 May 2003 11:54:07 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@digeo.com>,
       Andreas Gruenbacher <a.gruenbacher@computer.org>,
       Christoph Hellwig <hch@infradead.org>,
       lkml <linux-kernel@vger.kernel.org>,
       lsm <linux-security-module@wirex.com>
Subject: Re: [PATCH] Change LSM hooks in setxattr 2.5.69
Message-ID: <20030507105407.GO10374@parcelfarce.linux.theplanet.co.uk>
References: <1052238063.1377.997.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052238063.1377.997.camel@moss-huskers.epoch.ncsc.mil>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 06, 2003 at 12:21:05PM -0400, Stephen Smalley wrote:
> This patch against 2.5.69 adds a security_inode_post_setxattr hook so
> that security modules can update the inode security structure after a
> successful setxattr, and it moves the existing security_inode_setxattr
> hook call after the taking the inode semaphore so that atomicity is
> provided for the security check and the update to the inode security
> structure.  Al, if you approve of this change, please acknowledge.  If
> not, please advise as to what must change.  Thanks. 
 
<shrug> no objections, provided that existing code behind that hook doesn't
do anything that could deadlock under ->i_sem.  Seeing that it's your code...
