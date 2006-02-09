Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422717AbWBIANX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422717AbWBIANX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 19:13:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422718AbWBIANX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 19:13:23 -0500
Received: from xproxy.gmail.com ([66.249.82.204]:60501 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1422717AbWBIANW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 19:13:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Y3A/whds0+B7ST/Zd79Tq31xNH77+f8db0eyViMJ28mEkfJt3H5olrtGaFAGQ420oDjsD1Fij/l/eTWipHmNJNzFpl4RIzD3F7pJGiDnWaC/ZHaf2o8B9alF7B7Eorj7q9RgS+xsKxCJ2eVAjFG8zITAqjQ8GfiR7TSmsp/uVXo=
Message-ID: <ef2d59350602081613y5ba8c264j45a64363360bd58e@mail.gmail.com>
Date: Wed, 8 Feb 2006 19:13:21 -0500
From: kapil a <kapilann@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: file system question
In-Reply-To: <ef2d59350602081611h4492bf47ne24e3d591efd29e7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <ef2d59350602081539w7b6780e3mf6d8326f6d4963f2@mail.gmail.com>
	 <1139443268.4902.11.camel@rockstar.fsl.cs.sunysb.edu>
	 <ef2d59350602081611h4492bf47ne24e3d591efd29e7@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---------- Forwarded message ----------
From: kapil a <kapilann@gmail.com>
Date: Feb 8, 2006 7:11 PM
Subject: Re: file system question
To: Avishay Traeger <atraeger@cs.sunysb.edu>


thanks for the reply and sorry for the unclear question.

What i meant was when i do an "ls" in a directory that is part of the
ext2 filesystem, i can see a  "write" call in the strace output at the
end and it writes the directory contents to stdout. However when i
issue "ls" in the mount point of my file system, i dont have the
"write" call. The strace ends with the getdents64 call.

When i did some debugging i found that filldir which is suppose to
fill the dirent with the directory entries does its job. My filesystem
currently has only one inode with one block of data where i have a
".", ".." and "test" written into it.

The problem is it does not go further to do some of the other calls as
in a mountpoint in ext2 file system.

Hope i am clear now.

kaps


On 2/8/06, Avishay Traeger <atraeger@cs.sunysb.edu> wrote:
> On Wed, 2006-02-08 at 18:39 -0500, kapil a wrote:
> > I am trying to write a file system for 2.6.  I have written the
> > required things to mount my file system and now i am trying to get
> > some f_op's and d_op's. I was trying to make the 'ls' command work. So
> > i wrote a myfs_readdir() and linked it to the f_op field. My routine
> > gets called and also filldir gets called and stores the data in the
> > dirent but i dont get the output in stdout.
> >
> >   On using strace i find that "ls" does not perform all the calls that
> > a "ls" in a directory mountedf in ext2 performs. To be specific, the
> > strace ouput ends after the getdents64 system call. In the normal "ls"
> > strace, i find there are a couple of more system calls namely a fstat
> > followed by a write to stdout and some more mmap calls.
>
> Correct.  The getdents system call will call your readdir function.
>
> >   I dont understand the reason behind why the write is not called. My
> > guess is i have not over-ridden some function that i have to write as
> > part of my file system instead of using the default method.
>
> Why would your write function get called when 'ls' writes to stdout?
> Please explain your question more clearly.
>
>
> Avishay Traeger
> http://www.fsl.cs.sunysb.edu/~avishay/
>
>
