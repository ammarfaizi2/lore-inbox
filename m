Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264790AbSLBEjs>; Sun, 1 Dec 2002 23:39:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264795AbSLBEjr>; Sun, 1 Dec 2002 23:39:47 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:44650 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S264790AbSLBEjr>; Sun, 1 Dec 2002 23:39:47 -0500
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 64-bit struct resource fields
References: <3DE2AE04.5030209@us.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 01 Dec 2002 21:46:11 -0700
In-Reply-To: <3DE2AE04.5030209@us.ibm.com>
Message-ID: <m1of85xc30.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <haveblue@us.ibm.com> writes:

> We need some way to replicate the e820 tables for kexec.  This modifies struct
> resource to use u64's for its start and end fields. This way we can export the
> whole e820 table on PAE machines.
> 
> resource->flags seems to be used often to mask out things in
> resource->start/end, so I think it needs to be u64 too.  

I don't see this in the parts of the kernel your patch changes, I will
have to look a little more and see if this is really true.  If it
is you probably should append ULL to the flag constants.

>But, Is it all right to
> 
> let things like pcibios_update_resource() truncate the resource addresses like
> they do?

The type of addresses for resources will always be equal or larger
than the resources they actually represent.  Until someone modifies
the pcibios_xxxx code to handle 64bit BARs it should only be
truncation of zeros and thus safe.  

I will see if I can scrutinize this carefully, and try it in the next
little while.  For now I am placing it on the back burner and going
to bed.  It looks like a good start though.

Eric
