Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932294AbVIEOHm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbVIEOHm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 10:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbVIEOHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 10:07:42 -0400
Received: from thunk.org ([69.25.196.29]:19684 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1751255AbVIEOHl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 10:07:41 -0400
Date: Mon, 5 Sep 2005 10:07:47 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Mark Fasheh <mark.fasheh@oracle.com>
Cc: Pavel Machek <pavel@ucw.cz>, David Teigland <teigland@redhat.com>,
       Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-cluster@redhat.com
Subject: Re: GFS, what's remaining
Message-ID: <20050905140747.GB10751@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Mark Fasheh <mark.fasheh@oracle.com>, Pavel Machek <pavel@ucw.cz>,
	David Teigland <teigland@redhat.com>, Andrew Morton <akpm@osdl.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-cluster@redhat.com
References: <20050901104620.GA22482@redhat.com> <20050901035939.435768f3.akpm@osdl.org> <1125586158.15768.42.camel@localhost.localdomain> <20050901132104.2d643ccd.akpm@osdl.org> <20050903051841.GA13211@redhat.com> <20050904203344.GA1987@elf.ucw.cz> <20050905055428.GA29158@thunk.org> <20050905070922.GK21228@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050905070922.GK21228@ca-server1.us.oracle.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2005 at 12:09:23AM -0700, Mark Fasheh wrote:
> Btw, I'm curious to know how useful folks find the ext3 mount options
> errors=continue and errors=panic. I'm extremely likely to implement the
> errors=read-only behavior as default in OCFS2 and I'm wondering whether the
> other two are worth looking into.

For a single-user system errors=panic is definitely very useful on the
system disk, since that's the only way that we can force an fsck, and
also abort a server that might be failing and returning erroneous
information to its clients.  Think of it is as i/o fencing when you're
not sure that the system is going to be performing correctly.

Whether or not this is useful for ocfs2 is a different matter.  If
it's only for data volumes, and if the only way to fix filesystem
inconsistencies on a cluster filesystem is to request all nodes in the
cluster to unmount the filesystem and then arrange to run ocfs2's fsck
on the filesystem, then forcing every single cluster in the node to
panic is probably counterproductive.  :-)

						- Ted
