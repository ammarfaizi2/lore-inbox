Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161044AbWHJFyf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161044AbWHJFyf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 01:54:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161046AbWHJFyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 01:54:35 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:59994 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1161043AbWHJFye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 01:54:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uusxFEyKuNYMYOCJw0LAFCKmVSbo/GNb66bew8Khv0Dsn1E1VpvcDYawzw7lTL5cgr1JLGidWcHO1w2YGhUlOsZk98IaThXJyaJIfpG3QomZFaVrxLoOBeBC9gh2MIU5zFPkxFqFWb26BKZAozVh++ngfQKI0Zusg7J828LXiI0=
Message-ID: <4ae3c140608092254k62dce9at2e8cdcc9ae7a6d9f@mail.gmail.com>
Date: Thu, 10 Aug 2006 01:54:33 -0400
From: "Xin Zhao" <uszhaoxin@gmail.com>
To: "Neil Brown" <neilb@suse.de>
Subject: Re: Urgent help needed on an NFS question, please help!!!
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
In-Reply-To: <17626.49136.384370.284757@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4ae3c140608092204n1c07152k52010a10e209bb77@mail.gmail.com>
	 <17626.49136.384370.284757@cse.unsw.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Many thanks for your kind help!

Your answer is what I expected. But what frustrated me is that I
cannot find the code that verifies the generation number in NFS V3
codes. Do you know where it check the generation number?

Thanks,
-x

On 8/10/06, Neil Brown <neilb@suse.de> wrote:
> On Thursday August 10, uszhaoxin@gmail.com wrote:
> > I just ran into a problem about NFS. It might be a fundmental problem
> > of my current work. So please help!
> >
> > I am wondering how NFS guarantees a client didn't get wrong file
> > attributes. Consider the following scenario:
> >
> > Suppose we have an NFS server S and two clients C1 and C2.
> >
> > Now C1 needs to access the file attributes of file X, it first does
> > lookup() to get the file handle of file X.
> >
> > After C1 gets X's file handle and before C1 issues the getattr()
> > request, C2 cuts in. Now C2 deletes file X and creates a new file X1,
> > which has different name but the same inode number and device ID as
> > the nonexistent file X.
> >
> > When C1 issues getattr() with the old file handle, it may get file
> > attribute on wrong file X1. Is this true?
> >
> > If not, how NFS avoid this problem? Please direct me to the code that
> > verifies this.
>
> Generation numbers.
>
> When the filesystem creates a new file it assigns a random number
> as the 'generation' number and stores that in the inode.
> This gets included in the filehandle, and checked when the filehandle
> lookup is done.
>
> Look for references to 'i_generation' in fs/ext3/*
>
> Other files systems may approach this slightly differently, but the
> filesystem is responsible for providing a unique-over-time filehandle,
> and 'generation number' is the 'standard' way of doing this.
>
> NeilBrown
>
