Return-Path: <linux-kernel-owner+w=401wt.eu-S1754665AbWLHRqI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754665AbWLHRqI (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 12:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758255AbWLHRqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 12:46:08 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:1633 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754665AbWLHRqH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 12:46:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=tveeUUloHIqcn0zPSkJ73sDkpKhjhoTv1GmLnFBCo7tJ8oZWgn2ssBfDbTpLNYK1yqNOiUpP1jpsV8v2iH3K+0ZvE5GgUHxJInE9UUDbt4NHA9gx33+vCGxU1gtfCQHehqHe3Wg1+u9/mrXGeiY5Kpjf2vcdMnQES9giJ8641MU=
Message-ID: <b6c5339f0612080946k57f9271fmdb8ed13ffefdf92b@mail.gmail.com>
Date: Fri, 8 Dec 2006 12:46:05 -0500
From: "Bob Copeland" <me@bobcopeland.com>
To: "Maria Short" <mgolod@ieee.org>
Subject: Re: Linux slack space question
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3c698a820612080921u20a957d9x1ac1e01e6734d025@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <3c698a820612080921u20a957d9x1ac1e01e6734d025@mail.gmail.com>
X-Google-Sender-Auth: 2d02dc050d933540
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/06, Maria Short <mgolod@ieee.org> wrote:
> What I need is the code in the kernel that does that. I have been
> looking at http://lxr.linux.no/source/fs/ext3/inode.c but I could not
> find the specific code for partially filling the last block and
> placing an EOF at the end, leaving the rest to slack space.

There is no place where it writes an EOF.  The size of the file is
stored in metadata (e.g. inode->i_size), and only the appropriate
number of blocks up to i_size are read or written to.  Look at
ext3_get_block to see how blocks are read and allocated.

Bob
