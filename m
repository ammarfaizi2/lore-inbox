Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751108AbWEVSJF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbWEVSJF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 14:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbWEVSJF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 14:09:05 -0400
Received: from xenotime.net ([66.160.160.81]:16103 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751108AbWEVSJE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 14:09:04 -0400
Date: Mon, 22 May 2006 11:11:36 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Zach Brown <zach.brown@oracle.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kmap tracking
Message-Id: <20060522111136.2c2e5fd1.rdunlap@xenotime.net>
In-Reply-To: <4471FBDE.8010506@oracle.com>
References: <20060518155357.04066e9c.rdunlap@xenotime.net>
	<4471EA2C.4010401@oracle.com>
	<20060522103915.53e03867.akpm@osdl.org>
	<4471FBDE.8010506@oracle.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 May 2006 10:58:54 -0700 Zach Brown wrote:

> 
> > I was scratching my head over this patch trying to think of any bug in
> > recent years which it would have detected.  I failed.
> 
> 2.4 nfs used to require that it be able to kmap entire RPCs for them to
> make forward progress.  Its file->write() required RPC forward progress
> before it would return.  And some callers were holding kmaps across
> file->write() calls.  So with enough concurrent callers doing that the
> system would get stuck.
> 
> We used the patch to see who the callers were when the system got into
> that state.
> 
> One of them was core dumping, believe it or not.  2.6 elf_core_dump()
> still holds a kmap across file->write(), which seems unwise, but I
> haven't gotten to seeing if it's worth worrying about or not.
> 
> So maybe these days the kmap story is less dreadful and it isn't as
> helpful, but that's what we used it for.

I was planning to add kmap_atomic* variants to the patch.
I could see it being useful for those callers, but maybe problems
with them would be more obvious anyway and wouldn't need such
a patch.

---
~Randy
