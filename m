Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030374AbWHORaI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030374AbWHORaI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 13:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030375AbWHORaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 13:30:08 -0400
Received: from mx1.redhat.com ([66.187.233.31]:35512 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030374AbWHORaG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 13:30:06 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060815065035.648be867.akpm@osdl.org> 
References: <20060815065035.648be867.akpm@osdl.org>  <20060814143110.f62bfb01.akpm@osdl.org> <20060813133935.b0c728ec.akpm@osdl.org> <20060813012454.f1d52189.akpm@osdl.org> <10791.1155580339@warthog.cambridge.redhat.com> <918.1155635513@warthog.cambridge.redhat.com> 
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Ian Kent <raven@themaw.net>
Subject: Re: 2.6.18-rc4-mm1 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 15 Aug 2006 18:29:58 +0100
Message-ID: <29717.1155662998@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Next thing to try: Can you do the following:

	echo $((0x0200)) >/proc/sys/sunrpc/nfs_debug
	ls -l /net/bix
	umount /net/bix

That should print some information about the client and server setup procedure
into the kernel dmesg log which can then be captured.

If you follow that up with:

	echo $((0x0201)) >/proc/sys/sunrpc/nfs_debug
	ls -l /net/bix
	umount /net/bix

That'll dump information from the VFS interaction also.  It'll be a lot more
information, and it might overrun your dmesg buffer, hence why I'm asking you
to do the client-only debugging separately.

Then do:

	echo 0 >/proc/sys/sunrpc/nfs_debug

to turn off debugging again.

David
