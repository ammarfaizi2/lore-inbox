Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265095AbSLMQSh>; Fri, 13 Dec 2002 11:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265096AbSLMQSh>; Fri, 13 Dec 2002 11:18:37 -0500
Received: from hellcat.admin.navo.hpc.mil ([204.222.179.34]:20198 "EHLO
	hellcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S265095AbSLMQSf> convert rfc822-to-8bit; Fri, 13 Dec 2002 11:18:35 -0500
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <pollard@admin.navo.hpc.mil>
To: root@chaos.analogic.com, Marc-Christian Petersen <m.c.p@wolk-project.de>
Subject: Re: Symlink indirection
Date: Fri, 13 Dec 2002 10:26:00 -0600
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org, Andrew Walrond <andrew@walrond.org>
References: <Pine.LNX.3.95.1021213102838.2190B-100000@chaos.analogic.com>
In-Reply-To: <Pine.LNX.3.95.1021213102838.2190B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212131026.00287.pollard@admin.navo.hpc.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 December 2002 09:30 am, Richard B. Johnson wrote:
> On Fri, 13 Dec 2002, Marc-Christian Petersen wrote:
> > On Friday 13 December 2002 16:06, Andrew Walrond wrote:
> >
> > Hi Andrew,
> >
> > > Is the number of allowed levels of symlink indirection (if that is the
> > > right phrase; I mean symlink -> symlink -> ... -> file) dependant on
> > > the kernel, or libc ? Where is it defined, and can it be changed?
> >
> > fs/namei.c
> >
> >  if (current->link_count >= 5)
> >
> > change to a higher value.
> >
> > So, the answer is: Kernel :)
> >
> > ciao, Marc
>
> No, that thing (whetever it is) is different.
>
> Script started on Fri Dec 13 10:26:30 2002
> # file *
> foo:        symbolic link to ../foo
> typescript: empty
> # pwd
> /root/foo
> # cd *
> # cd *
> # cd *
> # cd *
> # cd *
> # cd *
> # pwd
> /root/foo/foo/foo/foo/foo/foo/foo
> # cd *
> # cd *
> # cd *
> # pwd
> /root/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo
> # cd *
> # cd *
> # cd *
> # pwd
> /root/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo
> # exit
> exit
>
> Script done on Fri Dec 13 10:27:21 2002
>
>
> You can do this until you run out of string-space. Your "link-count"
> has something to do with something else.

Example isn't the same thing:

[pollard@merlin ~/test]$ echo "test" >target
[pollard@merlin ~/test]$ ln -s target a				- 1 link
[pollard@merlin ~/test]$ ln -s a b					- 2 links
[pollard@merlin ~/test]$ ln -s b c					- 3
[pollard@merlin ~/test]$ ln -s c d					- 4
[pollard@merlin ~/test]$ cat d
test
[pollard@merlin ~/test]$ ln -s d e					-5
[pollard@merlin ~/test]$ cat e
test
[pollard@merlin ~/test]$ ln -s e f					-6
[pollard@merlin ~/test]$ cat f
cat: f: Too many levels of symbolic links

This catches problem situations like:

[pollard@merlin ~/test]$ ln -s loop loop
[pollard@merlin ~/test]$ ls -l loop
lrwxrwxrwx    1 pollard  NA0101          4 Dec 13 10:24 loop -> loop
[pollard@merlin ~/test]$ cat loop
cat: loop: Too many levels of symbolic links

-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
