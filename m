Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965317AbWHOJGs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965317AbWHOJGs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 05:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965316AbWHOJGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 05:06:48 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:30910 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965315AbWHOJGq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 05:06:46 -0400
Date: Tue, 15 Aug 2006 10:06:45 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [RHEL5 PATCH 2/4] VFS: Make inode numbers 64-bits
Message-ID: <20060815090645.GV29920@ftp.linux.org.uk>
References: <20060815013114.GS29920@ftp.linux.org.uk> <20060814211504.27190.10491.stgit@warthog.cambridge.redhat.com> <20060814211509.27190.51352.stgit@warthog.cambridge.redhat.com> <7303.1155630071@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7303.1155630071@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2006 at 09:21:11AM +0100, David Howells wrote:
> Al Viro <viro@ftp.linux.org.uk> wrote:
> 
> > NAK.  There's no need to touch i_ino and a lot of reasons for not doing
> > that.  ->getattr() can fill 64bit field just fine without that and there's
> > zero need to touch every fs out there *and* add cycles on icache lookups.
> > WTF for?
> 
> That doesn't fix getdents64() though...

Good grief...  Make filldir() eat u64 explicitly and fix all of a dozen
instances.  End of story.
