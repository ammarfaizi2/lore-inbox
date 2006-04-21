Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932165AbWDUAM2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbWDUAM2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 20:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932164AbWDUAM2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 20:12:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23487 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932162AbWDUAM1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 20:12:27 -0400
Date: Thu, 20 Apr 2006 17:11:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: hch@infradead.org, dhowells@redhat.com, torvalds@osdl.org,
       steved@redhat.com, sct@redhat.com, aviro@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] FS-Cache: Avoid ENFILE checking for kernel-specific
 open files
Message-Id: <20060420171118.119ddb4e.akpm@osdl.org>
In-Reply-To: <22114.1145556402@warthog.cambridge.redhat.com>
References: <20060420171857.GA21659@infradead.org>
	<20060420165927.9968.33912.stgit@warthog.cambridge.redhat.com>
	<20060420165932.9968.40376.stgit@warthog.cambridge.redhat.com>
	<22114.1145556402@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:
>
>   (1) Each AFS or NFS _dentry_ retained in the system pins a file in the
>       backing cache if it's also cached, whether or not it's open.

That would seem to be a great shortcoming in fscache.

I guess as memory reclaim reaps the top-level dentries those file*'s will
also be freed up, leading to their dentries becoming reclaimable, leading
to their inodes being reclaimable.

But still.  Is it not possible to release those files-pinned-by-dcache when
the top-level files are closed?
