Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754482AbWKMLZH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754482AbWKMLZH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 06:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754489AbWKMLZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 06:25:07 -0500
Received: from mx1.redhat.com ([66.187.233.31]:10454 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1754484AbWKMLZE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 06:25:04 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <17752.5086.510190.316725@cse.unsw.edu.au> 
References: <17752.5086.510190.316725@cse.unsw.edu.au>  <200611111129.kABBTWgp014081@fire-2.osdl.org> <20061111100038.6277efd4.akpm@osdl.org> 
To: Neil Brown <neilb@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       "bugme-daemon@kernel-bugs.osdl.org" 
	<bugme-daemon@bugzilla.kernel.org>,
       linux-kernel@vger.kernel.org, alex@hausnet.ru
Subject: Re: [Bugme-new] [Bug 7495] New: Kernel periodically hangs. 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Mon, 13 Nov 2006 11:22:19 +0000
Message-ID: <1584.1163416939@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown <neilb@suse.de> wrote:

> it would appear that in:
> 	if (inode->i_sb && inode->i_sb->s_op->clear_inode)
> 		inode->i_sb->s_op->clear_inode(inode);
> 
> inode->i_sb->s_op is NULL.

Agreed.

> This tends to suggest that generic_shutdown_super isn't releasing all inodes
> before the superblock gets destroyed.
> 
> I cannot see how this could be happening

Perhaps sb->s_root == NULL?  That would permit most of generic_shutdown_super()
to be bypassed, including the check that all the inodes have been consumed.

David
