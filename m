Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161420AbWHJQXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161420AbWHJQXQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 12:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161427AbWHJQXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 12:23:16 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:50527 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1161420AbWHJQXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 12:23:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=e5DmOy0plHEBdQvOhXCjpEqj/I88zo39zr8Iiapw8Bb7R5lYZfsuGxsiIoQfuzOmlCnWxDkFiL1Pfeesal1SxqVUe+bF4TQnSLPK/fANtzmg1P1FfxrOutV+8gPCKyg5fACvaVqNJPPIc0fHf8iPT9W8WJgTUlEUnMOn5CaDqxE=
Message-ID: <4ae3c140608100923j1ffb5bb5qa776bff79365874c@mail.gmail.com>
Date: Thu, 10 Aug 2006 12:23:12 -0400
From: "Xin Zhao" <uszhaoxin@gmail.com>
To: "Matthew Wilcox" <matthew@wil.cx>
Subject: Re: Urgent help needed on an NFS question, please help!!!
Cc: "Neil Brown" <neilb@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <20060810161107.GC4379@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4ae3c140608092204n1c07152k52010a10e209bb77@mail.gmail.com>
	 <17626.49136.384370.284757@cse.unsw.edu.au>
	 <4ae3c140608092254k62dce9at2e8cdcc9ae7a6d9f@mail.gmail.com>
	 <17626.52269.828274.831029@cse.unsw.edu.au>
	 <4ae3c140608100815p57c0378kfd316a482738ee83@mail.gmail.com>
	 <20060810161107.GC4379@parisc-linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That makes sense.

Can we make the following two conclusions?
1. In a single machine, inode+dev ID+i_generation can uniquely identify a file
2. Given a stored file handle and an inode object received from the
server,  an NFS client can safely determine whether this inode
corresponds to the file handle by checking the inode+dev+i_generation.

Thanks,
-x


On 8/10/06, Matthew Wilcox <matthew@wil.cx> wrote:
> On Thu, Aug 10, 2006 at 11:15:57AM -0400, Xin Zhao wrote:
> > I am considering another possibility: suppose client C1 does lookup()
> > on file X and gets a file handle, which include inode number,
> > generation number and parent's inode number. Before C1 issues
> > getattr(), C2 move the parent directory to a different place, which
> > will not change the parent's inode number, neither the file X's inode,
> > i_generation. So when C1 issues a getattr() request with this file
> > handle, the server seems to have no way to detect that file X is not
> > existent at the original path. Instead, the server will returns the
> > moved X's attributes, which are correct, but semantically wrong. Is
> > there any way that server deal with this problem?
>
> It isn't semantically wrong.  There is no way for the application to
> distinguish between the events:
>
> open()
> stat()
>         mv
>
> and
>
> open()
>         mv
> stat()
>
> As long as the results are consistent with the former case, it doesn't
> matter if the latter case actually happened.
>
