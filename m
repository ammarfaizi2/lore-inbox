Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965335AbWHOJZ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965335AbWHOJZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 05:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965334AbWHOJZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 05:25:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:12195 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965332AbWHOJZ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 05:25:57 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060815090243.GT29920@ftp.linux.org.uk> 
References: <20060815090243.GT29920@ftp.linux.org.uk>  <20060815013114.GS29920@ftp.linux.org.uk> <20060814211504.27190.10491.stgit@warthog.cambridge.redhat.com> <20060814211509.27190.51352.stgit@warthog.cambridge.redhat.com> <7619.1155630777@warthog.cambridge.redhat.com> 
To: Al Viro <viro@ftp.linux.org.uk>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RHEL5 PATCH 2/4] VFS: Make inode numbers 64-bits 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 15 Aug 2006 10:25:47 +0100
Message-ID: <9787.1155633947@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro <viro@ftp.linux.org.uk> wrote:

> In fs-independent code?  How many of those do we actually have?

At most about half a dozen.  Depends whether you include pipes and eventpoll
in that.  There's an instance in fs/dcache.c and one in fs/fs-writeback.c

find_inode_number() is also a potential problem, though I suppose we have to
say you may not use it if 0 is a valid thing to have in i_ino.

Interestingly, one of these also touches userspace: /proc/locks passes the
inode number out, but will pass the wrong one if i_ino is too short.  Does
anything in userspace actually use that?

David
