Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262834AbUKRSFx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262834AbUKRSFx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 13:05:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262828AbUKRSDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 13:03:52 -0500
Received: from fw.osdl.org ([65.172.181.6]:40860 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262803AbUKRSBy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 13:01:54 -0500
Date: Thu, 18 Nov 2004 10:01:40 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Miklos Szeredi <miklos@szeredi.hu>
cc: hbryan@us.ibm.com, akpm@osdl.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, pavel@ucw.cz
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
In-Reply-To: <E1CUq57-00043P-00@dorka.pomaz.szeredi.hu>
Message-ID: <Pine.LNX.4.58.0411180959450.2222@ppc970.osdl.org>
References: <OF28252066.81A6726A-ON88256F50.005D917A-88256F50.005EA7D9@us.ibm.com>
 <E1CUq57-00043P-00@dorka.pomaz.szeredi.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 18 Nov 2004, Miklos Szeredi wrote:
>
> It's possible, but I don't see why that's a problem.  If it can get
> more memory it's OK.  If allocation fails, then the write() will fail
> with ENOMEM, if OOM killer get's to work and kills the FUSE process,
> then write will return with ENOTCONN or something like that.

Why do you think it would kill the FUSE process? And why do you think 
killing _any_ process would make the system come back to life? After all, 
memory wasn't filled by process usage, it was filled by dirty FS pages.

I really do believe that user-space filesystems have problems. There's a 
reason we tend to do them in kernel space. 

But limiting the outstanding writes some way may at least hide the thing.

		Linus
