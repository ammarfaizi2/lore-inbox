Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129216AbQKQS1O>; Fri, 17 Nov 2000 13:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129739AbQKQS1E>; Fri, 17 Nov 2000 13:27:04 -0500
Received: from kweetal.tue.nl ([131.155.2.7]:61965 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S129414AbQKQS0s>;
	Fri, 17 Nov 2000 13:26:48 -0500
Message-ID: <20001117185638.A8452@win.tue.nl>
Date: Fri, 17 Nov 2000 18:56:38 +0100
From: Guest section DW <dwguest@win.tue.nl>
To: Jean-Marc Saffroy <saffroy@ri.silicomp.fr>, torvalds@transmeta.com,
        viro@math.psu.edu, linux-kernel@vger.kernel.org
Cc: Eric Paire <paire@ri.silicomp.fr>
Subject: Re: [BUG] Inconsistent behaviour of rmdir
In-Reply-To: <Pine.LNX.4.21.0011161400290.24271-100000@sisley.ri.silicomp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <Pine.LNX.4.21.0011161400290.24271-100000@sisley.ri.silicomp.fr>; from Jean-Marc Saffroy on Thu, Nov 16, 2000 at 02:47:35PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2000 at 02:47:35PM +0100, Jean-Marc Saffroy wrote:

> As you see, it looks like the rmdir fails simply because the dir name ends
> with a dot !! This is confirmed by sys_rmdir in fs/namei.c, around line
> 1384 :
> 
>         switch(nd.last_type) {
>                 case LAST_DOTDOT:
>                         error = -ENOTEMPTY;
>                         goto exit1;
>                 case LAST_ROOT: case LAST_DOT:
>                         error = -EBUSY;
>                         goto exit1;
>         }

I see that an entire discussion has taken place. Let me just remark this,
quoting the Austin draft:

If the path argument refers to a path whose final component is either
dot or dot-dot, rmdir( ) shall fail.

EINVAL	The path argument contains a last component that is dot.
EEXIST or ENOTEMPTY	The path argument names a directory that is not an empty directory, 
EBUSY	The directory to be removed is currently in use by the system or some process 
	and the implementation considers this to be an error.

So, it seems that -EINVAL would be a better return value in case LAST_DOT.

Andries
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
