Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932285AbWDUKek@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285AbWDUKek (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 06:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932283AbWDUKek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 06:34:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60635 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932282AbWDUKej (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 06:34:39 -0400
Date: Fri, 21 Apr 2006 03:33:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: dhowells@redhat.com, torvalds@osdl.org, steved@redhat.com, sct@redhat.com,
       aviro@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-cachefs@redhat.com, nfsv4@linux-nfs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] FS-Cache: Provide a filesystem-specific sync'able
 page bit
Message-Id: <20060421033329.35f661e1.akpm@osdl.org>
In-Reply-To: <28997.1145614975@warthog.cambridge.redhat.com>
References: <20060420171216.4cdd369a.akpm@osdl.org>
	<20060420165927.9968.33912.stgit@warthog.cambridge.redhat.com>
	<28997.1145614975@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:
>
> Andrew Morton <akpm@osdl.org> wrote:
> 
> > It would be better to rename PG_checked to PG_fs_misc kernel-wide.
> 
> So would deleting PG_checked and changing the PageChecked() macros to:
> 
> 	#define PageChecked(page)		PageFsMisc((page))
> 	#define SetPageChecked(page)		SetPageFsMisc((page))
> 	#define ClearPageChecked(page)		ClearPageFsMisc((page))
> 
> be acceptable?  Or would you rather I replaced those too?
> 

PG_checked is presently a misc bit which only filesystems use.  So yes, I'd
say it's appropriate to remove PageChecked() and friends altogether.

That might break out-of-tree filesystems, but they'll work it out.
